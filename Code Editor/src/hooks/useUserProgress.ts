// Frontend-only hook backed by the API service layer.
// All data is supplied by the FastAPI backend (see apiService.getLanguageProgress).
import { useEffect, useState, useCallback } from 'react';
import * as api from '@/services/apiService';
import { LanguageProgress, RankName } from '@/types';

export const PHANTOM_RANK_ORDER = 3;

export const useUserProgress = () => {
  const [progress, setProgress] = useState<LanguageProgress[]>([]);
  const [loading, setLoading] = useState(true);

  const refresh = useCallback(async () => {
    setLoading(true);
    try {
      const data = await api.getLanguageProgress();
      setProgress(data);
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => { refresh(); }, [refresh]);

  const isLanguageBattleUnlocked = (lp: LanguageProgress) =>
    lp.rank_order >= PHANTOM_RANK_ORDER;
  const battleUnlocked = progress.some(isLanguageBattleUnlocked);

  const highestRank: { name: RankName; order: number } = progress.reduce(
    (acc, p) => (p.rank_order > acc.order ? { name: p.rank_name, order: p.rank_order } : acc),
    { name: 'Rookie' as RankName, order: 1 },
  );

  return { progress, loading, battleUnlocked, isLanguageBattleUnlocked, highestRank, refresh };
};

export type { LanguageProgress };
