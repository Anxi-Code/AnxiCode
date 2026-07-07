import { useEffect, useState } from 'react';
import { Trophy, Crown, Medal, Award, Loader2 } from 'lucide-react';
import * as api from '@/services/apiService';
import { useAuth } from '@/contexts/AuthContext';
import { LeaderboardEntry } from '@/types';
import { cn } from '@/lib/utils';

export default function Leaderboard() {
  const { user } = useAuth();
  const [rows, setRows] = useState<LeaderboardEntry[]>([]);
  const [loading, setLoading] = useState(true);
  const [scope, setScope] = useState<'global' | 'friends'>('global');

  useEffect(() => {
    setLoading(true);
    api.getLeaderboard(scope).then((d) => { setRows(d); setLoading(false); });
  }, [scope]);

  return (
    <div className="p-6 md:p-10 max-w-5xl mx-auto">
      <div className="flex items-center justify-between mb-8 flex-wrap gap-4">
        <div className="flex items-center gap-3">
          <div className="relative">
            <Trophy className="w-9 h-9 text-warning" />
            <div className="absolute inset-0 bg-warning/40 blur-2xl rounded-full" />
          </div>
          <div>
            <div className="text-[11px] uppercase tracking-[0.3em] text-muted-foreground">Hall of Champions</div>
            <h1 className="text-3xl md:text-4xl font-black tracking-tight bg-gradient-to-r from-warning via-amber-400 to-orange-500 bg-clip-text text-transparent">
              Global Leaderboard
            </h1>
          </div>
        </div>

        <div className="flex rounded-lg overflow-hidden border border-border/40 bg-background/40">
          {(['global', 'friends'] as const).map((s) => (
            <button
              key={s}
              onClick={() => setScope(s)}
              className={cn(
                'px-4 py-2 text-xs font-bold tracking-widest uppercase transition',
                scope === s
                  ? 'bg-primary/20 text-primary'
                  : 'text-muted-foreground hover:text-foreground',
              )}
            >
              {s}
            </button>
          ))}
        </div>
      </div>

      {loading ? (
        <div className="flex items-center gap-2 text-sm text-muted-foreground">
          <Loader2 className="w-4 h-4 animate-spin" /> Loading rankings...
        </div>
      ) : rows.length === 0 ? (
        <div className="rounded-xl border border-border/40 bg-background/40 p-8 text-center text-sm text-muted-foreground">
          No rankings yet.
        </div>
      ) : (
        <>
          {/* Podium */}
          <div className="grid grid-cols-3 gap-3 mb-6">
            {[rows[1], rows[0], rows[2]].filter(Boolean).map((r) => (
              <PodiumCard key={r.user_id} row={r} isMe={r.user_id === user?.id} />
            ))}
          </div>

          {/* List */}
          <div className="space-y-2">
            {rows.slice(3).map((r, i) => {
              const isMe = r.user_id === user?.id;
              return (
                <div
                  key={r.user_id}
                  className={cn(
                    'flex items-center gap-4 rounded-xl border p-4 transition-all animate-in fade-in slide-in-from-bottom-2',
                    isMe
                      ? 'border-primary/60 bg-primary/10 shadow-[0_0_30px_hsl(var(--primary)/0.25)]'
                      : 'border-border/40 bg-background/40 hover:border-border',
                  )}
                  style={{ animationDelay: `${i * 40}ms` }}
                >
                  <div className="w-9 h-9 rounded-full bg-muted/40 flex items-center justify-center text-xs font-black text-muted-foreground">
                    {r.rank}
                  </div>
                  <div className="flex-1 min-w-0">
                    <div className="font-bold truncate">
                      {r.user_name} {isMe && <span className="text-xs text-primary">(you)</span>}
                    </div>
                    <div className="text-[10px] uppercase tracking-widest text-muted-foreground">{r.highest_rank} · {r.wins} wins</div>
                  </div>
                  <div className="text-right">
                    <div className="text-lg font-black text-warning">{r.total_xp.toLocaleString()}</div>
                    <div className="text-[10px] uppercase tracking-widest text-muted-foreground">XP</div>
                  </div>
                </div>
              );
            })}
          </div>
        </>
      )}
    </div>
  );
}

function PodiumCard({ row, isMe }: { row: LeaderboardEntry; isMe: boolean }) {
  const icon = row.rank === 1 ? <Crown className="w-7 h-7 text-warning" /> :
               row.rank === 2 ? <Medal className="w-7 h-7 text-slate-300" /> :
               <Award className="w-7 h-7 text-orange-400" />;
  const grad = row.rank === 1 ? 'from-warning/30 via-amber-500/10 to-transparent border-warning/50' :
               row.rank === 2 ? 'from-slate-400/20 via-slate-500/10 to-transparent border-slate-400/40' :
               'from-orange-500/20 via-orange-600/10 to-transparent border-orange-500/40';
  return (
    <div className={cn(
      'rounded-2xl border-2 p-4 text-center bg-gradient-to-b backdrop-blur relative overflow-hidden',
      grad,
      row.rank === 1 && '-translate-y-3 shadow-[0_0_40px_hsl(var(--warning)/0.4)]',
      isMe && 'ring-2 ring-primary/60',
    )}>
      <div className="flex justify-center mb-2">{icon}</div>
      <div className="font-black truncate">{row.user_name}{isMe && <span className="text-primary"> (you)</span>}</div>
      <div className="text-[10px] uppercase tracking-widest text-muted-foreground">{row.highest_rank}</div>
      <div className="mt-2 text-xl font-black text-warning">{row.total_xp.toLocaleString()}</div>
      <div className="text-[10px] text-muted-foreground uppercase tracking-widest">XP · {row.wins} W</div>
    </div>
  );
}
