// ============================================================
// 🛠️  EDIT THIS FILE TO POINT THE FRONTEND AT YOUR FASTAPI BACKEND
// ============================================================
// The web app talks to TWO FastAPI services:
//
//   1. BATTLE_API_URL  -> Handles `run` + `submit` for the Battle Arena.
//                         Endpoints:
//                           POST {BATTLE_API_URL}/run
//                           POST {BATTLE_API_URL}/submit
//
//   2. CORE_API_URL    -> Handles everything else (auth, profile,
//                         leaderboard, problems, progress, achievements).
//                         See src/services/apiService.ts for the full
//                         list of endpoints the frontend calls.
//
// You can override these at build/runtime via Vite env vars:
//   VITE_BATTLE_API_URL=...
//   VITE_CORE_API_URL=...
// ============================================================

const stripTrailingSlash = (u: string) => u.replace(/\/$/, '');

export const BATTLE_API_URL = stripTrailingSlash(
  (import.meta.env.VITE_BATTLE_API_URL as string | undefined) ||
    'http://localhost:8000/battle',
);

export const CORE_API_URL = stripTrailingSlash(
  (import.meta.env.VITE_CORE_API_URL as string | undefined) ||
    'http://localhost:8000/api',
);

/** Optional: token storage key used by apiService for the Authorization header. */
export const AUTH_TOKEN_STORAGE_KEY = 'anxicode_token';
