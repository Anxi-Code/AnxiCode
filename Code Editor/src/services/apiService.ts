// ============================================================
// Core API service — placeholder methods for the FastAPI backend.
// ------------------------------------------------------------
// All real network calls live here. Each method currently returns
// MOCK data so the UI is fully usable without a backend. When you
// wire FastAPI, replace each `return mockX(...)` with a real fetch
// against {CORE_API_URL}/<endpoint>.
//
// Configure the base URL in: src/config/api.ts
// ============================================================
import { CORE_API_URL, AUTH_TOKEN_STORAGE_KEY } from '@/config/api';
import {
  Achievement,
  BattleProblem,
  LanguageProgress,
  LeaderboardEntry,
  UserProfile,
  UserStats,
} from '@/types';
import {
  MOCK_ACHIEVEMENTS,
  MOCK_LEADERBOARD,
  MOCK_PROBLEM,
  MOCK_PROGRESS,
  MOCK_PROFILE,
  MOCK_STATS,
} from '@/mocks/data';

// ---- token helpers ----
export const getToken = () => localStorage.getItem(AUTH_TOKEN_STORAGE_KEY);
export const setToken = (t: string) => localStorage.setItem(AUTH_TOKEN_STORAGE_KEY, t);
export const clearToken = () => localStorage.removeItem(AUTH_TOKEN_STORAGE_KEY);

// ---- generic fetcher (used once the backend is live) ----
async function request<T>(path: string, init: RequestInit = {}): Promise<T> {
  const token = getToken();
  const res = await fetch(`${CORE_API_URL}${path}`, {
    ...init,
    headers: {
      'Content-Type': 'application/json',
      ...(token ? { Authorization: `Bearer ${token}` } : {}),
      ...(init.headers || {}),
    },
  });
  const text = await res.text();
  const data = text ? JSON.parse(text) : ({} as T);
  if (!res.ok) throw new Error((data as any)?.detail || `Request failed (${res.status})`);
  return data as T;
}

const delay = (ms = 350) => new Promise((r) => setTimeout(r, ms));

// ============================================================
// AUTH — UI-only, FastAPI handles real verification
// ============================================================
export interface AuthResponse { token: string; user: UserProfile; }

export async function login(_email: string, _password: string): Promise<AuthResponse> {
  // TODO: replace with: return request('/auth/login', { method: 'POST', body: JSON.stringify({ email, password }) });
  await delay();
  return { token: 'mock-token', user: MOCK_PROFILE };
}

export async function register(_payload: {
  email: string;
  password: string;
  user_name: string;
  name: string;
}): Promise<AuthResponse> {
  // TODO: return request('/auth/register', { method: 'POST', body: JSON.stringify(payload) });
  await delay();
  return { token: 'mock-token', user: { ...MOCK_PROFILE, ..._payload, id: 'new-user' } };
}

export async function forgotPassword(_email: string): Promise<{ ok: true }> {
  // TODO: return request('/auth/forgot-password', { method: 'POST', body: JSON.stringify({ email }) });
  await delay();
  return { ok: true };
}

export async function logout(): Promise<void> {
  // TODO: await request('/auth/logout', { method: 'POST' });
  clearToken();
}

// ============================================================
// PROFILE / STATS / PROGRESS / ACHIEVEMENTS
// ============================================================
export async function getProfile(): Promise<UserProfile> {
  // TODO: return request('/me');
  await delay();
  return MOCK_PROFILE;
}

export async function getUserStats(): Promise<UserStats> {
  // TODO: return request('/me/stats');
  await delay();
  return MOCK_STATS;
}

export async function getLanguageProgress(): Promise<LanguageProgress[]> {
  // TODO: return request('/me/progress');
  await delay();
  return MOCK_PROGRESS;
}

export async function getAchievements(): Promise<Achievement[]> {
  // TODO: return request('/me/achievements');
  await delay();
  return MOCK_ACHIEVEMENTS;
}

// ============================================================
// LEADERBOARD
// ============================================================
export async function getLeaderboard(_scope: 'global' | 'friends' = 'global'): Promise<LeaderboardEntry[]> {
  // TODO: return request(`/leaderboard?scope=${scope}`);
  await delay();
  return MOCK_LEADERBOARD;
}

// ============================================================
// PROBLEMS (read-only; backend supplies all data)
// ============================================================
export async function getProblem(problemId: string): Promise<BattleProblem> {
  // TODO: return request(`/problems/${problemId}`);
  await delay();
  return { ...MOCK_PROBLEM, problem_id: problemId };
}
