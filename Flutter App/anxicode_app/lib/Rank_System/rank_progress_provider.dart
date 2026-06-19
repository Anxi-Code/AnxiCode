import 'package:anxicode_app/Rank_System/rank_progress_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:anxicode_app/Rank_System/user_language_progress.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'rank_progress_provider.g.dart';

@riverpod
RankProgressService rankProgress(Ref ref) {
  return RankProgressService();
}

@riverpod
class UserLanguageProgressNotifier extends _$UserLanguageProgressNotifier {

  @override
  Future<UserLanguageProgress?> build(String languageId) async {
    final userId = Supabase.instance.client.auth.currentUser!.id;

    return ref.read(rankProgressProvider).getProgress(
      userId: userId,
      languageId: languageId,
    );
  }

  Future<void> updateXp(int earnedXp) async {
    final progress = state.value;

    if (progress == null) return;

    final updated = progress.copyWith(
      totalPoints: progress.totalPoints + earnedXp,
    );

    state = AsyncData(updated);
  }

  Future<void> updateRankName(
      String rankName,
      int rankOrder,
      ) async {
    final progress = state.value;

    if (progress == null) return;

    final updated = progress.copyWith(
      currentRankName: rankName,
      currentRankOrder: rankOrder,
      currentRankPart: 1,
      currentTopicIndex: 0,
      ranksCompleted: progress.ranksCompleted + 1,
    );

    state = AsyncData(updated);
  }

  Future<void> updateRankPart(int rankPart) async {
    final progress = state.value;

    if (progress == null) return;

    final updated = progress.copyWith(
      currentRankPart: rankPart,
      currentTopicIndex: 0,
    );

    state = AsyncData(updated);
  }

  Future<void> saveToDatabase() async {
    final progress = state.value;

    if (progress == null) return;

    await Supabase.instance.client
        .from('user_language_progress')
        .update({
      'current_rank_name': progress.currentRankName,
      'current_rank_order': progress.currentRankOrder,
      'current_rank_part': progress.currentRankPart,
      'current_topic_index': progress.currentTopicIndex,
      'total_points': progress.totalPoints,
      'ranks_completed': progress.ranksCompleted,
    })
        .eq('id', progress.id);
  }

  Future<void> updateTopicIndex() async {
    final progress = state.value;

    if (progress == null) return;

    final updated = progress.copyWith(
      currentTopicIndex: progress.currentTopicIndex + 1,
    );

    state = AsyncData(updated);

    await Supabase.instance.client
        .from('user_language_progress')
        .update({
      'current_topic_index': updated.currentTopicIndex,
      'total_points': updated.totalPoints,

    })
        .eq('id', updated.id);
  }
}
