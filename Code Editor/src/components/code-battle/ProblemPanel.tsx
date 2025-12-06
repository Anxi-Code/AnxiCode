import { cn } from '@/lib/utils';
import { Badge } from '@/components/ui/badge';
import { FileText, Tag, Lightbulb, CheckCircle2 } from 'lucide-react';

interface ProblemPanelProps {
  isOpen: boolean;
  className?: string;
}

export const ProblemPanel = ({ isOpen, className }: ProblemPanelProps) => {
  return (
    <div
      className={cn(
        "h-full overflow-hidden transition-panel bg-card border-l border-border",
        isOpen ? "w-[30%] opacity-100" : "w-0 opacity-0",
        className
      )}
    >
      <div className="h-full overflow-y-auto editor-scrollbar p-6">
        {/* Header */}
        <div className="flex items-center gap-3 mb-6">
          <div className="p-2 rounded-lg bg-primary/10">
            <FileText className="w-5 h-5 text-primary" />
          </div>
          <div>
            <h2 className="text-lg font-bold text-foreground">Two Sum</h2>
            <div className="flex items-center gap-2 mt-1">
              <Badge variant="outline" className="text-success border-success/30 bg-success/10">
                Easy
              </Badge>
              <Badge variant="outline" className="text-muted-foreground">
                Array
              </Badge>
              <Badge variant="outline" className="text-muted-foreground">
                Hash Table
              </Badge>
            </div>
          </div>
        </div>

        {/* Problem Description */}
        <div className="space-y-4 text-sm">
          <p className="text-foreground leading-relaxed">
            Given an array of integers <code className="px-1.5 py-0.5 rounded bg-secondary font-mono text-xs">nums</code> and
            an integer <code className="px-1.5 py-0.5 rounded bg-secondary font-mono text-xs">target</code>, return{' '}
            <em>indices of the two numbers such that they add up to target</em>.
          </p>

          <p className="text-foreground leading-relaxed">
            You may assume that each input would have{' '}
            <strong className="text-primary">exactly one solution</strong>, and you may not use the{' '}
            <em>same</em> element twice.
          </p>

          <p className="text-muted-foreground">You can return the answer in any order.</p>

          {/* Examples */}
          <div className="space-y-4 mt-6">
            <h3 className="font-semibold text-foreground flex items-center gap-2">
              <Lightbulb className="w-4 h-4 text-warning" />
              Examples
            </h3>

            <div className="bg-secondary/50 rounded-lg p-4 space-y-2">
              <div className="flex items-center gap-2 text-xs font-semibold text-muted-foreground">
                <CheckCircle2 className="w-3 h-3 text-success" />
                Example 1
              </div>
              <div className="font-mono text-xs space-y-1">
                <p>
                  <span className="text-muted-foreground">Input:</span>{' '}
                  <span className="text-foreground">nums = [2,7,11,15], target = 9</span>
                </p>
                <p>
                  <span className="text-muted-foreground">Output:</span>{' '}
                  <span className="text-success">[0,1]</span>
                </p>
                <p className="text-muted-foreground text-[11px]">
                  Explanation: nums[0] + nums[1] == 9, so we return [0, 1].
                </p>
              </div>
            </div>

            <div className="bg-secondary/50 rounded-lg p-4 space-y-2">
              <div className="flex items-center gap-2 text-xs font-semibold text-muted-foreground">
                <CheckCircle2 className="w-3 h-3 text-success" />
                Example 2
              </div>
              <div className="font-mono text-xs space-y-1">
                <p>
                  <span className="text-muted-foreground">Input:</span>{' '}
                  <span className="text-foreground">nums = [3,2,4], target = 6</span>
                </p>
                <p>
                  <span className="text-muted-foreground">Output:</span>{' '}
                  <span className="text-success">[1,2]</span>
                </p>
              </div>
            </div>

            <div className="bg-secondary/50 rounded-lg p-4 space-y-2">
              <div className="flex items-center gap-2 text-xs font-semibold text-muted-foreground">
                <CheckCircle2 className="w-3 h-3 text-success" />
                Example 3
              </div>
              <div className="font-mono text-xs space-y-1">
                <p>
                  <span className="text-muted-foreground">Input:</span>{' '}
                  <span className="text-foreground">nums = [3,3], target = 6</span>
                </p>
                <p>
                  <span className="text-muted-foreground">Output:</span>{' '}
                  <span className="text-success">[0,1]</span>
                </p>
              </div>
            </div>
          </div>

          {/* Constraints */}
          <div className="mt-6">
            <h3 className="font-semibold text-foreground flex items-center gap-2 mb-3">
              <Tag className="w-4 h-4 text-primary" />
              Constraints
            </h3>
            <ul className="space-y-1.5 text-xs font-mono text-muted-foreground">
              <li className="flex items-start gap-2">
                <span className="text-primary">•</span>
                <span>2 ≤ nums.length ≤ 10⁴</span>
              </li>
              <li className="flex items-start gap-2">
                <span className="text-primary">•</span>
                <span>-10⁹ ≤ nums[i] ≤ 10⁹</span>
              </li>
              <li className="flex items-start gap-2">
                <span className="text-primary">•</span>
                <span>-10⁹ ≤ target ≤ 10⁹</span>
              </li>
              <li className="flex items-start gap-2">
                <span className="text-primary">•</span>
                <span>Only one valid answer exists.</span>
              </li>
            </ul>
          </div>
        </div>
      </div>
    </div>
  );
};
