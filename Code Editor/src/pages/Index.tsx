import { useState, useCallback, useRef } from 'react';
import { Navbar } from '@/components/code-battle/Navbar';
import { CodeEditor, SupportedLanguage } from '@/components/code-battle/CodeEditor';
import { ProblemPanel } from '@/components/code-battle/ProblemPanel';
import { ParticipantList } from '@/components/code-battle/ParticipantList';
import { BattleEntry, BattleData } from '@/components/code-battle/BattleEntry';
import { BattleVSOverlay } from '@/components/code-battle/BattleVSOverlay';
import { Swords } from 'lucide-react';
import { toast } from '@/hooks/use-toast';

const MOCK_PARTICIPANTS = [
  { id: '1', name: 'CodeMaster', team: 'blue' as const, isLeader: true },
  { id: '2', name: 'AlgoNinja', team: 'blue' as const },
  { id: '3', name: 'ByteWarrior', team: 'blue' as const },
  { id: '4', name: 'DataDragon', team: 'red' as const, isLeader: true },
  { id: '5', name: 'LogicLord', team: 'red' as const },
  { id: '6', name: 'SyntaxSage', team: 'red' as const },
];

// CHANGE HERE for dynamic language switching - File names for each language
const FILE_NAMES: Record<SupportedLanguage, string> = {
  python: 'solution.py',
  cpp: 'solution.cpp',
  java: 'Solution.java',
  javascript: 'solution.js'
};

// CHANGE HERE for dynamic language switching - Language display names
const LANGUAGE_DISPLAY: Record<SupportedLanguage, string> = {
  python: 'Python 3.11',
  cpp: 'C++ 17',
  java: 'Java 17',
  javascript: 'JavaScript ES6'
};

