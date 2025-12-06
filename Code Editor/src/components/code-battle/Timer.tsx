import { useState, useEffect, useCallback } from 'react';
import { Clock, AlertTriangle } from 'lucide-react';
import { cn } from '@/lib/utils';

interface TimerProps {
  // MODIFY TIMER HERE BASED ON PROBLEM TIME LIMIT
  // This value should come from the problem configuration
  initialSeconds?: number;
  onTimeUp?: () => void;
}

export const Timer = ({ initialSeconds = 600, onTimeUp }: TimerProps) => {
  // MODIFY TIMER HERE BASED ON PROBLEM TIME LIMIT
  // The initialSeconds prop controls the battle duration
  // Default: 600 seconds (10 minutes)
  // Can be set per-problem: easy=300s, medium=600s, hard=900s
  const [seconds, setSeconds] = useState(initialSeconds);
  const [isRunning, setIsRunning] = useState(true);

  // MODIFY TIMER HERE BASED ON PROBLEM TIME LIMIT
  // Reset timer when initialSeconds changes (e.g., when problem changes)
  useEffect(() => {
    setSeconds(initialSeconds);
  }, [initialSeconds]);

  useEffect(() => {
    if (!isRunning || seconds <= 0) {
      if (seconds <= 0 && onTimeUp) {
        // MODIFY TIMER HERE BASED ON PROBLEM TIME LIMIT
        // This callback triggers when time expires
        // Can be used for auto-submission
        onTimeUp();
      }
      return;
    }

    const interval = setInterval(() => {
      setSeconds((prev) => prev - 1);
    }, 1000);

    return () => clearInterval(interval);
  }, [isRunning, seconds, onTimeUp]);

  const formatTime = useCallback((totalSeconds: number) => {
    const mins = Math.floor(totalSeconds / 60);
    const secs = totalSeconds % 60;
    return `${mins.toString().padStart(2, '0')}:${secs.toString().padStart(2, '0')}`;
  }, []);

  const isLowTime = seconds <= 60;
  const isCriticalTime = seconds <= 30;

  return (
    <div
      className={cn(
        "flex items-center gap-2 px-4 py-2 rounded-lg font-mono text-lg font-semibold transition-all duration-300",
        isCriticalTime && "bg-destructive/20 text-destructive animate-pulse",
        isLowTime && !isCriticalTime && "bg-warning/20 text-warning",
        !isLowTime && "bg-secondary text-foreground"
      )}
    >
      {isCriticalTime ? (
        <AlertTriangle className="w-5 h-5 animate-pulse" />
      ) : (
        <Clock className="w-5 h-5" />
      )}
      <span className="tabular-nums">{formatTime(seconds)}</span>
    </div>
  );
};