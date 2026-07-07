import { useState, FormEvent } from 'react';
import { Navigate } from 'react-router-dom';
import { Swords, Loader2, Mail, Lock, User as UserIcon, AtSign, Eye, EyeOff, ArrowLeft } from 'lucide-react';
import { BgGradient } from '@/components/os/BgGradient';
import { useAuth } from '@/contexts/AuthContext';
import { cn } from '@/lib/utils';
import { toast } from '@/hooks/use-toast';

type Mode = 'login' | 'signup' | 'forgot';

export default function AuthPage() {
  const { user, loading, signIn, signUp, forgotPassword } = useAuth();
  const [mode, setMode] = useState<Mode>('login');
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [showPassword, setShowPassword] = useState(false);
  const [userName, setUserName] = useState('');
  const [name, setName] = useState('');
  const [submitting, setSubmitting] = useState(false);

  if (loading) return null;
  if (user) return <Navigate to="/" replace />;

  const handleSubmit = async (e: FormEvent) => {
    e.preventDefault();
    setSubmitting(true);
    let res: { error: string | null };
    if (mode === 'login') res = await signIn(email, password);
    else if (mode === 'signup') res = await signUp(email, password, userName, name || userName);
    else res = await forgotPassword(email);
    setSubmitting(false);
    if (res.error) {
      toast({ title: 'Request failed', description: res.error, variant: 'destructive' });
      return;
    }
    if (mode === 'forgot') {
      toast({ title: 'Reset link sent', description: 'Check your inbox to continue.' });
      setMode('login');
    }
  };

  const title =
    mode === 'login' ? 'ENTER THE ARENA' :
    mode === 'signup' ? 'JOIN THE BATTLE' :
    'RECOVER ACCESS';
  const subtitle =
    mode === 'login' ? 'Sign in to continue your journey' :
    mode === 'signup' ? 'Forge your warrior profile' :
    "We'll send a reset link to your email";

  return (
    <div className="min-h-screen flex items-center justify-center p-4 relative overflow-hidden">
      <BgGradient />
      <div className="absolute top-20 right-[15%] w-48 h-48 bg-primary/30 rounded-full blur-3xl animate-float pointer-events-none" />
      <div className="absolute bottom-32 left-[15%] w-56 h-56 bg-destructive/25 rounded-full blur-3xl animate-float-delayed pointer-events-none" />
      <div className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-[600px] h-[600px] rounded-full bg-fuchsia-500/10 blur-3xl animate-float-slow pointer-events-none" />

      <div className="relative z-10 w-full max-w-md">
        <div className="glass-editor rounded-2xl border border-primary/30 p-8 shadow-[0_0_80px_hsl(var(--primary)/0.25)] backdrop-blur-2xl">
          <div className="flex flex-col items-center mb-6">
            <div className="relative mb-3">
              <div className="w-14 h-14 rounded-2xl bg-gradient-to-br from-primary via-fuchsia-500 to-warning flex items-center justify-center shadow-[0_0_40px_hsl(var(--primary)/0.6)]">
                <Swords className="w-7 h-7 text-primary-foreground" />
              </div>
            </div>
            <h1 className="text-2xl font-black tracking-[0.15em] bg-gradient-to-r from-cyan-300 via-fuchsia-400 to-amber-300 bg-clip-text text-transparent">
              {title}
            </h1>
            <p className="text-xs text-muted-foreground mt-2">{subtitle}</p>
          </div>

          <form onSubmit={handleSubmit} className="space-y-3">
            {mode === 'signup' && (
              <>
                <Field icon={<UserIcon className="w-4 h-4" />} placeholder="Full name" value={name} onChange={setName} />
                <Field icon={<AtSign className="w-4 h-4" />} placeholder="Username" value={userName} onChange={setUserName} required />
              </>
            )}
            <Field icon={<Mail className="w-4 h-4" />} placeholder="Email" type="email" value={email} onChange={setEmail} required />
            {mode !== 'forgot' && (
              <Field
                icon={<Lock className="w-4 h-4" />}
                placeholder="Password"
                type={showPassword ? 'text' : 'password'}
                value={password}
                onChange={setPassword}
                required
                trailing={
                  <button
                    type="button"
                    onClick={() => setShowPassword((v) => !v)}
                    className="text-muted-foreground hover:text-primary transition-colors"
                    aria-label={showPassword ? 'Hide password' : 'Show password'}
                    tabIndex={-1}
                  >
                    {showPassword ? <EyeOff className="w-4 h-4" /> : <Eye className="w-4 h-4" />}
                  </button>
                }
              />
            )}

            {mode === 'login' && (
              <button
                type="button"
                onClick={() => setMode('forgot')}
                className="block ml-auto text-[11px] text-muted-foreground hover:text-primary transition"
              >
                Forgot password?
              </button>
            )}

            <button
              type="submit"
              disabled={submitting}
              className={cn(
                'w-full h-11 rounded-lg font-black tracking-[0.2em] uppercase text-sm',
                'bg-gradient-to-r from-primary via-fuchsia-500 to-warning text-primary-foreground',
                'shadow-[0_0_30px_hsl(var(--primary)/0.5)] hover:shadow-[0_0_50px_hsl(var(--primary)/0.7)]',
                'transition-all hover:scale-[1.02] active:scale-[0.98] disabled:opacity-50',
              )}
            >
              {submitting ? <Loader2 className="w-5 h-5 animate-spin mx-auto" /> :
                mode === 'login' ? 'Sign In' :
                mode === 'signup' ? 'Create Account' :
                'Send Reset Link'}
            </button>
          </form>

          <div className="mt-5 text-center text-xs">
            {mode === 'forgot' ? (
              <button onClick={() => setMode('login')} className="inline-flex items-center gap-1 text-muted-foreground hover:text-primary transition">
                <ArrowLeft className="w-3 h-3" /> Back to sign in
              </button>
            ) : (
              <button
                onClick={() => setMode(mode === 'login' ? 'signup' : 'login')}
                className="text-muted-foreground hover:text-primary transition"
              >
                {mode === 'login' ? "No account? Sign up" : 'Already a warrior? Sign in'}
              </button>
            )}
          </div>
        </div>
      </div>
    </div>
  );
}

function Field({ icon, trailing, ...props }: {
  icon: React.ReactNode;
  trailing?: React.ReactNode;
  placeholder: string;
  value: string;
  onChange: (v: string) => void;
  type?: string;
  required?: boolean;
}) {
  return (
    <div className="relative group">
      <div className="absolute left-3 top-1/2 -translate-y-1/2 text-muted-foreground group-focus-within:text-primary transition-colors">
        {icon}
      </div>
      <input
        type={props.type ?? 'text'}
        required={props.required}
        placeholder={props.placeholder}
        value={props.value}
        onChange={(e) => props.onChange(e.target.value)}
        className={`w-full h-11 pl-10 ${trailing ? 'pr-10' : 'pr-3'} rounded-lg bg-background/40 border-2 border-border/50 focus:border-primary focus:outline-none focus:shadow-[0_0_20px_hsl(var(--primary)/0.25)] transition-all text-sm`}
      />
      {trailing && <div className="absolute right-3 top-1/2 -translate-y-1/2">{trailing}</div>}
    </div>
  );
}
