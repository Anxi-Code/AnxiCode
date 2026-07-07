// ============================================================
// Battle service — Run + Submit endpoints (FastAPI)
// ------------------------------------------------------------
// This is the SECOND of the two FastAPI integrations the frontend
// needs. Configure the base URL in:  src/config/api.ts
//
// Endpoints expected on the FastAPI side:
//   POST {BATTLE_API_URL}/run     -> execute code, return stdout/err
//   POST {BATTLE_API_URL}/submit  -> evaluate both players, return verdict
//   GET  {BATTLE_API_URL}/match   -> (optional) matchmaking poll
//   GET  {BATTLE_API_URL}/session/{id} -> fetch active battle data
// ============================================================
import { BATTLE_API_URL, AUTH_TOKEN_STORAGE_KEY } from '@/config/api';
import {
  BattleProblem,
  BattleRunResult,
  BattleSession,
  BattleVerdict,
  LanguageSlug,
} from '@/types';
import { MOCK_BATTLE_SESSION } from '@/mocks/data';

const token = () => localStorage.getItem(AUTH_TOKEN_STORAGE_KEY);

async function post<T>(path: string, body: unknown): Promise<T> {
  const res = await fetch(`${BATTLE_API_URL}${path}`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      ...(token() ? { Authorization: `Bearer ${token()}` } : {}),
    },
    body: JSON.stringify(body),
  });
  const text = await res.text();
  const data = text ? JSON.parse(text) : ({} as T);
  if (!res.ok) throw new Error((data as any)?.detail || `Battle request failed (${res.status})`);
  return data as T;
}

const delay = (ms = 600) => new Promise((r) => setTimeout(r, ms));

// ---------- Matchmaking / session (UI-only mock) ----------
export interface MatchRequest { language: LanguageSlug; rank: string; }

export async function findMatch(_req: MatchRequest): Promise<BattleSession> {
  // TODO: return await fetch(`${BATTLE_API_URL}/match?...`).then(r=>r.json());
  await delay(1200);
  return MOCK_BATTLE_SESSION;
}

export async function getBattle(_battleId: string): Promise<BattleSession> {
  // TODO: real fetch
  await delay();
  return MOCK_BATTLE_SESSION;
}

// ---------- Run code ----------
export interface RunRequest {
  battle_id: string;
  problem_id: string;
  language: LanguageSlug;
  code: string;
  stdin?: string;
}

export async function runBattleCode(req: RunRequest): Promise<BattleRunResult> {
  // TODO: return post<BattleRunResult>('/run', req);
  await delay(800);
  return {
    stdout: `// mock run for ${req.language}\nHello from sandbox`,
    passed: true,
    execution_time_ms: 42,
  };
}

// ---------- Submit solution ----------
export interface SubmitRequest {
  battle_id: string;
  problem_id: string;
  language: LanguageSlug;
  code: string;
}

export async function submitBattleSolution(req: SubmitRequest): Promise<BattleVerdict> {
  // TODO: return post<BattleVerdict>('/submit', req);
  await delay(2000);
  return {
    winner_user_id: MOCK_BATTLE_SESSION.self.user_id,
    verdict: 'victory',
    user_a_score: 47,
    user_b_score: 39,
    ai_summary:
      'Your solution passed all hidden tests in 42ms with clean structure. Opponent passed 4/5 tests with higher memory usage.',
  };
}

// Re-export for components that import from here
export type { BattleSession, BattleProblem, BattleRunResult, BattleVerdict };

// Rank → duration (mirrors backend defaults; backend may override per response).
export const RANK_DURATION_SECONDS: Record<string, number> = {
  phantom: 15 * 60,
  apex: 20 * 60,
  zenith: 35 * 60,
  legendary: 45 * 60,
};
export const getRankDurationSeconds = (rank: string) =>
  RANK_DURATION_SECONDS[rank.toLowerCase()] ?? 15 * 60;
