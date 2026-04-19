import { useState, useRef, useEffect, KeyboardEvent, ClipboardEvent, ChangeEvent } from 'react';
import { Swords, Loader2, AlertCircle } from 'lucide-react';
import { supabase } from '@/lib/supabase';
import { cn } from '@/lib/utils';

export interface BattleData {
  battleId: string;
  user1: string;
  user2: string;
}

interface BattleEntryProps {
  onEnter: (data: BattleData) => void;
}

export const BattleEntry = ({ onEnter }: BattleEntryProps) => {
  const [digits, setDigits] = useState<string[]>(['', '', '', '', '', '']);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const inputsRef = useRef<(HTMLInputElement | null)[]>([]);

  useEffect(() => {
    inputsRef.current[0]?.focus();
  }, []);

  const code = digits.join('');
  const isComplete = code.length === 6 && digits.every((d) => d !== '');

  const handleChange = (idx: number, e: ChangeEvent<HTMLInputElement>) => {
    const val = e.target.value.replace(/[^0-9]/g, '');
    if (!val) {
      const next = [...digits];
      next[idx] = '';
      setDigits(next);
      return;
    }
    const next = [...digits];
    next[idx] = val[val.length - 1];
    setDigits(next);
    if (idx < 5) inputsRef.current[idx + 1]?.focus();
  };

  const handleKeyDown = (idx: number, e: KeyboardEvent<HTMLInputElement>) => {
    if (e.key === 'Backspace' && !digits[idx] && idx > 0) {
      inputsRef.current[idx - 1]?.focus();
      const next = [...digits];
      next[idx - 1] = '';
      setDigits(next);
    } else if (e.key === 'ArrowLeft' && idx > 0) {
      inputsRef.current[idx - 1]?.focus();
    } else if (e.key === 'ArrowRight' && idx < 5) {
      inputsRef.current[idx + 1]?.focus();
    } else if (e.key === 'Enter' && isComplete) {
      handleSubmit();
    }
  };

  const handlePaste = (e: ClipboardEvent<HTMLInputElement>) => {
    e.preventDefault();
    const pasted = e.clipboardData.getData('text').replace(/[^0-9]/g, '').slice(0, 6);
    if (!pasted) return;
    const next = ['', '', '', '', '', ''];
    for (let i = 0; i < pasted.length; i++) next[i] = pasted[i];
    setDigits(next);
    const focusIdx = Math.min(pasted.length, 5);
    inputsRef.current[focusIdx]?.focus();
  };

  const handleSubmit = async () => {
    if (!isComplete || loading) return;
    setError(null);
    setLoading(true);

    try {
      // STEP 1 — FIND BATTLE
      const { data: battle, error: battleErr } = await supabase
        .from('battles')
        .select('id')
        .eq('join_code', code)
        .single();

      if (battleErr || !battle) {
        setError('Invalid battle code. Try again.');
        setLoading(false);
        return;
      }

      // STEP 2 — GET PARTICIPANTS
      const { data: participants, error: partErr } = await supabase
        .from('battle_participants')
        .select('user_id')
        .eq('battle_id', battle.id);

      if (partErr) {
        setError('Network error. Please try again.');
        setLoading(false);
        return;
      }

      if (!participants || participants.length < 2) {
        setError('Battle not ready yet. Waiting for opponent.');
        setLoading(false);
        return;
      }

      // STEP 3 — GET USER DETAILS
      const userIds = participants.map((p) => p.user_id);
      const { data: users, error: usersErr } = await supabase
        .from('profiles')
        .select('id, user_name')
        .in('id', userIds);

      if (usersErr || !users || users.length < 2) {
        setError('Could not load participants. Try again.');
        setLoading(false);
        return;
      }

      // STEP 4 — ENTER BATTLE MODE
      onEnter({
        battleId: battle.id,
        user1: users[0].user_name,
        user2: users[1].user_name,
      });
    } catch (err) {
      console.error('[BattleEntry] error:', err);
      setError('Network error. Please try again.');
      setLoading(false);
    }
  };

  return (
    <div className="fixed inset-0 z-50 min-h-screen bg-[radial-gradient(ellipse_at_top_right,_hsl(var(--primary)/0.2)_0%,_transparent_50%),radial-gradient(ellipse_at_bottom_left,_hsl(var(--destructive)/0.15)_0%,_transparent_50%),hsl(var(--background))] flex items-center justify-center p-4 overflow-hidden">
      {/* Animated background orbs */}
      <div className="absolute inset-0 overflow-hidden pointer-events-none">
        <div className="absolute top-20 right-[15%] w-40 h-40 bg-primary/30 rounded-full blur-3xl animate-float" />
        <div className="absolute bottom-32 left-[15%] w-48 h-48 bg-destructive/25 rounded-full blur-3xl animate-float-delayed" />
        <div className="absolute top-1/2 left-1/2 -translate-x-1/2 w-32 h-32 bg-warning/20 rounded-full blur-3xl animate-float-slow" />
      </div>

      {/* Grid overlay */}
      <div
        className="absolute inset-0 opacity-[0.07] pointer-events-none"
        style={{
          backgroundImage:
            'linear-gradient(hsl(var(--primary)) 1px, transparent 1px), linear-gradient(90deg, hsl(var(--primary)) 1px, transparent 1px)',
          backgroundSize: '40px 40px',
        }}
      />

      <div className="relative z-10 w-full max-w-md">
        <div className="glass-editor rounded-2xl border border-primary/20 p-8 shadow-[0_0_60px_hsl(var(--primary)/0.25)]">
          {/* Title */}
          <div className="flex flex-col items-center mb-8">
            <div className="relative mb-4">
              <Swords className="w-12 h-12 text-primary animate-pulse" strokeWidth={1.5} />
              <div className="absolute inset-0 bg-primary/30 blur-2xl rounded-full" />
            </div>
            <h1 className="text-3xl font-bold tracking-wider text-center bg-gradient-to-r from-primary via-warning to-destructive bg-clip-text text-transparent">
              ENTER BATTLE ARENA
            </h1>
            <p className="text-sm text-muted-foreground mt-2 tracking-wide">
              Enter your 6-digit battle code
            </p>
          </div>

          {/* OTP inputs */}
          <div className="flex justify-center gap-2 mb-6" onPaste={handlePaste}>
            {digits.map((d, i) => (
              <input
                key={i}
                ref={(el) => (inputsRef.current[i] = el)}
                type="text"
                inputMode="numeric"
                maxLength={1}
                value={d}
                disabled={loading}
                onChange={(e) => handleChange(i, e)}
                onKeyDown={(e) => handleKeyDown(i, e)}
                className={cn(
                  'w-12 h-14 text-center text-2xl font-bold font-mono rounded-lg',
                  'bg-background/40 backdrop-blur-sm border-2 transition-all duration-200',
                  'focus:outline-none focus:scale-110',
                  d
                    ? 'border-primary text-primary shadow-[0_0_20px_hsl(var(--primary)/0.4)]'
                    : 'border-border/50 text-foreground',
                  'focus:border-primary focus:shadow-[0_0_25px_hsl(var(--primary)/0.5)]',
                  error && 'border-destructive shadow-[0_0_20px_hsl(var(--destructive)/0.4)]'
                )}
              />
            ))}
          </div>

          {/* Error message */}
          {error && (
            <div className="flex items-center gap-2 mb-4 px-4 py-3 rounded-lg bg-destructive/10 border border-destructive/30 text-destructive text-sm animate-in fade-in slide-in-from-top-2">
              <AlertCircle className="w-4 h-4 flex-shrink-0" />
              <span>{error}</span>
            </div>
          )}

          {/* Submit button */}
          <button
            onClick={handleSubmit}
            disabled={!isComplete || loading}
            className={cn(
              'w-full h-12 rounded-lg font-bold text-base tracking-widest uppercase',
              'transition-all duration-300 relative overflow-hidden',
              'disabled:opacity-40 disabled:cursor-not-allowed',
              isComplete && !loading
                ? 'bg-gradient-to-r from-primary via-primary to-primary/80 text-primary-foreground shadow-[0_0_30px_hsl(var(--primary)/0.5)] hover:shadow-[0_0_45px_hsl(var(--primary)/0.7)] hover:scale-[1.02] active:scale-[0.98]'
                : 'bg-muted/30 text-muted-foreground'
            )}
          >
            {loading ? (
              <span className="flex items-center justify-center gap-2">
                <Loader2 className="w-5 h-5 animate-spin" />
                Joining Battle...
              </span>
            ) : (
              <span className="flex items-center justify-center gap-2">
                <Swords className="w-5 h-5" />
                Enter Battle
              </span>
            )}
          </button>

          <p className="text-xs text-center text-muted-foreground/70 mt-6 tracking-wide">
            Prepare your weapons. May the best coder win.
          </p>
        </div>
      </div>
    </div>
  );
};
