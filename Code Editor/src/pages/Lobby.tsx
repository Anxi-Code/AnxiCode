import { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { Swords, Lock, Trophy, Zap, Target, Unlock, Flame, Shield, Sparkles, TrendingUp, Crown } from 'lucide-react';
import { useAuth } from '@/contexts/AuthContext';
import { useUserProgress, PHANTOM_RANK_ORDER } from '@/hooks/useUserProgress';
import * as api from '@/services/apiService';
import { LanguageProgress, UserStats } from '@/types';
import { cn } from '@/lib/utils';
import { toast } from '@/hooks/use-toast';

const RANK_COLOR: Record<string, string> = {
  rookie: 'from-slate-500 to-slate-700',
  apprentice: 'from-emerald-500 to-teal-700',
  phantom: 'from-fuchsia-500 to-purple-700',
  apex: 'from-orange-500 to-red-700',
  zenith: 'from-cyan-400 to-blue-700',
  legendary: 'from-yellow-400 to-amber-700',
};
const LANG_GLYPH: Record<string, string> = { python: '🐍', cpp: '⚡', java: '☕', javascript: '⚛️' };
const LANG_NAME: Record<string, string> = { python: 'Python', cpp: 'C++', java: 'Java', javascript: 'JavaScript' };

export default function Lobby() {
  const navigate = useNavigate();
  const { user } = useAuth();
  const { progress, battleUnlocked, isLanguageBattleUnlocked, highestRank, loading } = useUserProgress();
  const [stats, setStats] = useState<UserStats | null>(null);

  useEffect(() => { api.getUserStats().then(setStats); }, []);

  const handleBattle = () => {
    if (!battleUnlocked) {
      toast({ title: 'Battle locked', description: 'Reach Phantom rank in at least one language to unlock battles.', variant: 'destructive' });
      return;
    }
    navigate('/arena');
  };

  return (
    <div className="p-6 md:p-10 max-w-7xl mx-auto">
      {/* Header */}
      <div className="mb-8 flex items-end justify-between flex-wrap gap-4">
        <div>
          <div className="text-[11px] uppercase tracking-[0.3em] text-muted-foreground flex items-center gap-2">
            <Sparkles className="w-3 h-3 text-warning animate-pulse" /> Welcome back, warrior
          </div>
          <h1 className="text-4xl md:text-6xl font-black mt-2 bg-gradient-to-r from-cyan-300 via-fuchsia-400 to-amber-300 bg-clip-text text-transparent drop-shadow-[0_0_30px_rgba(168,85,247,0.35)] tracking-tight">
            {user?.name || user?.user_name || 'Warrior'}
          </h1>
        </div>
        <div className={cn(
          'px-5 py-2.5 rounded-xl font-black text-xs tracking-[0.25em] uppercase text-white shadow-2xl',
          `bg-gradient-to-r ${RANK_COLOR[highestRank.name.toLowerCase()] ?? RANK_COLOR.rookie}`,
        )}>
          <Crown className="w-3.5 h-3.5 inline mr-1.5 -mt-0.5" /> {highestRank.name}
        </div>
      </div>

      {/* Hero battle card */}
      <button
        onClick={handleBattle}
        className={cn(
          'group relative w-full rounded-2xl p-8 text-left overflow-hidden transition-all border-2',
          battleUnlocked
            ? 'border-primary/50 bg-gradient-to-br from-primary/20 via-background/40 to-destructive/20 hover:border-primary hover:scale-[1.01] shadow-[0_0_50px_hsl(var(--primary)/0.3)] hover:shadow-[0_0_80px_hsl(var(--primary)/0.5)]'
            : 'border-border/40 bg-background/40 opacity-90 cursor-not-allowed',
        )}
      >
        <div className="absolute -right-10 -top-10 w-56 h-56 bg-primary/30 rounded-full blur-3xl group-hover:bg-primary/50 transition-all" />
        <div className="absolute -left-10 -bottom-10 w-56 h-56 bg-destructive/30 rounded-full blur-3xl group-hover:bg-destructive/50 transition-all" />
        {battleUnlocked && (
          <div className="absolute inset-0 opacity-30 bg-[linear-gradient(45deg,transparent_45%,rgba(255,255,255,0.18)_50%,transparent_55%)] bg-[length:200%_100%] animate-[shimmer_3s_linear_infinite]" />
        )}
        <div className="relative flex items-center gap-6">
          <div className={cn(
            'w-20 h-20 rounded-2xl flex items-center justify-center shrink-0',
            battleUnlocked ? 'bg-gradient-to-br from-primary via-fuchsia-500 to-destructive shadow-[0_0_30px_hsl(var(--primary)/0.5)]' : 'bg-muted/40',
          )}>
            {battleUnlocked
              ? <Swords className="w-10 h-10 text-primary-foreground animate-pulse" />
              : <Lock className="w-10 h-10 text-muted-foreground" />}
          </div>
          <div className="flex-1">
            <h2 className="text-2xl md:text-3xl font-black tracking-wide">
              {battleUnlocked ? 'ENTER BATTLE ARENA' : 'BATTLES LOCKED'}
            </h2>
            <p className="text-sm text-muted-foreground mt-1">
              {battleUnlocked
                ? 'Real-time 1v1 battles · AI judging · Rank-based timers'
                : 'Reach Phantom rank in any language to unlock'}
            </p>
          </div>
          {battleUnlocked && (
            <div className="hidden md:flex items-center gap-2 text-warning">
              <Flame className="w-6 h-6 animate-pulse" />
              <span className="text-xs font-black uppercase tracking-[0.2em]">Ready</span>
            </div>
          )}
        </div>
      </button>

      {/* Stats */}
      <div className="grid grid-cols-2 lg:grid-cols-4 gap-4 mt-6">
        <StatCard icon={<Trophy className="w-5 h-5" />} label="Overall Rank" value={stats?.overall_rank ?? '—'} color="warning" />
        <StatCard icon={<Zap className="w-5 h-5" />} label="Total XP" value={String(stats?.overall_xp ?? 0)} color="primary" />
        <StatCard icon={<Target className="w-5 h-5" />} label="Win Rate" value={stats ? `${Math.round(stats.win_rate * 100)}%` : '—'} color="success" />
        <StatCard icon={<Flame className="w-5 h-5" />} label="Streak" value={stats ? `${stats.streak_days}d` : '—'} color="destructive" />
      </div>

      {/* Progress per language */}
      <div className="mt-8">
        <h3 className="text-xs font-black tracking-[0.3em] text-muted-foreground uppercase mb-3 flex items-center gap-2">
          <Shield className="w-3.5 h-3.5" /> Language Mastery
        </h3>
        {loading ? (
          <div className="text-sm text-muted-foreground">Loading...</div>
        ) : (
          <div className="grid sm:grid-cols-2 lg:grid-cols-2 gap-3">
            {progress.map((p) => (
              <LanguageCard
                key={p.language}
                p={p}
                unlocked={isLanguageBattleUnlocked(p)}
                onBattle={() => navigate('/arena')}
              />
            ))}
          </div>
        )}
      </div>
    </div>
  );
}

function LanguageCard({ p, unlocked, onBattle }: { p: LanguageProgress; unlocked: boolean; onBattle: () => void }) {
  const rankKey = p.rank_name.toLowerCase();
  const pct = Math.min(100, (p.rank_order / 6) * 100);
  return (
    <div className={cn(
      'group relative rounded-xl border bg-background/50 backdrop-blur p-4 transition-all overflow-hidden',
      unlocked
        ? 'border-primary/40 hover:border-primary shadow-[0_0_25px_hsl(var(--primary)/0.15)] hover:shadow-[0_0_40px_hsl(var(--primary)/0.3)] hover:-translate-y-0.5'
        : 'border-border/40 hover:border-border',
    )}>
      <div className={cn(
        'absolute -top-10 -right-10 w-32 h-32 rounded-full blur-2xl opacity-40 group-hover:opacity-70 transition',
        `bg-gradient-to-br ${RANK_COLOR[rankKey] ?? RANK_COLOR.rookie}`,
      )} />
      <div className="relative">
        <div className="flex items-center justify-between mb-3">
          <div className="flex items-center gap-2">
            <div className="text-2xl">{LANG_GLYPH[p.language] ?? '◆'}</div>
            <div>
              <div className="font-bold leading-tight">{LANG_NAME[p.language] ?? p.language}</div>
              <div className="text-[10px] text-muted-foreground uppercase tracking-wider">Part {p.rank_part} · {p.ranks_completed} cleared</div>
            </div>
          </div>
          <span className={cn(
            'text-[10px] px-2.5 py-1 rounded-full font-black tracking-widest text-white shadow',
            `bg-gradient-to-r ${RANK_COLOR[rankKey] ?? RANK_COLOR.rookie}`,
          )}>
            {p.rank_name.toUpperCase()}
          </span>
        </div>

        <div className="mb-3">
          <div className="flex justify-between text-[10px] uppercase tracking-wider text-muted-foreground mb-1">
            <span>Rank Progress</span>
            <span className="text-foreground font-bold">{p.total_points} XP</span>
          </div>
          <div className="h-2 rounded-full bg-muted/40 overflow-hidden">
            <div
              className={cn('h-full bg-gradient-to-r transition-all', RANK_COLOR[rankKey] ?? RANK_COLOR.rookie)}
              style={{ width: `${pct}%` }}
            />
          </div>
        </div>

        <button
          onClick={() => {
            if (!unlocked) {
              toast({ title: `Battles locked for ${LANG_NAME[p.language]}`, description: 'Reach Phantom in this language to unlock.', variant: 'destructive' });
              return;
            }
            onBattle();
          }}
          className={cn(
            'w-full flex items-center justify-center gap-2 px-3 py-2 rounded-lg text-xs font-black tracking-[0.2em] transition-all uppercase',
            unlocked
              ? 'bg-gradient-to-r from-primary via-fuchsia-500 to-warning text-primary-foreground hover:scale-[1.02] shadow-[0_0_18px_hsl(var(--primary)/0.4)]'
              : 'bg-muted/30 text-muted-foreground border border-border/40',
          )}
        >
          {unlocked ? <Unlock className="w-3.5 h-3.5" /> : <Lock className="w-3.5 h-3.5" />}
          {unlocked ? 'Enter Battle' : 'Locked'}
        </button>
      </div>
    </div>
  );
}

function StatCard({ icon, label, value, color }: { icon: React.ReactNode; label: string; value: string; color: 'primary' | 'warning' | 'success' | 'destructive' }) {
  const colorMap = {
    primary: 'text-primary bg-primary/10 border-primary/30 shadow-[0_0_20px_hsl(var(--primary)/0.15)]',
    warning: 'text-warning bg-warning/10 border-warning/30 shadow-[0_0_20px_hsl(var(--warning)/0.15)]',
    success: 'text-success bg-success/10 border-success/30 shadow-[0_0_20px_hsl(var(--success)/0.15)]',
    destructive: 'text-destructive bg-destructive/10 border-destructive/30 shadow-[0_0_20px_hsl(var(--destructive)/0.15)]',
  };
  return (
    <div className="rounded-xl border border-border/40 bg-background/40 backdrop-blur p-4 flex items-center gap-3 hover:-translate-y-0.5 transition">
      <div className={cn('w-10 h-10 rounded-lg flex items-center justify-center border', colorMap[color])}>{icon}</div>
      <div className="min-w-0">
        <div className="text-[10px] uppercase tracking-widest text-muted-foreground">{label}</div>
        <div className="text-lg font-black capitalize truncate">{value}</div>
      </div>
    </div>
  );
}
