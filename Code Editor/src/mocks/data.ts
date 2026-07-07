// Mock data — used by the API service layer while the FastAPI backend
// is being built. Swap out by replacing the `return mockX` lines in
// src/services/apiService.ts and src/services/battleService.ts.
import {
  Achievement,
  BattleProblem,
  BattleSession,
  LanguageProgress,
  LeaderboardEntry,
  UserProfile,
  UserStats,
} from '@/types';

export const MOCK_PROFILE: UserProfile = {
  id: 'u-001',
  user_name: 'shadowbyte',
  name: 'Aarav Khan',
  email: 'aarav@anxicode.dev',
  avatar_url: null,
  created_at: new Date().toISOString(),
};

export const MOCK_PROGRESS: LanguageProgress[] = [
  { language: 'python',     rank_name: 'Phantom',    rank_order: 3, rank_part: 2, total_points: 4820, ranks_completed: 2 },
  { language: 'cpp',        rank_name: 'Apex',       rank_order: 4, rank_part: 1, total_points: 6210, ranks_completed: 3 },
  { language: 'java',       rank_name: 'Apprentice', rank_order: 2, rank_part: 3, total_points: 2105, ranks_completed: 1 },
  { language: 'javascript', rank_name: 'Zenith',     rank_order: 5, rank_part: 1, total_points: 8430, ranks_completed: 4 },
];

export const MOCK_STATS: UserStats = {
  overall_rank: 'Zenith',
  overall_xp: 21565,
  battles_played: 84,
  battles_won: 61,
  win_rate: 0.726,
  confidence: 0.82,
  streak_days: 12,
};

export const MOCK_ACHIEVEMENTS: Achievement[] = [
  { id: 'a1', title: 'First Blood',      description: 'Win your first battle.',          icon: 'Swords',   unlocked: true,  unlocked_at: '2026-05-12' },
  { id: 'a2', title: 'Phantom Ascended', description: 'Reach Phantom in any language.',  icon: 'Sparkles', unlocked: true,  unlocked_at: '2026-05-21' },
  { id: 'a3', title: 'Polyglot',         description: 'Hit Apex in 2 languages.',        icon: 'Languages',unlocked: true,  unlocked_at: '2026-06-02' },
  { id: 'a4', title: 'Streak Master',    description: '30-day coding streak.',           icon: 'Flame',    unlocked: false, progress: 0.4 },
  { id: 'a5', title: 'Legendary',        description: 'Reach Legendary in any language.',icon: 'Crown',    unlocked: false, progress: 0.15 },
  { id: 'a6', title: 'Untouchable',      description: 'Win 10 battles in a row.',        icon: 'Shield',   unlocked: false, progress: 0.6 },
];

export const MOCK_LEADERBOARD: LeaderboardEntry[] = [
  { rank: 1,  user_id: 'u-101', user_name: 'nullbyte',      total_xp: 48210, highest_rank: 'Legendary', wins: 142 },
  { rank: 2,  user_id: 'u-102', user_name: 'kairo_dev',     total_xp: 41020, highest_rank: 'Legendary', wins: 119 },
  { rank: 3,  user_id: 'u-103', user_name: 'lumen',         total_xp: 38740, highest_rank: 'Zenith',    wins: 108 },
  { rank: 4,  user_id: 'u-104', user_name: 'syntaxsmith',   total_xp: 32101, highest_rank: 'Zenith',    wins: 96 },
  { rank: 5,  user_id: 'u-001', user_name: 'shadowbyte',    total_xp: 21565, highest_rank: 'Zenith',    wins: 61 },
  { rank: 6,  user_id: 'u-105', user_name: 'glitchqueen',   total_xp: 19432, highest_rank: 'Apex',      wins: 54 },
  { rank: 7,  user_id: 'u-106', user_name: 'voidwalker',    total_xp: 17820, highest_rank: 'Apex',      wins: 49 },
  { rank: 8,  user_id: 'u-107', user_name: 'cipher',        total_xp: 16330, highest_rank: 'Apex',      wins: 47 },
  { rank: 9,  user_id: 'u-108', user_name: 'morpheus',      total_xp: 14990, highest_rank: 'Phantom',   wins: 41 },
  { rank: 10, user_id: 'u-109', user_name: 'neon_oracle',   total_xp: 13210, highest_rank: 'Phantom',   wins: 38 },
];

export const MOCK_PROBLEM: BattleProblem = {
  problem_id: 'phantom-001',
  title: 'Quantum Path Finder',
  difficulty: 'Hard',
  description:
    'Given a weighted DAG, find the path of maximum quantum coherence between source and sink nodes. ' +
    'A path is valid if the sum of edge weights modulo 7 equals zero.',
  constraints: [
    '1 ≤ N ≤ 10^5',
    '1 ≤ M ≤ 2·10^5',
    'Edge weights are integers in [-10^9, 10^9]',
    'Time limit: 2s',
  ],
  examples: [
    { input: '4 4\n1 2 3\n2 3 4\n1 3 7\n3 4 7', output: '14', explanation: '1→3→4 has total 14 (mod 7 = 0).' },
    { input: '2 1\n1 2 5', output: '-1', explanation: 'No valid path.' },
  ],
  test_cases: [
    { input: '4 4\n1 2 3\n2 3 4\n1 3 7\n3 4 7', expected_output: '14' },
  ],
};

export const MOCK_BATTLE_SESSION: BattleSession = {
  battle_id: 'b-mock-1',
  rank: 'phantom',
  language: 'python',
  duration_seconds: 15 * 60,
  self:     { user_id: MOCK_PROFILE.id, user_name: MOCK_PROFILE.user_name },
  opponent: { user_id: 'u-999',         user_name: 'darkmatter' },
  problem: MOCK_PROBLEM,
};
