class RankModel {
  final String id;
  final String languageId;
  final String rankName;
  final int rankOrder;
  final String description;
  final String? unlockMessage;

  RankModel({
    required this.id,
    required this.languageId,
    required this.rankName,
    required this.rankOrder,
    required this.description,
    this.unlockMessage,
  });

  factory RankModel.fromMap(
      Map<String, dynamic> map,
      ) {
    return RankModel(
      id: map['id'],
      languageId: map['language_id'],
      rankName: map['rank_name'],
      rankOrder: map['rank_order'],
      description: map['description'],
      unlockMessage: map['unlock_message'],
    );
  }
}