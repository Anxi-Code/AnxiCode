// Matchmaking UI shell — calls the FastAPI battle service via
// src/services/battleService.ts. No realtime DB code in the frontend.
import { useEffect, useState } from 'react';
import { Loader2, Swords, X, Zap } from 'lucide-react';
import { useAuth } from '@/contexts/AuthContext';
import { useUserProgress, PHANTOM_RANK_ORDER, LanguageProgress } from '@/hooks/useUserProgress';
import { cn } from '@/lib/utils';
import { findMatch, BattleSession } from '@/services/battleService';

const RANK_ORDER_TO_NAME: Record<number, string> = {
  3: 'phantom', 4: 'apex', 5: 'zenith', 6: 'legendary',
};
const LANG_NAME: Record<string, string> = { python: 'Python', cpp: 'C++', java: 'Java', javascript: 'JavaScript' };

interface MatchmakingProps {
  onMatchFound: (session: BattleSession) => void;
}

export const Matchmaking = ({ onMatchFound }: MatchmakingProps) => {
  const { user } = useAuth();
  const { progress, loading: progLoading } = useUserProgress();
  const [selectedLp, setSelectedLp] = useState<LanguageProgress | null>(null);
  const [queueing, setQueueing] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const unlocked = progress.filter((p) => p.rank_order >= PHANTOM_RANK_ORDER);

  useEffect(() => {
    if (!selectedLp && unlocked.length > 0) setSelectedLp(unlocked[0]);
  }, [unlocked, selectedLp]);

  const handleFindMatch = async () => {
    if (!user || !selectedLp) return;
    setError(null);
    setQueueing(true);
    try {
      const rank = RANK_ORDER_TO_NAME[selectedLp.rank_order] ?? 'phantom';
      const session = await findMatch({ language: selectedLp.language, rank });
      onMatchFound(session);
    } catch (e: any) {
      setError(e?.message ?? 'Failed to find match');
      setQueueing(false);
    }
  };

  if (queueing) {
    return (
      <div className="fixed inset-0 z-50 flex items-center justify-center bg-background/70 backdrop-blur-xl">
        <div className="absolute inset-0 overflow-hidden pointer-events-none">
          <div className="absolute top-1/3 left-1/3 w-96 h-96 bg-primary/20 rounded-full blur-3xl animate-pulse" />
          <div className="absolute bottom-1/4 right-1/4 w-96 h-96 bg-destructive/20 rounded-full blur-3xl animate-pulse" />
        </div>
        <div className="relative z-10 glass-editor rounded-2xl border border-primary/30 p-10 max-w-md w-full mx-4 text-center shadow-[0_0_80px_hsl(var(--primary)/0.35)]">
          <div className="relative mx-auto mb-6 w-24 h-24">
            <div className="absolute inset-0 rounded-full border-2 border-primary/40 animate-ping" />
            <div className="absolute inset-2 rounded-full border-2 border-primary/60 animate-ping [animation-delay:0.4s]" />
            <div className="absolute inset-0 flex items-center justify-center">
              <Swords className="w-12 h-12 text-primary animate-pulse" />
            </div>
          </div>
          <h2 className="text-2xl font-black tracking-wider bg-gradient-to-r from-primary via-warning to-destructive bg-clip-text text-transparent">
            SEARCHING OPPONENT
          </h2>
          <p className="text-sm text-muted-foreground mt-2">
            {LANG_NAME[selectedLp?.language ?? ''] ?? selectedLp?.language?.toUpperCase()} · {RANK_ORDER_TO_NAME[selectedLp?.rank_order ?? 3]?.toUpperCase()}
          </p>
          <div className="flex items-center justify-center gap-2 mt-6 text-xs uppercase tracking-widest text-muted-foreground">
            <Loader2 className="w-3 h-3 animate-spin" /> Matching with backend
          </div>
          <button
            onClick={() => setQueueing(false)}
            className="mt-8 px-5 py-2 rounded-lg text-xs font-bold uppercase tracking-widest border border-border/50 hover:bg-destructive/10 hover:border-destructive/50 hover:text-destructive transition"
          >
            <X className="w-3 h-3 inline mr-1" /> Cancel
          </button>
        </div>
      </div>
    );
  }

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center p-4 overflow-hidden bg-[radial-gradient(ellipse_at_top_right,_hsl(var(--primary)/0.2)_0%,_transparent_50%),radial-gradient(ellipse_at_bottom_left,_hsl(var(--destructive)/0.15)_0%,_transparent_50%),hsl(var(--background))]">
      <div className="absolute inset-0 overflow-hidden pointer-events-none">
        <div className="absolute top-20 right-[15%] w-40 h-40 bg-primary/30 rounded-full blur-3xl animate-float" />
        <div className="absolute bottom-32 left-[15%] w-48 h-48 bg-destructive/25 rounded-full blur-3xl animate-float-delayed" />
      </div>

      <div className="relative z-10 w-full max-w-lg">
        <div className="glass-editor rounded-2xl border border-primary/30 p-8 shadow-[0_0_60px_hsl(var(--primary)/0.25)]">
          <div className="flex flex-col items-center mb-6">
            <Swords className="w-12 h-12 text-primary animate-pulse" strokeWidth={1.5} />
            <h1 className="text-3xl font-black tracking-[0.15em] mt-3 bg-gradient-to-r from-cyan-300 via-fuchsia-400 to-amber-300 bg-clip-text text-transparent">
              BATTLE ARENA
            </h1>
            <p className="text-sm text-muted-foreground mt-1">Choose your battlefield</p>
          </div>

          {progLoading ? (
            <div className="text-center text-sm text-muted-foreground py-8">Loading...</div>
          ) : unlocked.length === 0 ? (
            <div className="text-center text-sm text-muted-foreground py-8">
              No languages unlocked for battle yet.<br />
              Reach <span className="text-primary font-bold">Phantom</span> rank in any language.
            </div>
          ) : (
            <>
              <div className="grid gap-2 mb-6">
                {unlocked.map((lp) => {
                  const rk = RANK_ORDER_TO_NAME[lp.rank_order] ?? 'phantom';
                  const selected = selectedLp?.language === lp.language;
                  return (
                    <button
                      key={lp.language}
                      onClick={() => setSelectedLp(lp)}
                      className={cn(
                        'w-full flex items-center justify-between px-4 py-3 rounded-xl border-2 transition-all text-left',
                        selected
                          ? 'border-primary bg-primary/10 shadow-[0_0_25px_hsl(var(--primary)/0.3)]'
                          : 'border-border/40 hover:border-primary/40 bg-background/40',
                      )}
                    >
                      <div>
                        <div className="font-bold">{LANG_NAME[lp.language] ?? lp.language}</div>
                        <div className="text-[10px] uppercase tracking-widest text-muted-foreground">
                          {rk} · {lp.total_points} XP
                        </div>
                      </div>
                      <Zap className={cn('w-5 h-5', selected ? 'text-primary' : 'text-muted-foreground')} />
                    </button>
                  );
                })}
              </div>

              {error && (
                <div className="mb-4 px-4 py-2 rounded-lg bg-destructive/10 border border-destructive/30 text-destructive text-xs">{error}</div>
              )}

              <button
                onClick={handleFindMatch}
                disabled={!selectedLp}
                className={cn(
                  'w-full h-12 rounded-lg font-black tracking-[0.2em] uppercase',
                  'bg-gradient-to-r from-primary via-fuchsia-500 to-warning text-primary-foreground',
                  'shadow-[0_0_30px_hsl(var(--primary)/0.5)] hover:shadow-[0_0_45px_hsl(var(--primary)/0.7)]',
                  'hover:scale-[1.02] active:scale-[0.98] transition-all',
                  'disabled:opacity-40 disabled:cursor-not-allowed disabled:hover:scale-100',
                )}
              >
                <Swords className="w-5 h-5 inline mr-2" /> Find Match
              </button>
            </>
          )}
        </div>
      </div>
    </div>
  );
};
