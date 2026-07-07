import { NavLink, useLocation } from 'react-router-dom';
import { Home, Trophy, User, Swords, LogOut, Sparkles } from 'lucide-react';
import { useAuth } from '@/contexts/AuthContext';
import { useUserProgress } from '@/hooks/useUserProgress';
import { cn } from '@/lib/utils';

const NAV = [
  { to: '/', label: 'Lobby', icon: Home },
  { to: '/leaderboard', label: 'Leaderboard', icon: Trophy },
  { to: '/profile', label: 'Profile', icon: User },
];

export const OSSidebar = () => {
  const { pathname } = useLocation();
  const { user, signOut } = useAuth();
  const { highestRank, battleUnlocked } = useUserProgress();

  return (
    <aside className="hidden md:flex flex-col w-64 h-screen sticky top-0 glass-editor border-r border-border/40 z-30">
      <div className="px-5 pt-5 pb-4 border-b border-border/30">
        <div className="flex items-center gap-2">
          <div className="relative">
            <Swords className="w-6 h-6 text-primary" />
            <div className="absolute inset-0 bg-primary/40 blur-xl rounded-full" />
          </div>
          <span className="font-black tracking-[0.2em] bg-gradient-to-r from-cyan-300 via-fuchsia-400 to-amber-300 bg-clip-text text-transparent">
            ANXICODE
          </span>
        </div>
      </div>

      <nav className="flex-1 px-3 py-4 space-y-1">
        {NAV.map((item) => {
          const active = pathname === item.to;
          return (
            <NavLink
              key={item.to}
              to={item.to}
              className={cn(
                'flex items-center gap-3 px-3 py-2.5 rounded-lg text-sm font-medium transition-all',
                active
                  ? 'bg-primary/15 text-primary shadow-[0_0_20px_hsl(var(--primary)/0.3)]'
                  : 'text-muted-foreground hover:bg-muted/30 hover:text-foreground',
              )}
            >
              <item.icon className="w-4 h-4" />
              {item.label}
            </NavLink>
          );
        })}
      </nav>

      <div className="p-4 border-t border-border/30 space-y-3">
        <div className="rounded-lg bg-background/40 border border-border/40 p-3">
          <div className="flex items-center gap-2 mb-2">
            <div className="w-9 h-9 rounded-full bg-gradient-to-br from-primary via-fuchsia-500 to-warning flex items-center justify-center text-xs font-black text-primary-foreground shadow-[0_0_20px_hsl(var(--primary)/0.4)]">
              {user?.user_name?.[0]?.toUpperCase() ?? '?'}
            </div>
            <div className="flex-1 min-w-0">
              <div className="text-xs font-semibold truncate">{user?.user_name ?? 'Guest'}</div>
              <div className="text-[10px] text-muted-foreground flex items-center gap-1">
                <Sparkles className="w-2.5 h-2.5" />
                {highestRank.name}
              </div>
            </div>
          </div>
          <div className={cn(
            'text-[10px] text-center py-1 rounded-md font-bold tracking-wider',
            battleUnlocked
              ? 'bg-success/15 text-success'
              : 'bg-muted/40 text-muted-foreground',
          )}>
            {battleUnlocked ? '⚔ BATTLE READY' : '🔒 LOCKED'}
          </div>
        </div>
        <button
          onClick={signOut}
          className="w-full flex items-center justify-center gap-2 text-xs text-muted-foreground hover:text-destructive transition-colors py-2"
        >
          <LogOut className="w-3.5 h-3.5" /> Sign out
        </button>
      </div>
    </aside>
  );
};
