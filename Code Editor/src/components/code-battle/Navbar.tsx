import { Play, Rocket, FileText, Code2, ChevronDown, Loader2 } from 'lucide-react';
import { Button } from '@/components/ui/button';
import { Timer } from './Timer';
import { ThemeToggle } from './ThemeToggle';
import { PythonIcon } from './PythonIcon';
import { cn } from '@/lib/utils';
import { SupportedLanguage } from './CodeEditor';
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger,
} from '@/components/ui/dropdown-menu';

interface NavbarProps {
  isProblemOpen: boolean;
  onToggleProblem: () => void;
  onRun: () => void;
  onSubmit: () => void;
  selectedLanguage: SupportedLanguage;
  onLanguageChange: (language: SupportedLanguage) => void;
  timerSeconds?: number;
  onTimeUp?: () => void;
  running?: boolean;
  submitting?: boolean;
  languageLocked?: boolean;
}

const LANGUAGE_CONFIG: Record<SupportedLanguage, { name: string; icon: JSX.Element }> = {
  python: { name: 'Python 3', icon: <PythonIcon size={20} /> },
  cpp: { name: 'C++ 17', icon: <span className="text-blue-500 font-bold text-sm">C++</span> },
  java: { name: 'Java 17', icon: <span className="text-orange-500 font-bold text-sm">Java</span> },
  javascript: { name: 'JavaScript', icon: <span className="text-yellow-500 font-bold text-sm">JS</span> },
};

export const Navbar = ({
  isProblemOpen,
  onToggleProblem,
  onRun,
  onSubmit,
  selectedLanguage,
  onLanguageChange,
  timerSeconds = 600,
  onTimeUp,
  running = false,
  submitting = false,
  languageLocked = false,
}: NavbarProps) => {
  return (
    <nav className="fixed top-0 left-0 right-0 h-14 glass-navbar z-50">
      <div className="h-full px-4 flex items-center justify-between">
        <div className="flex items-center gap-3">
          <DropdownMenu>
            <DropdownMenuTrigger asChild disabled={languageLocked}>
              <Button
                variant="secondary"
                size="sm"
                className="flex items-center gap-2 px-3 py-1.5 hover-lift hover:border-primary/30 border border-transparent"
              >
                {LANGUAGE_CONFIG[selectedLanguage].icon}
                <span className="font-medium text-sm text-foreground">
                  {LANGUAGE_CONFIG[selectedLanguage].name}
                </span>
                {!languageLocked && <ChevronDown className="w-4 h-4 text-muted-foreground" />}
              </Button>
            </DropdownMenuTrigger>
            {!languageLocked && (
              <DropdownMenuContent align="start">
                {(Object.keys(LANGUAGE_CONFIG) as SupportedLanguage[]).map((lang) => (
                  <DropdownMenuItem
                    key={lang}
                    onClick={() => onLanguageChange(lang)}
                    className={cn(
                      'flex items-center gap-2 cursor-pointer',
                      selectedLanguage === lang && 'bg-primary/10'
                    )}
                  >
                    {LANGUAGE_CONFIG[lang].icon}
                    <span>{LANGUAGE_CONFIG[lang].name}</span>
                  </DropdownMenuItem>
                ))}
              </DropdownMenuContent>
            )}
          </DropdownMenu>

          <div className="hidden md:flex items-center gap-1 text-muted-foreground">
            <Code2 className="w-4 h-4" />
            <span className="text-xs">Code Battle</span>
          </div>
        </div>

        <div className="absolute left-1/2 -translate-x-1/2">
          <Timer initialSeconds={timerSeconds} onTimeUp={onTimeUp} />
        </div>

        <div className="flex items-center gap-2">
          <Button
            variant={isProblemOpen ? 'secondary' : 'outline'}
            size="sm"
            onClick={onToggleProblem}
            className={cn(
              'hidden sm:flex items-center gap-2 transition-all duration-300 hover-lift',
              isProblemOpen && 'bg-primary/10 text-primary border-primary/30'
            )}
          >
            <FileText className="w-4 h-4" />
            <span>Problem</span>
          </Button>

          <div className="h-6 w-px bg-border mx-1" />

          <Button
            variant="gaming-success"
            size="sm"
            onClick={onRun}
            disabled={running || submitting}
            className="flex items-center gap-2 group"
          >
            {running ? <Loader2 className="w-4 h-4 animate-spin" /> : <Play className="w-4 h-4" />}
            <span className="hidden sm:inline">{running ? 'Running...' : 'Run'}</span>
          </Button>

          <Button
            variant="gaming-warning"
            size="sm"
            onClick={onSubmit}
            disabled={running || submitting}
            className="flex items-center gap-2 group"
          >
            {submitting ? <Loader2 className="w-4 h-4 animate-spin" /> : <Rocket className="w-4 h-4" />}
            <span className="hidden sm:inline">{submitting ? 'Judging...' : 'Submit'}</span>
          </Button>

          <div className="h-6 w-px bg-border mx-1" />

          <ThemeToggle />
        </div>
      </div>
    </nav>
  );
};
