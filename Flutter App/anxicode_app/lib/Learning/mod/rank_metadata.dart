class RankMetadata {
  final int idx;
  final String id;
  final String languageId;
  final String languageSlug;
  final String rankName;
  final int rankOrder;
  final String manifestPath;
  final String createdAt;

  RankMetadata({
    required this.idx,
    required this.id,
    required this.languageId,
    required this.languageSlug,
    required this.rankName,
    required this.rankOrder,
    required this.manifestPath,
    required this.createdAt,
  });

  RankMetadata copyWith({
    int? idx,
    String? id,
    String? languageId,
    String? languageSlug,
    String? rankName,
    int? rankOrder,
    String? manifestPath,
    String? createdAt,
  }) {
    return RankMetadata(
      idx: idx ?? this.idx,
      id: id ?? this.id,
      languageId: languageId ?? this.languageId,
      languageSlug: languageSlug ?? this.languageSlug,
      rankName: rankName ?? this.rankName,
      rankOrder: rankOrder ?? this.rankOrder,
      manifestPath: manifestPath ?? this.manifestPath,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory RankMetadata.fromMap(Map<String, dynamic> map) {
    return RankMetadata(
      idx: map['idx'],
      id: map['id'],
      languageId: map['language_id'],
      languageSlug: map['language_slug'],
      rankName: map['rank_name'],
      rankOrder: map['rank_order'],
      manifestPath: map['manifest_path'],
      createdAt: map['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idx': idx,
      'id': id,
      'language_id': languageId,
      'language_slug': languageSlug,
      'rank_name': rankName,
      'rank_order': rankOrder,
      'manifest_path': manifestPath,
      'created_at': createdAt,
    };
  }
}