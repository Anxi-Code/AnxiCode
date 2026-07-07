import { cn } from '@/lib/utils';
import { Badge } from '@/components/ui/badge';
import { FileText, Tag, Lightbulb, CheckCircle2, ChevronLeft, ChevronRight, Loader2, Swords } from 'lucide-react';
import { useState } from 'react';
import { BattleProblem } from '@/hooks/useBattleProblems';

interface ProblemPanelProps {
  isOpen: boolean;
  className?: string;
  problems?: BattleProblem[];
  loading?: boolean;
  error?: string | null;
  rank?: string;
  language?: string;
}

export const ProblemPanel = ({
  isOpen,
  className,
  problems = [],
  loading = false,
  error = null,
  rank = 'phantom',
  language = 'python',
}: ProblemPanelProps) => {
  const [index, setIndex] = useState(0);
  const problem = problems[index];
  const total = problems.length;

  return (
    <div
      className={cn(
        'h-full overflow-hidden transition-panel glass-panel',
        isOpen ? 'w-[30%] opacity-100' : 'w-0 opacity-0',
        className,
      )}
    >
      <div className="h-full overflow-y-auto editor-scrollbar p-6">
        {/* Gamified Header */}
        <div className="mb-5 rounded-xl border border-primary/30 bg-gradient-to-br from-primary/10 via-background/40 to-destructive/10 p-4 shadow-[0_0_30px_hsl(var(--primary)/0.15)]">
          <div className="flex items-center justify-between mb-3">
            <div className="flex items-center gap-2">
              <div className="p-2 rounded-lg bg-primary/15 border border-primary/30">
                <Swords className="w-4 h-4 text-primary" />
              </div>
              <div>
                <div className="text-[10px] uppercase tracking-widest text-muted-foreground">Battle Quest</div>
                <div className="text-xs font-bold text-foreground uppercase">
                  {language} · {rank}
                </div>
              </div>
            </div>
            {total > 0 && (
              <div className="flex items-center gap-1">
                <button
                  onClick={() => setIndex((i) => Math.max(0, i - 1))}
                  disabled={index === 0}
                  className="p-1.5 rounded-md border border-border/40 hover:border-primary/40 hover:bg-primary/10 disabled:opacity-40 transition"
                >
                  <ChevronLeft className="w-3.5 h-3.5" />
                </button>
                <div className="text-[10px] font-bold tracking-wider text-muted-foreground px-2">
                  {index + 1}/{total}
                </div>
                <button
                  onClick={() => setIndex((i) => Math.min(total - 1, i + 1))}
                  disabled={index >= total - 1}
                  className="p-1.5 rounded-md border border-border/40 hover:border-primary/40 hover:bg-primary/10 disabled:opacity-40 transition"
                >
                  <ChevronRight className="w-3.5 h-3.5" />
                </button>
              </div>
            )}
          </div>
        </div>

        {loading && (
          <div className="flex items-center gap-2 text-sm text-muted-foreground">
            <Loader2 className="w-4 h-4 animate-spin" /> Loading quest...
          </div>
        )}

        {error && (
          <div className="text-sm text-destructive border border-destructive/30 bg-destructive/10 rounded-lg p-3">
            {error}
          </div>
        )}

        {!loading && !error && !problem && (
          <div className="text-sm text-muted-foreground">No problems found for this rank.</div>
        )}

        {problem && (
          <div className="space-y-4 text-sm">
            <div className="flex items-center gap-3">
              <div className="p-2 rounded-lg bg-warning/10 border border-warning/30">
                <FileText className="w-4 h-4 text-warning" />
              </div>
              <div>
                <h2 className="text-base font-bold text-foreground">{problem.title}</h2>
                <div className="flex items-center gap-2 mt-1">
                  <Badge variant="outline" className="text-primary border-primary/30 bg-primary/10 text-[10px]">
                    {problem.problem_id}
                  </Badge>
                  {problem.difficulty && (
                    <Badge variant="outline" className="text-warning border-warning/30 bg-warning/10 text-[10px]">
                      {problem.difficulty}
                    </Badge>
                  )}
                </div>
              </div>
            </div>

            <p className="text-foreground leading-relaxed whitespace-pre-wrap">{problem.description}</p>

            {problem.constraints && problem.constraints.length > 0 && (
              <div className="mt-4">
                <h3 className="font-semibold text-foreground flex items-center gap-2 mb-2">
                  <Tag className="w-4 h-4 text-primary" /> Constraints
                </h3>
                <ul className="space-y-1 text-xs font-mono text-muted-foreground">
                  {problem.constraints.map((c, i) => (
                    <li key={i}>• {c}</li>
                  ))}
                </ul>
              </div>
            )}

            {problem.examples && problem.examples.length > 0 && (
              <div className="space-y-3 mt-5">
                <h3 className="font-semibold text-foreground flex items-center gap-2">
                  <Lightbulb className="w-4 h-4 text-warning" /> Examples
                </h3>
                {problem.examples.map((ex, i) => (
                  <div key={i} className="bg-secondary/50 rounded-lg p-3 space-y-1 border border-border/30 hover:border-primary/30 transition">
                    <div className="flex items-center gap-2 text-[10px] font-bold uppercase tracking-wider text-muted-foreground">
                      <CheckCircle2 className="w-3 h-3 text-success" /> Example {i + 1}
                    </div>
                    <div className="font-mono text-xs whitespace-pre-wrap">
                      <div><span className="text-muted-foreground">Input: </span><span className="text-foreground">{ex.input}</span></div>
                      <div><span className="text-muted-foreground">Output: </span><span className="text-success">{ex.output}</span></div>
                      {ex.explanation && <div className="text-muted-foreground mt-1">{ex.explanation}</div>}
                    </div>
                  </div>
                ))}
              </div>
            )}
          </div>
        )}
      </div>
    </div>
  );
};