const Index = () => {
  const [battleData, setBattleData] = useState<BattleData | null>(null);
  const [pendingBattleData, setPendingBattleData] = useState<BattleData | null>(null);
  const [showVS, setShowVS] = useState(false);
  const [isProblemOpen, setIsProblemOpen] = useState(true);
  const [battleMode] = useState<'1v1' | 'team'>('team');
  
  // CHANGE HERE for dynamic language switching - Set default language
  // Options: 'python' | 'cpp' | 'java' | 'javascript'
  const [selectedLanguage, setSelectedLanguage] = useState<SupportedLanguage>('python');
  
  // PLAYER 1 CODE ACCESS HERE
  // PLAYER 2 CODE ACCESS HERE
  const player1CodeRef = useRef<string>('');
  const player2CodeRef = useRef<string>('');

  const handleToggleProblem = useCallback(() => {
    setIsProblemOpen((prev) => !prev);
    console.log(`[Panel] Problem panel ${!isProblemOpen ? 'opened' : 'closed'}`);
  }, [isProblemOpen]);

  const handleRun = useCallback(() => {
    console.log('[Action] Running code...');
    // PLAYER 1 CODE ACCESS HERE - Get player 1's code
    console.log('[Player 1 Code]:', player1CodeRef.current);
    
    toast({
      title: 'Running Code',
      description: 'Executing your solution against test cases...',
    });
  }, []);

  const handleSubmit = useCallback(() => {
    console.log('[Action] Submitting solution...');
    
    // PLAYER 1 CODE ACCESS HERE
    console.log('[Player 1 Code for submission]:', player1CodeRef.current);
    
    // PLAYER 2 CODE ACCESS HERE
    console.log('[Player 2 Code for submission]:', player2CodeRef.current);
    
    // TEAM SUBMISSION LOGIC HERE
    // For team mode: Collect codes from all team members
    // For 1v1 mode: Collect codes from both players
    
    // SAVE CODE TO TEMP FILES HERE (if needed)
    // const codeData = {
    //   player1: player1CodeRef.current,
    //   player2: player2CodeRef.current,
    //   language: selectedLanguage,
    //   timestamp: Date.now()
    // };
    
    // Send to AWS Lambda for compilation and AI analysis
    // await sendToAWS(codeData);
    
    toast({
      title: 'Submitting Solution',
      description: 'Your code is being evaluated...',
    });
  }, [selectedLanguage]);

  // CHANGE HERE for dynamic language switching
  const handleLanguageChange = useCallback((language: SupportedLanguage) => {
    setSelectedLanguage(language);
    console.log(`[Language] Switched to ${language}`);
  }, []);

  // Track code changes from editor
  const handleCodeChange = useCallback((code: string) => {
    // PLAYER 1 CODE ACCESS HERE
    player1CodeRef.current = code;
  }, []);

  // Show battle entry screen first
  if (!battleData) {
    return (
      <>
        <BattleEntry
          onEnter={(data) => {
            setPendingBattleData(data);
            setShowVS(true);
          }}
        />
        {showVS && pendingBattleData && (
          <BattleVSOverlay
            user1={pendingBattleData.user1}
            user2={pendingBattleData.user2}
            duration={7000}
            onComplete={() => {
              setBattleData(pendingBattleData);
              setShowVS(false);
            }}
          />
        )}
      </>
    );
  }

  return (
    <div className="min-h-screen bg-[radial-gradient(ellipse_at_top_right,_hsl(var(--primary)/0.15)_0%,_transparent_50%),radial-gradient(ellipse_at_bottom_left,_hsl(var(--success)/0.1)_0%,_transparent_50%),hsl(var(--background))] relative overflow-hidden">
      {/* Animated mesh gradient background */}
      <div className="absolute inset-0 overflow-hidden pointer-events-none z-0">
        <div className="absolute top-0 left-0 w-full h-full bg-[radial-gradient(circle_at_20%_80%,_hsl(var(--primary)/0.08)_0%,_transparent_40%)]" />
        <div className="absolute top-0 left-0 w-full h-full bg-[radial-gradient(circle_at_80%_20%,_hsl(var(--success)/0.08)_0%,_transparent_40%)]" />
        <div className="absolute top-0 left-0 w-full h-full bg-[radial-gradient(circle_at_50%_50%,_hsl(var(--warning)/0.05)_0%,_transparent_50%)]" />
        {/* Floating orbs */}
        <div className="absolute top-20 right-[20%] w-32 h-32 bg-primary/20 rounded-full blur-3xl animate-float" />
        <div className="absolute bottom-40 left-[15%] w-40 h-40 bg-success/15 rounded-full blur-3xl animate-float-delayed" />
        <div className="absolute top-1/2 right-[10%] w-24 h-24 bg-warning/20 rounded-full blur-2xl animate-float-slow" />
      </div>

      {/* Navigation */}
      <Navbar
        isProblemOpen={isProblemOpen}
        onToggleProblem={handleToggleProblem}
        onRun={handleRun}
        onSubmit={handleSubmit}
        selectedLanguage={selectedLanguage}
        onLanguageChange={handleLanguageChange}
      />

      {/* Main Content */}
      <div className="pt-14 h-screen flex flex-col">
        {/* Participant Bar */}
        {/* For 1v1 show single-user icon */}
        {/* For teams show team icon */}
        {/* Participant Bar with battle header */}
        <div className="h-12 glass-subtle flex items-center justify-center px-4 gaming-gradient gap-6">
          <div className="flex items-center gap-3 text-sm font-bold tracking-wide">
            <Swords className="w-4 h-4 text-warning animate-pulse" />
            <span className="text-primary">{battleData.user1}</span>
            <span className="text-warning">vs</span>
            <span className="text-destructive">{battleData.user2}</span>
          </div>
        </div>

        {/* Editor and Problem Panel */}
        <div className="flex-1 flex overflow-hidden">
          {/* Code Editor */}
          <div
            className="transition-panel overflow-hidden"
            style={{ width: isProblemOpen ? '70%' : '100%' }}
          >
            <div className="h-full p-4 pb-0">
              <div className="h-full rounded-lg glass-editor overflow-hidden">
                {/* CHANGE HERE for dynamic language switching - Dynamic file name */}
                <div className="h-8 glass-subtle border-b border-border/30 flex items-center px-3 gap-2">
                  <div className="flex gap-1.5">
                    <div className="w-3 h-3 rounded-full bg-destructive/80" />
                    <div className="w-3 h-3 rounded-full bg-warning/80" />
                    <div className="w-3 h-3 rounded-full bg-success/80" />
                  </div>
                  <span className="text-xs text-muted-foreground ml-2 font-mono">
                    {FILE_NAMES[selectedLanguage]}
                  </span>
                </div>
                <CodeEditor 
                  className="h-[calc(100%-2rem)]" 
                  language={selectedLanguage}
                  onCodeChange={handleCodeChange}
                />
              </div>
            </div>
          </div>

          {/* Problem Panel */}
          <ProblemPanel isOpen={isProblemOpen} />
        </div>

        {/* Status Bar - Simplified */}
        <div className="h-6 glass-subtle border-t border-border/30 flex items-center justify-between px-4 text-xs text-muted-foreground">
          <div className="flex items-center gap-4">
            {/* CHANGE HERE for dynamic language switching */}
            <span>{LANGUAGE_DISPLAY[selectedLanguage]}</span>
            <span>•</span>
            <span>UTF-8</span>
          </div>
          <div className="flex items-center gap-4">
            <span className="text-success">Ready</span>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Index;