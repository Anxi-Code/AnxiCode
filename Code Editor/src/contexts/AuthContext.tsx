// Frontend-only auth context. Stores a token + profile in localStorage.
// Real verification, registration & session handling is done by the
// FastAPI backend (see src/services/apiService.ts).
import { createContext, useContext, useEffect, useState, ReactNode } from 'react';
import * as api from '@/services/apiService';
import { UserProfile } from '@/types';

interface AuthContextValue {
  user: UserProfile | null;
  loading: boolean;
  signIn: (email: string, password: string) => Promise<{ error: string | null }>;
  signUp: (email: string, password: string, userName: string, name: string) => Promise<{ error: string | null }>;
  forgotPassword: (email: string) => Promise<{ error: string | null }>;
  signOut: () => Promise<void>;
}

const AuthContext = createContext<AuthContextValue | undefined>(undefined);
const PROFILE_KEY = 'anxicode_profile';

export const AuthProvider = ({ children }: { children: ReactNode }) => {
  const [user, setUser] = useState<UserProfile | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const raw = localStorage.getItem(PROFILE_KEY);
    const token = api.getToken();
    if (raw && token) {
      try { setUser(JSON.parse(raw)); } catch { /* ignore */ }
    }
    setLoading(false);
  }, []);

  const persist = (u: UserProfile, token: string) => {
    api.setToken(token);
    localStorage.setItem(PROFILE_KEY, JSON.stringify(u));
    setUser(u);
  };

  const signIn = async (email: string, password: string) => {
    try {
      const { user: u, token } = await api.login(email, password);
      persist(u, token);
      return { error: null };
    } catch (e: any) {
      return { error: e?.message ?? 'Login failed' };
    }
  };

  const signUp = async (email: string, password: string, userName: string, name: string) => {
    try {
      const { user: u, token } = await api.register({ email, password, user_name: userName, name });
      persist(u, token);
      return { error: null };
    } catch (e: any) {
      return { error: e?.message ?? 'Sign up failed' };
    }
  };

  const forgotPassword = async (email: string) => {
    try { await api.forgotPassword(email); return { error: null }; }
    catch (e: any) { return { error: e?.message ?? 'Request failed' }; }
  };

  const signOut = async () => {
    await api.logout();
    localStorage.removeItem(PROFILE_KEY);
    setUser(null);
  };

  return (
    <AuthContext.Provider value={{ user, loading, signIn, signUp, forgotPassword, signOut }}>
      {children}
    </AuthContext.Provider>
  );
};

export const useAuth = () => {
  const ctx = useContext(AuthContext);
  if (!ctx) throw new Error('useAuth must be used within AuthProvider');
  return ctx;
};
