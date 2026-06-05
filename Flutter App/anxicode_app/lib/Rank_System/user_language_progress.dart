class UserLanguageProgress {
  final int idx;
  final String id;
  final String userId;
  final String languageId;

  final String currentRankName;
  final int currentRankOrder;
  final int currentRankPart;

  final int totalPoints;
  final int ranksCompleted;

  final int currentTopicIndex; // ✅ NEW FIELD

  final DateTime updatedAt;

  UserLanguageProgress({
    required this.idx,
    required this.id,
    required this.userId,
    required this.languageId,
    required this.currentRankName,
    required this.currentRankOrder,
    required this.currentRankPart,
    required this.totalPoints,
    required this.ranksCompleted,
    required this.currentTopicIndex,
    required this.updatedAt,
  });

  factory UserLanguageProgress.fromJson(Map<String, dynamic> json) {
    return UserLanguageProgress(
      idx: json['idx'] ?? 0,
      id: json['id'] ?? '',
      userId: json['user_id'] ?? '',
      languageId: json['language_id'] ?? '',
      currentRankName: json['current_rank_name'] ?? '',
      currentRankOrder: json['current_rank_order'] ?? 0,
      currentRankPart: json['current_rank_part'] ?? 1,
      totalPoints: json['total_points'] ?? 0,
      ranksCompleted: json['ranks_completed'] ?? 0,
      currentTopicIndex: json['current_topic_index'] ?? 0, // ✅ NEW
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idx': idx,
      'id': id,
      'user_id': userId,
      'language_id': languageId,
      'current_rank_name': currentRankName,
      'current_rank_order': currentRankOrder,
      'current_rank_part': currentRankPart,
      'total_points': totalPoints,
      'ranks_completed': ranksCompleted,
      'current_topic_index': currentTopicIndex, // ✅ NEW
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  UserLanguageProgress copyWith({
    int? currentTopicIndex,
    String? currentRankName,
    int? currentRankOrder,
    int? currentRankPart,
    int? totalPoints,
    int? ranksCompleted,
  }) {
    return UserLanguageProgress(
      idx: idx,
      id: id,
      userId: userId,
      languageId: languageId,
      currentRankName: currentRankName ?? this.currentRankName,
      currentRankOrder: currentRankOrder ?? this.currentRankOrder,
      currentRankPart: currentRankPart ?? this.currentRankPart,
      totalPoints: totalPoints ?? this.totalPoints,
      ranksCompleted: ranksCompleted ?? this.ranksCompleted,
      currentTopicIndex: currentTopicIndex ?? this.currentTopicIndex,
      updatedAt: updatedAt,
    );
  }
}