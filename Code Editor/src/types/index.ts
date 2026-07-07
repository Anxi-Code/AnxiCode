// Shared type definitions for the AnxiCode frontend shell.
// These describe the JSON shapes the FastAPI backend should return.

export type LanguageSlug = 'python' | 'cpp' | 'java' | 'javascript';

export type RankName =
  | 'Rookie'
  | 'Apprentice'
  | 'Phantom'
  | 'Apex'
  | 'Zenith'
  | 'Legendary';

export interface UserProfile {
  id: string;
  user_name: string;
  name: string;
  email: string;
  avatar_url?: string | null;
  created_at?: string;
}

export interface LanguageProgress {
  language: LanguageSlug;
  rank_name: RankName;
  rank_order: number;     // 1..6
  rank_part: number;      // 1..N
  total_points: number;
  ranks_completed: number;
}

export interface UserStats {
  overall_rank: RankName;
  overall_xp: number;
  battles_played: number;
  battles_won: number;
  win_rate: number;        // 0..1
  confidence: number;      // 0..1
  streak_days: number;
}

export interface Achievement {
  id: string;
  title: string;
  description: string;
  icon: string;            // lucide icon name, free string
  unlocked: boolean;
  unlocked_at?: string | null;
  progress?: number;       // 0..1 when locked
}

export interface LeaderboardEntry {
  rank: number;
  user_id: string;
  user_name: string;
  total_xp: number;
  highest_rank: RankName;
  wins: number;
  country?: string | null;
}

export interface BattleProblemExample {
  input: string;
  output: string;
  explanation?: string;
}

export interface BattleProblem {
  problem_id: string;
  title: string;
  difficulty: 'Easy' | 'Medium' | 'Hard' | 'Insane';
  description: string;
  constraints: string[];
  examples: BattleProblemExample[];
  test_cases?: { input: string; expected_output: string }[];
}

export interface BattleSession {
  battle_id: string;
  rank: string;
  language: LanguageSlug;
  duration_seconds: number;
  self: { user_id: string; user_name: string };
  opponent: { user_id: string; user_name: string };
  problem: BattleProblem;
}

export interface BattleRunResult {
  stdout?: string;
  stderr?: string;
  passed?: boolean;
  execution_time_ms?: number;
  error?: string;
}

export interface BattleVerdict {
  winner_user_id: string | null;
  verdict: 'victory' | 'defeat' | 'draw';
  user_a_score: number;
  user_b_score: number;
  ai_summary?: string;
  metrics?: Record<string, unknown>;
}
