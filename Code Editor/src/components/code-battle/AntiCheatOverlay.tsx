import { useEffect, useRef, useState } from 'react';
import { AlertTriangle } from 'lucide-react';

interface AntiCheatOverlayProps {
  active: boolean;
  onTimeout: () => void;
  violationCount: number;
  maxViolations: number;
}

export const AntiCheatOverlay = ({
  active,
  onTimeout,
  violationCount,
  maxViolations,
}: AntiCheatOverlayProps) => {
  const [count, setCount] = useState(5);
  const timeoutCalledRef = useRef(false);

  useEffect(() => {
    if (!active) {
      setCount(5);
      timeoutCalledRef.current = false;
      return;
    }

    setCount(5);
    timeoutCalledRef.current = false;

    const start = Date.now();

    const interval = setInterval(() => {
      const elapsed = Math.floor((Date.now() - start) / 1000);
      const remaining = Math.max(0, 5 - elapsed);

      setCount(remaining);

      if (remaining <= 0 && !timeoutCalledRef.current) {
        timeoutCalledRef.current = true;
        clearInterval(interval);
        onTimeout();
      }
    }, 200);

    return () => clearInterval(interval);
  }, [active, onTimeout]);

  if (!active) return null;

  return (
    <div className="fixed inset-0 z-[200] flex items-center justify-center bg-destructive/30 backdrop-blur-xl">
      <div className="relative max-w-lg w-full mx-4 rounded-2xl border-2 border-destructive bg-background/95 p-8 shadow-[0_0_80px_hsl(var(--destructive)/0.6)]">
        <div className="flex items-center gap-3 mb-4">
          <AlertTriangle className="w-10 h-10 text-destructive animate-pulse" />

          <h2 className="text-2xl font-black tracking-wider text-destructive uppercase">
            Cheating Warning
          </h2>
        </div>

        <p className="text-sm text-foreground leading-relaxed mb-4">
          Tab switching detected. Return within{' '}
          <span className="font-black text-destructive text-lg">{count}</span>{' '}
          seconds or you will automatically lose this battle.
        </p>

        <div className="h-2 rounded-full bg-muted overflow-hidden">
          <div
            className="h-full bg-destructive transition-all duration-200"
            style={{ width: `${(count / 5) * 100}%` }}
          />
        </div>

        <p className="text-[11px] uppercase tracking-widest text-muted-foreground mt-4 text-right">
          Violation {violationCount}/{maxViolations}
        </p>
      </div>
    </div>
  );
};