import { useEffect, useState } from 'react';
import { Mail, AtSign, Sparkles, Trophy, Zap, Flame, Target, Brain, Award, Lock } from 'lucide-react';
import { useAuth } from '@/contexts/AuthContext';
import { useUserProgress, PHANTOM_RANK_ORDER } from '@/hooks/useUserProgress';
import * as api from '@/services/apiService';
import { Achievement, UserStats } from '@/types';
import { cn } from '@/lib/utils';

const RANK_COLOR: Record<string, string> = {
  rookie: 'from-slate-500 to-slate-700',
  apprentice: 'from-emerald-500 to-teal-700',
  phantom: 'from-fuchsia-500 to-purple-700',
  apex: 'from-orange-500 to-red-700',
  zenith: 'from-cyan-400 to-blue-700',
  legendary: 'from-yellow-400 to-amber-700',
};
const LANG_NAME: Record<string, string> = { python: 'Python', cpp: 'C++', java: 'Java', javascript: 'JavaScript' };

export default function Profile() {
  const { user } = useAuth();
  const { progress, highestRank, battleUnlocked } = useUserProgress();
  const [stats, setStats] = useState<UserStats | null>(null);
  const [achievements, setAchievements] = useState<Achievement[]>([]);

  useEffect(() => {
    api.getUserStats().then(setStats);
    api.getAchievements().then(setAchievements);
  }, []);

  return (
    <div className="p-6 md:p-10 max-w-6xl mx-auto">
      {/* Hero card */}
      <div className="rounded-2xl border-2 border-primary/30 bg-gradient-to-br from-primary/15 via-background/40 to-fuchsia-500/10 p-6 md:p-8 mb-6 relative overflow-hidden shadow-[0_0_50px_hsl(var(--primary)/0.2)]">
        <div className="absolute -right-10 -top-10 w-64 h-64 bg-primary/30 rounded-full blur-3xl" />
        <div className="absolute -left-10 -bottom-10 w-64 h-64 bg-fuchsia-500/20 rounded-full blur-3xl" />
        <div className="relative flex items-center gap-5 flex-wrap">
          <div className="w-24 h-24 rounded-2xl bg-gradient-to-br from-primary via-fuchsia-500 to-warning flex items-center justify-center text-4xl font-black text-primary-foreground shadow-[0_0_40px_hsl(var(--primary)/0.5)]">
            {user?.user_name?.[0]?.toUpperCase() ?? '?'}
          </div>
          <div className="flex-1 min-w-[200px]">
            <h1 className="text-3xl md:text-4xl font-black tracking-tight">{user?.name || user?.user_name}</h1>
            <div className="text-xs text-muted-foreground space-y-1 mt-2">
              <div className="flex items-center gap-2"><AtSign className="w-3 h-3" />{user?.user_name}</div>
              <div className="flex items-center gap-2"><Mail className="w-3 h-3" />{user?.email}</div>
            </div>
          </div>
          <div className="flex flex-col gap-2 items-end">
            <div className={cn(
              'px-4 py-2 rounded-xl text-xs font-black tracking-[0.2em] uppercase text-white shadow-xl',
              `bg-gradient-to-r ${RANK_COLOR[highestRank.name.toLowerCase()] ?? RANK_COLOR.rookie}`,
            )}>
              <Sparkles className="w-3 h-3 inline mr-1 -mt-0.5" /> {highestRank.name}
            </div>
            <div className={cn(
              'px-3 py-1 rounded-full text-[10px] font-bold tracking-widest uppercase',
              battleUnlocked ? 'bg-success/15 text-success border border-success/30' : 'bg-muted/40 text-muted-foreground border border-border/40',
            )}>
              {battleUnlocked ? '⚔ Battle Ready' : '🔒 Locked'}
            </div>
          </div>
        </div>
      </div>

      {/* Stats grid */}
      <div className="grid grid-cols-2 md:grid-cols-4 gap-4 mb-8">
        <StatBlock icon={<Trophy />}  label="Battles Won"   value={String(stats?.battles_won ?? 0)} color="warning" />
        <StatBlock icon={<Target />}  label="Win Rate"      value={stats ? `${Math.round(stats.win_rate * 100)}%` : '—'} color="success" />
        <StatBlock icon={<Flame />}   label="Streak"        value={stats ? `${stats.streak_days} days` : '—'} color="destructive" />
        <StatBlock icon={<Brain />}   label="Confidence"    value={stats ? `${Math.round(stats.confidence * 100)}%` : '—'} color="primary" />
      </div>

      {/* Language ranks */}
      <h2 className="text-xs font-black tracking-[0.3em] uppercase text-muted-foreground mb-3 flex items-center gap-2">
        <Zap className="w-3.5 h-3.5" /> Language-Specific Ranks
      </h2>
      <div className="grid sm:grid-cols-2 lg:grid-cols-4 gap-3 mb-8">
        {progress.map((p) => {
          const rankKey = p.rank_name.toLowerCase();
          const pct = Math.min(100, (p.rank_order / 6) * 100);
          return (
            <div key={p.language} className="rounded-xl border border-border/40 bg-background/50 p-4 relative overflow-hidden hover:border-primary/40 hover:-translate-y-0.5 transition-all">
              <div className={cn('absolute -top-10 -right-10 w-28 h-28 rounded-full blur-2xl opacity-40', `bg-gradient-to-br ${RANK_COLOR[rankKey] ?? RANK_COLOR.rookie}`)} />
              <div className="relative">
                <div className="flex items-center justify-between mb-2">
                  <div className="font-bold">{LANG_NAME[p.language] ?? p.language}</div>
                  <span className={cn(
                    'text-[10px] px-2 py-0.5 rounded-full font-black tracking-widest text-white shadow',
                    `bg-gradient-to-r ${RANK_COLOR[rankKey] ?? RANK_COLOR.rookie}`,
                  )}>
                    {p.rank_name.toUpperCase()}
                  </span>
                </div>
                <div className="text-[10px] uppercase tracking-widest text-muted-foreground mb-1 flex justify-between">
                  <span>Part {p.rank_part}</span>
                  <span className="text-foreground font-bold">{p.total_points} XP</span>
                </div>
                <div className="h-1.5 rounded-full bg-muted/40 overflow-hidden">
                  <div className={cn('h-full bg-gradient-to-r', RANK_COLOR[rankKey] ?? RANK_COLOR.rookie)} style={{ width: `${pct}%` }} />
                </div>
              </div>
            </div>
          );
        })}
      </div>

      {/* Achievements */}
      <h2 className="text-xs font-black tracking-[0.3em] uppercase text-muted-foreground mb-3 flex items-center gap-2">
        <Award className="w-3.5 h-3.5" /> Achievements
      </h2>
      <div className="grid sm:grid-cols-2 lg:grid-cols-3 gap-3">
        {achievements.map((a) => (
          <div
            key={a.id}
            className={cn(
              'rounded-xl border p-4 relative overflow-hidden transition-all',
              a.unlocked
                ? 'border-warning/40 bg-gradient-to-br from-warning/10 via-background/40 to-transparent shadow-[0_0_25px_hsl(var(--warning)/0.15)] hover:-translate-y-0.5'
                : 'border-border/40 bg-background/40 opacity-70',
            )}
          >
            <div className="flex items-start gap-3">
              <div className={cn(
                'w-10 h-10 rounded-lg flex items-center justify-center shrink-0',
                a.unlocked ? 'bg-gradient-to-br from-warning to-amber-600 text-white shadow-lg' : 'bg-muted/40 text-muted-foreground',
              )}>
                {a.unlocked ? <Trophy className="w-5 h-5" /> : <Lock className="w-5 h-5" />}
              </div>
              <div className="flex-1 min-w-0">
                <div className="font-bold text-sm">{a.title}</div>
                <div className="text-xs text-muted-foreground mt-0.5">{a.description}</div>
                {!a.unlocked && a.progress !== undefined && (
                  <div className="mt-2 h-1 rounded-full bg-muted/40 overflow-hidden">
                    <div className="h-full bg-gradient-to-r from-primary to-warning" style={{ width: `${a.progress * 100}%` }} />
                  </div>
                )}
              </div>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}

function StatBlock({ icon, label, value, color }: { icon: React.ReactNode; label: string; value: string; color: 'primary' | 'warning' | 'success' | 'destructive' }) {
  const cmap = {
    primary: 'from-primary/20 to-transparent border-primary/40 text-primary',
    warning: 'from-warning/20 to-transparent border-warning/40 text-warning',
    success: 'from-success/20 to-transparent border-success/40 text-success',
    destructive: 'from-destructive/20 to-transparent border-destructive/40 text-destructive',
  };
  return (
    <div className={cn('rounded-xl border bg-gradient-to-br p-4 backdrop-blur', cmap[color])}>
      <div className="flex items-center gap-2 mb-2 opacity-90">
        <div className="w-4 h-4">{icon}</div>
        <span className="text-[10px] uppercase tracking-widest">{label}</span>
      </div>
      <div className="text-2xl font-black text-foreground">{value}</div>
    </div>
  );
}
