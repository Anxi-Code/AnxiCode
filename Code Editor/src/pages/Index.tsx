// Battle Arena page — frontend shell. All real execution + verdict
// logic comes from the FastAPI backend via src/services/battleService.ts.
import { useState, useCallback, useRef, useEffect } from 'react';
import { Navigate, useNavigate } from 'react-router-dom';
import { useAuth } from '@/contexts/AuthContext';
import { useUserProgress } from '@/hooks/useUserProgress';
import { Navbar } from '@/components/code-battle/Navbar';
import { CodeEditor, SupportedLanguage } from '@/components/code-battle/CodeEditor';
import { ProblemPanel } from '@/components/code-battle/ProblemPanel';
import { Matchmaking } from '@/components/code-battle/Matchmaking';
import { BattleVSOverlay } from '@/components/code-battle/BattleVSOverlay';
import { AntiCheatOverlay } from '@/components/code-battle/AntiCheatOverlay';
import { Swords, Loader2, Trophy, X } from 'lucide-react';
import { toast } from '@/hooks/use-toast';
import {
  runBattleCode,
  submitBattleSolution,
  getRankDurationSeconds,
  BattleSession,
  BattleRunResult,
  BattleVerdict,
} from '@/services/battleService';

const FILE_NAMES: Record<SupportedLanguage, string> = {
  python: 'solution.py',
  cpp: 'solution.cpp',
  java: 'Solution.java',
  javascript: 'solution.js',
};
const LANGUAGE_DISPLAY: Record<SupportedLanguage, string> = {
  python: 'Python 3.11', cpp: 'C++ 17', java: 'Java 17', javascript: 'JavaScript ES6',
};
const MAX_VIOLATIONS = 3;

