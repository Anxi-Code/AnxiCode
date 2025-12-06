import { Play, Rocket, FileText, Code2, ChevronDown } from 'lucide-react';
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
  // CHANGE HERE for dynamic language switching - These props control the language selector
  selectedLanguage: SupportedLanguage;
  onLanguageChange: (language: SupportedLanguage) => void;
}

// CHANGE HERE for dynamic language switching - Add/modify language icons here
const LANGUAGE_CONFIG: Record<SupportedLanguage, { name: string; icon: JSX.Element }> = {
  python: { name: 'Python 3', icon: <PythonIcon size={20} /> },
  cpp: { name: 'C++ 17', icon: <span className="text-blue-500 font-bold text-sm">C++</span> },
  java: { name: 'Java 17', icon: <span className="text-orange-500 font-bold text-sm">Java</span> },
  javascript: { name: 'JavaScript', icon: <span className="text-yellow-500 font-bold text-sm">JS</span> }
};

export const Navbar = ({ 
  isProblemOpen, 
  onToggleProblem, 
  onRun, 
  onSubmit,
  selectedLanguage,
  onLanguageChange 
}: NavbarProps) => {
  // MODIFY TIMER HERE BASED ON PROBLEM TIME LIMIT
  // The timer duration will be set based on the problem's time limit
  // Default: 600 seconds (10 minutes), can be modified per problem
  // Easy problems: 300s, Medium: 600s, Hard: 900s
  const problemTimeLimit = 600;

  return (
    <nav className="fixed top-0 left-0 right-0 h-14 bg-card border-b border-border z-50">
      <div className="h-full px-4 flex items-center justify-between">
        {/* Left Section - Language Selector */}
        {/* CHANGE HERE for dynamic language switching - Language dropdown selector */}
        <div className="flex items-center gap-3">
          <DropdownMenu>
            <DropdownMenuTrigger asChild>
              <Button variant="secondary" size="sm" className="flex items-center gap-2 px-3 py-1.5">
                {LANGUAGE_CONFIG[selectedLanguage].icon}
                <span className="font-medium text-sm text-foreground">
                  {LANGUAGE_CONFIG[selectedLanguage].name}
                </span>
                <ChevronDown className="w-4 h-4 text-muted-foreground" />
              </Button>
            </DropdownMenuTrigger>
            <DropdownMenuContent align="start">
              {/* CHANGE HERE for dynamic language switching - Add new languages to this list */}
              {(Object.keys(LANGUAGE_CONFIG) as SupportedLanguage[]).map((lang) => (
                <DropdownMenuItem
                  key={lang}
                  onClick={() => onLanguageChange(lang)}
                  className={cn(
                    "flex items-center gap-2 cursor-pointer",
                    selectedLanguage === lang && "bg-primary/10"
                  )}
                >
                  {LANGUAGE_CONFIG[lang].icon}
                  <span>{LANGUAGE_CONFIG[lang].name}</span>
                </DropdownMenuItem>
              ))}
            </DropdownMenuContent>
          </DropdownMenu>
          
          <div className="hidden md:flex items-center gap-1 text-muted-foreground">
            <Code2 className="w-4 h-4" />
            <span className="text-xs">Code Battle</span>
          </div>
        </div>

        {/* Center Section - Timer */}
        {/* MODIFY TIMER HERE BASED ON PROBLEM TIME LIMIT */}
        <div className="absolute left-1/2 -translate-x-1/2">
          <Timer 
            initialSeconds={problemTimeLimit} 
            onTimeUp={() => {
              console.log('[Timer] Time is up!');
              // MODIFY TIMER HERE BASED ON PROBLEM TIME LIMIT
              // Auto-submit logic can be added here when time expires
            }} 
          />
        </div>

        {/* Right Section - Actions */}
        <div className="flex items-center gap-2">
          <Button
            variant={isProblemOpen ? "secondary" : "outline"}
            size="sm"
            onClick={onToggleProblem}
            className={cn(
              "hidden sm:flex items-center gap-2 transition-all duration-200",
              isProblemOpen && "bg-primary/10 text-primary border-primary/30"
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
            className="flex items-center gap-2"
          >
            <Play className="w-4 h-4" />
            <span className="hidden sm:inline">Run</span>
          </Button>

          {/* PLAYER 1 CODE ACCESS HERE */}
          {/* PLAYER 2 CODE ACCESS HERE */}
          {/* TEAM SUBMISSION LOGIC HERE */}
          <Button
            variant="gaming-warning"
            size="sm"
            onClick={onSubmit}
            className="flex items-center gap-2"
          >
            <Rocket className="w-4 h-4" />
            <span className="hidden sm:inline">Submit</span>
          </Button>

          <div className="h-6 w-px bg-border mx-1" />

          <ThemeToggle />
        </div>
      </div>
    </nav>
  );
};