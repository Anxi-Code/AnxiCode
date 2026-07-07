// Frontend-only mock; the FastAPI backend will supply the real problem
// as part of the BattleSession payload.
import { useEffect, useState } from 'react';
import { BattleProblem, LanguageSlug } from '@/types';
import * as api from '@/services/apiService';

export type { BattleProblem };

export const useBattleProblems = (
  language: LanguageSlug | string = 'python',
  rank: string = 'phantom',
) => {
  const [problem, setProblem] = useState<BattleProblem | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    let cancel = false;
    setLoading(true);
    api
      .getProblem(`${rank}-${language}`)
      .then((p) => { if (!cancel) setProblem(p); })
      .catch((e) => { if (!cancel) setError(e?.message ?? 'Failed to load problem'); })
      .finally(() => { if (!cancel) setLoading(false); });
    return () => { cancel = true; };
  }, [language, rank]);

  return { problem, loading, error };
};