const Index = () => {
  const { user, loading: authLoading } = useAuth();
  const { battleUnlocked, loading: progLoading } = useUserProgress();
  const navigate = useNavigate();

  const [battle, setBattle] = useState<BattleSession | null>(null);
  const [pending, setPending] = useState<BattleSession | null>(null);
  const [showVS, setShowVS] = useState(false);

  const [isProblemOpen, setIsProblemOpen] = useState(true);
  const [selectedLanguage, setSelectedLanguage] = useState<SupportedLanguage>('python');

  const codeRef = useRef<string>('');
  const [running, setRunning] = useState(false);
  const [submitting, setSubmitting] = useState(false);
  const [editorLocked, setEditorLocked] = useState(false);
  const [runOutput, setRunOutput] = useState<BattleRunResult | null>(null);
  const [verdict, setVerdict] = useState<BattleVerdict | null>(null);

  const [violations, setViolations] = useState(0);
  const [warnOpen, setWarnOpen] = useState(false);
  const submittedRef = useRef(false);

  useEffect(() => {
    if (!authLoading && !progLoading && user && !battleUnlocked && !battle) {
      navigate('/', { replace: true });
    }
  }, [authLoading, progLoading, user, battleUnlocked, battle, navigate]);

  useEffect(() => {
    if (battle) setSelectedLanguage(battle.language as SupportedLanguage);
  }, [battle]);

  const rank = battle?.rank ?? 'phantom';
  const problem = battle?.problem ?? null;
  const timerSeconds = battle?.duration_seconds ?? getRankDurationSeconds(rank);

  const handleRun = useCallback(async () => {
    if (!problem || !battle || running || submitting) return;
    setRunning(true);
    setRunOutput(null);
    try {
      const res = await runBattleCode({
        battle_id: battle.battle_id,
        problem_id: problem.problem_id,
        language: battle.language,
        code: codeRef.current,
        stdin: problem.test_cases?.[0]?.input ?? '',
      });
      setRunOutput(res);
      toast({ title: 'Sandbox executed', description: res.stderr || 'Run complete' });
    } catch (e: any) {
      toast({ title: 'Run failed', description: e.message, variant: 'destructive' });
    } finally {
      setRunning(false);
    }
  }, [problem, battle, running, submitting]);

  const handleSubmit = useCallback(async (forced = false) => {
    if (!battle || !problem || submittedRef.current) return;
    submittedRef.current = true;
    setSubmitting(true);
    setEditorLocked(true);
    try {
      const res = await submitBattleSolution({
        battle_id: battle.battle_id,
        problem_id: problem.problem_id,
        language: battle.language,
        code: codeRef.current,
      });
      setVerdict(res);
      if (forced) {
        toast({ title: 'Forced submission', description: 'Your code was auto-submitted.', variant: 'destructive' });
      }
    } catch (e: any) {
      toast({ title: 'Submission failed', description: e.message, variant: 'destructive' });
      submittedRef.current = false;
      setEditorLocked(false);
    } finally {
      setSubmitting(false);
    }
  }, [battle, problem]);

  const forceSubmit = useCallback(() => handleSubmit(true), [handleSubmit]);

  useEffect(() => {
    if (!battle || verdict) return;
    const triggerViolation = () => {
      if (submittedRef.current) return;
      setViolations((v) => {
        const next = v + 1;
        if (next >= MAX_VIOLATIONS) { setWarnOpen(false); forceSubmit(); }
        else setWarnOpen(true);
        return next;
      });
    };
    const onVisibility = () => {
      if (document.visibilityState === 'hidden') triggerViolation();
      else setWarnOpen(false);
    };
    const onBlur = () => triggerViolation();
    const onFocus = () => setWarnOpen(false);
    document.addEventListener('visibilitychange', onVisibility);
    window.addEventListener('blur', onBlur);
    window.addEventListener('focus', onFocus);
    return () => {
      document.removeEventListener('visibilitychange', onVisibility);
      window.removeEventListener('blur', onBlur);
      window.removeEventListener('focus', onFocus);
    };
  }, [battle, verdict, forceSubmit]);

  if (authLoading) return null;
  if (!user) return <Navigate to="/auth" replace />;

  if (!battle) {
    return (
      <>
        <Matchmaking
          onMatchFound={(session) => { setPending(session); setShowVS(true); }}
        />
        {showVS && pending && (
          <BattleVSOverlay
            user1={pending.self.user_name}
            user2={pending.opponent.user_name}
            duration={5000}
            onComplete={() => { setBattle(pending); setShowVS(false); }}
          />
        )}
      </>
    );
  }

  return (
    <div className="min-h-screen bg-[radial-gradient(ellipse_at_top_right,_hsl(var(--primary)/0.15)_0%,_transparent_50%),radial-gradient(ellipse_at_bottom_left,_hsl(var(--success)/0.1)_0%,_transparent_50%),hsl(var(--background))] relative overflow-hidden">
      <div className="absolute inset-0 overflow-hidden pointer-events-none z-0">
        <div className="absolute top-20 right-[20%] w-32 h-32 bg-primary/20 rounded-full blur-3xl animate-float" />
        <div className="absolute bottom-40 left-[15%] w-40 h-40 bg-success/15 rounded-full blur-3xl animate-float-delayed" />
      </div>

      <Navbar
        isProblemOpen={isProblemOpen}
        onToggleProblem={() => setIsProblemOpen((p) => !p)}
        onRun={handleRun}
        onSubmit={() => handleSubmit(false)}
        selectedLanguage={selectedLanguage}
        onLanguageChange={setSelectedLanguage}
        timerSeconds={timerSeconds}
        onTimeUp={forceSubmit}
        running={running}
        submitting={submitting}
        languageLocked
      />

      <div className="pt-14 h-screen flex flex-col">
        <div className="h-12 glass-subtle flex items-center justify-center px-4 gap-6">
          <div className="flex items-center gap-3 text-sm font-bold tracking-wide">
            <Swords className="w-4 h-4 text-warning animate-pulse" />
            <span className="text-primary">{battle.self.user_name}</span>
            <span className="text-warning">vs</span>
            <span className="text-destructive">{battle.opponent.user_name}</span>
            <span className="ml-3 px-2 py-0.5 rounded-md bg-warning/10 border border-warning/30 text-warning text-[10px] uppercase tracking-widest">
              {rank}
            </span>
          </div>
        </div>

        <div className="flex-1 flex overflow-hidden">
          <div className="transition-panel overflow-hidden" style={{ width: isProblemOpen ? '70%' : '100%' }}>
            <div className="h-full p-4 pb-0">
              <div className="h-full rounded-lg glass-editor overflow-hidden relative">
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
                  onCodeChange={(c) => { codeRef.current = c; }}
                />
                {editorLocked && (
                  <div className="absolute inset-0 bg-background/60 backdrop-blur-sm flex items-center justify-center z-10">
                    <div className="px-4 py-2 rounded-lg bg-destructive/20 border border-destructive/40 text-destructive font-bold text-sm uppercase tracking-widest">
                      Editor Locked
                    </div>
                  </div>
                )}
              </div>
            </div>
          </div>

          <ProblemPanel
            isOpen={isProblemOpen}
            problems={problem ? [problem as any] : []}
            loading={false}
            error={null}
            rank={rank}
            language={battle.language}
          />
        </div>

        <div className="h-6 glass-subtle border-t border-border/30 flex items-center justify-between px-4 text-xs text-muted-foreground">
          <div className="flex items-center gap-4">
            <span>{LANGUAGE_DISPLAY[selectedLanguage]}</span>
            <span>•</span>
            <span>UTF-8</span>
            {violations > 0 && (
              <>
                <span>•</span>
                <span className="text-destructive">Violations {violations}/{MAX_VIOLATIONS}</span>
              </>
            )}
          </div>
          <span className={editorLocked ? 'text-destructive' : 'text-success'}>
            {editorLocked ? 'Locked' : 'Ready'}
          </span>
        </div>
      </div>

      {runOutput && (
        <div className="fixed bottom-8 right-4 z-40 max-w-md w-full rounded-xl border border-primary/30 bg-background/95 backdrop-blur p-4 shadow-[0_0_40px_hsl(var(--primary)/0.3)] animate-in slide-in-from-bottom-4">
          <div className="flex items-center justify-between mb-2">
            <div className="text-xs font-bold tracking-widest uppercase text-primary">Sandbox Output</div>
            <button onClick={() => setRunOutput(null)} className="text-muted-foreground hover:text-foreground">
              <X className="w-4 h-4" />
            </button>
          </div>
          {runOutput.stdout && (
            <pre className="text-xs font-mono bg-secondary/40 rounded p-2 max-h-40 overflow-auto whitespace-pre-wrap">{runOutput.stdout}</pre>
          )}
          {runOutput.stderr && (
            <pre className="mt-2 text-xs font-mono bg-destructive/10 text-destructive rounded p-2 max-h-40 overflow-auto whitespace-pre-wrap">{runOutput.stderr}</pre>
          )}
          {runOutput.execution_time_ms !== undefined && (
            <div className="text-[10px] mt-2 text-muted-foreground uppercase tracking-widest">{runOutput.execution_time_ms}ms</div>
          )}
        </div>
      )}

      <AntiCheatOverlay active={warnOpen} violationCount={violations} maxViolations={MAX_VIOLATIONS} onTimeout={forceSubmit} />

      {(submitting || verdict) && (
        <div className="fixed inset-0 z-[150] flex items-center justify-center bg-background/80 backdrop-blur-xl p-4">
          <div className="relative max-w-lg w-full rounded-2xl border-2 border-primary/40 bg-background/95 p-8 shadow-[0_0_80px_hsl(var(--primary)/0.4)]">
            {submitting && !verdict ? (
              <div className="text-center">
                <Loader2 className="w-12 h-12 text-primary animate-spin mx-auto mb-4" />
                <h2 className="text-2xl font-black tracking-wider bg-gradient-to-r from-primary to-warning bg-clip-text text-transparent">
                  CALCULATING VERDICT
                </h2>
                <p className="text-sm text-muted-foreground mt-2">AI engine evaluating both solutions...</p>
              </div>
            ) : verdict ? (
              <div>
                <div className="flex items-center gap-3 mb-4">
                  <Trophy className="w-10 h-10 text-warning" />
                  <h2 className="text-2xl font-black tracking-wider uppercase">{verdict.verdict}</h2>
                </div>
                <div className="grid grid-cols-2 gap-3 text-center mb-4">
                  <div className="rounded-lg border border-primary/30 bg-primary/10 p-3">
                    <div className="text-[10px] uppercase tracking-widest text-muted-foreground">You</div>
                    <div className="text-2xl font-black text-primary">{verdict.user_a_score ?? '—'}</div>
                  </div>
                  <div className="rounded-lg border border-destructive/30 bg-destructive/10 p-3">
                    <div className="text-[10px] uppercase tracking-widest text-muted-foreground">Opponent</div>
                    <div className="text-2xl font-black text-destructive">{verdict.user_b_score ?? '—'}</div>
                  </div>
                </div>
                {verdict.ai_summary && (
                  <div className="rounded-lg bg-secondary/40 border border-border/40 p-3 text-xs text-foreground whitespace-pre-wrap max-h-48 overflow-auto">
                    {verdict.ai_summary}
                  </div>
                )}
                <button
                  onClick={() => navigate('/')}
                  className="mt-6 w-full h-11 rounded-lg bg-gradient-to-r from-primary via-fuchsia-500 to-warning text-primary-foreground font-black tracking-[0.2em] uppercase hover:scale-[1.02] transition"
                >
                  Return to Lobby
                </button>
              </div>
            ) : null}
          </div>
        </div>
      )}
    </div>
  );
};

export default Index;
