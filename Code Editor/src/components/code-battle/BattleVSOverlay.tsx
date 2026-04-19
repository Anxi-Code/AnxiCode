import { useEffect, useRef, useState } from 'react';
import { Swords, Zap, Database, Cpu, CheckCircle2 } from 'lucide-react';

interface BattleVSOverlayProps {
  user1: string;
  user2: string;
  onComplete: () => void;
  duration?: number;
}

const LOADING_STAGES = [
  { icon: Database, label: 'Connecting to battle server' },
  { icon: Zap, label: 'Syncing player profiles' },
  { icon: Cpu, label: 'Loading problem set' },
  { icon: CheckCircle2, label: 'Battle ready' },
];

export const BattleVSOverlay = ({ user1, user2, onComplete, duration = 7000 }: BattleVSOverlayProps) => {
  const [exiting, setExiting] = useState(false);
  const [progress, setProgress] = useState(0);
  const [stageIdx, setStageIdx] = useState(0);
  const onCompleteRef = useRef(onComplete);
  onCompleteRef.current = onComplete;

  useEffect(() => {
    const startedAt = Date.now();
    const tick = setInterval(() => {
      const elapsed = Date.now() - startedAt;
      const pct = Math.min(100, (elapsed / (duration - 400)) * 100);
      setProgress(pct);
      const stage = Math.min(LOADING_STAGES.length - 1, Math.floor((pct / 100) * LOADING_STAGES.length));
      setStageIdx(stage);
    }, 60);
    const exitTimer = setTimeout(() => setExiting(true), duration - 400);
    const doneTimer = setTimeout(() => onCompleteRef.current(), duration);
    return () => {
      clearInterval(tick);
      clearTimeout(exitTimer);
      clearTimeout(doneTimer);
    };
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  const CurrentIcon = LOADING_STAGES[stageIdx].icon;

  return (
    <div
      className={`fixed inset-0 z-[100] flex items-center justify-center overflow-hidden bg-[radial-gradient(ellipse_at_center,_hsl(var(--background))_0%,_#000_80%)] transition-opacity duration-400 ${
        exiting ? 'opacity-0' : 'opacity-100'
      }`}
    >
      {/* Animated background orbs */}
      <div className="absolute inset-0 pointer-events-none overflow-hidden">
        <div className="absolute top-1/3 left-[10%] w-72 h-72 bg-primary/30 rounded-full blur-[120px] animate-pulse" />
        <div className="absolute bottom-1/3 right-[10%] w-72 h-72 bg-destructive/30 rounded-full blur-[120px] animate-pulse" />
        <div className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-40 h-40 bg-warning/40 rounded-full blur-[100px] animate-pulse" />
      </div>

      {/* Grid overlay */}
      <div
        className="absolute inset-0 opacity-[0.08] pointer-events-none"
        style={{
          backgroundImage:
            'linear-gradient(hsl(var(--primary)) 1px, transparent 1px), linear-gradient(90deg, hsl(var(--primary)) 1px, transparent 1px)',
          backgroundSize: '50px 50px',
        }}
      />

      {/* Diagonal slash backgrounds */}
      <div
        className="absolute inset-0 pointer-events-none"
        style={{
          background:
            'linear-gradient(110deg, hsl(var(--primary) / 0.18) 0%, hsl(var(--primary) / 0.18) 38%, transparent 46%, transparent 100%)',
          animation: 'vs-slide-left 0.7s cubic-bezier(0.22, 1, 0.36, 1) both',
        }}
      />
      <div
        className="absolute inset-0 pointer-events-none"
        style={{
          background:
            'linear-gradient(110deg, transparent 0%, transparent 54%, hsl(var(--destructive) / 0.18) 62%, hsl(var(--destructive) / 0.18) 100%)',
          animation: 'vs-slide-right 0.7s cubic-bezier(0.22, 1, 0.36, 1) both',
        }}
      />

      {/* Content — players + VS with proper spacing so VS isn't covered */}
      <div className="relative z-10 grid grid-cols-[1fr_auto_1fr] items-center gap-6 md:gap-12 w-full max-w-7xl px-6 md:px-16">
        {/* Player 1 */}
        <div
          className="flex flex-col items-start text-left min-w-0"
          style={{ animation: 'vs-name-left 0.8s cubic-bezier(0.22, 1, 0.36, 1) both' }}
        >
          <span className="text-xs md:text-sm font-mono uppercase tracking-[0.3em] text-primary/70 mb-2">
            Player 01
          </span>
          <h2
            className="text-3xl md:text-6xl font-black tracking-tight bg-gradient-to-r from-primary via-primary to-primary/60 bg-clip-text text-transparent truncate max-w-full"
            style={{ filter: 'drop-shadow(0 0 30px hsl(var(--primary) / 0.6))' }}
          >
            {user1}
          </h2>
          <div className="mt-3 h-1 w-24 md:w-40 bg-gradient-to-r from-primary to-transparent rounded-full" />
        </div>

        {/* VS — isolated column, never covered */}
        <div
          className="relative flex items-center justify-center w-32 md:w-48 h-32 md:h-48 shrink-0"
          style={{ animation: 'vs-pop 0.6s cubic-bezier(0.34, 1.56, 0.64, 1) 0.4s both' }}
        >
          <div className="absolute inset-0 bg-warning/40 blur-3xl rounded-full scale-150" />
          <Swords
            className="absolute w-20 h-20 md:w-32 md:h-32 text-warning/20 animate-spin"
            style={{ animationDuration: '8s' }}
          />
          <span
            className="relative text-5xl md:text-8xl font-black italic tracking-tighter bg-gradient-to-b from-warning via-destructive to-warning bg-clip-text text-transparent select-none leading-none"
            style={{ filter: 'drop-shadow(0 0 40px hsl(var(--warning) / 0.9))' }}
          >
            VS
          </span>
        </div>

        {/* Player 2 */}
        <div
          className="flex flex-col items-end text-right min-w-0"
          style={{ animation: 'vs-name-right 0.8s cubic-bezier(0.22, 1, 0.36, 1) both' }}
        >
          <span className="text-xs md:text-sm font-mono uppercase tracking-[0.3em] text-destructive/70 mb-2">
            Player 02
          </span>
          <h2
            className="text-3xl md:text-6xl font-black tracking-tight bg-gradient-to-l from-destructive via-destructive to-destructive/60 bg-clip-text text-transparent truncate max-w-full"
            style={{ filter: 'drop-shadow(0 0 30px hsl(var(--destructive) / 0.6))' }}
          >
            {user2}
          </h2>
          <div className="mt-3 h-1 w-24 md:w-40 bg-gradient-to-l from-destructive to-transparent rounded-full ml-auto" />
        </div>
      </div>

      {/* Loading panel */}
      <div
        className="absolute bottom-10 left-1/2 -translate-x-1/2 w-[90%] max-w-xl"
        style={{ animation: 'vs-fade-up 0.6s ease-out 0.9s both' }}
      >
        <div className="rounded-xl border border-primary/20 bg-background/40 backdrop-blur-xl p-4 shadow-[0_0_40px_hsl(var(--primary)/0.2)]">
          <div className="flex items-center gap-3 mb-3">
            <div className="relative">
              <CurrentIcon className="w-5 h-5 text-primary animate-pulse" />
              <div className="absolute inset-0 bg-primary/40 blur-md rounded-full" />
            </div>
            <span className="text-xs md:text-sm font-mono uppercase tracking-[0.25em] text-foreground/90 flex-1 truncate">
              {LOADING_STAGES[stageIdx].label}
            </span>
            <span className="text-xs font-mono text-primary tabular-nums">
              {Math.floor(progress)}%
            </span>
          </div>

          {/* Progress bar */}
          <div className="relative h-1.5 w-full rounded-full bg-muted/30 overflow-hidden">
            <div
              className="absolute inset-y-0 left-0 bg-gradient-to-r from-primary via-warning to-destructive rounded-full transition-[width] duration-100 ease-linear"
              style={{
                width: `${progress}%`,
                boxShadow: '0 0 12px hsl(var(--warning) / 0.8)',
              }}
            />
            <div
              className="absolute inset-y-0 w-12 bg-gradient-to-r from-transparent via-white/40 to-transparent blur-sm"
              style={{
                left: `${Math.max(0, progress - 8)}%`,
                transition: 'left 100ms linear',
              }}
            />
          </div>

          {/* Stage dots */}
          <div className="flex justify-between mt-3 px-1">
            {LOADING_STAGES.map((s, i) => (
              <div key={i} className="flex flex-col items-center gap-1">
                <div
                  className={`w-2 h-2 rounded-full transition-all duration-300 ${
                    i <= stageIdx
                      ? 'bg-primary shadow-[0_0_8px_hsl(var(--primary))]'
                      : 'bg-muted/40'
                  }`}
                />
              </div>
            ))}
          </div>
        </div>

        <p className="text-center text-[10px] md:text-xs font-mono uppercase tracking-[0.4em] text-muted-foreground mt-3">
          ⚡ Battle Initializing ⚡
        </p>
      </div>

      {/* Inline keyframes */}
      <style>{`
        @keyframes vs-slide-left {
          from { transform: translateX(-100%); opacity: 0; }
          to { transform: translateX(0); opacity: 1; }
        }
        @keyframes vs-slide-right {
          from { transform: translateX(100%); opacity: 0; }
          to { transform: translateX(0); opacity: 1; }
        }
        @keyframes vs-name-left {
          0% { transform: translateX(-80px); opacity: 0; }
          100% { transform: translateX(0); opacity: 1; }
        }
        @keyframes vs-name-right {
          0% { transform: translateX(80px); opacity: 0; }
          100% { transform: translateX(0); opacity: 1; }
        }
        @keyframes vs-pop {
          0% { transform: scale(0) rotate(-180deg); opacity: 0; }
          60% { transform: scale(1.3) rotate(10deg); opacity: 1; }
          100% { transform: scale(1) rotate(0deg); opacity: 1; }
        }
        @keyframes vs-fade-up {
          from { transform: translate(-50%, 20px); opacity: 0; }
          to { transform: translate(-50%, 0); opacity: 1; }
        }
      `}</style>
    </div>
  );
};
