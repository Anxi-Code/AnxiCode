import 'package:anxicode_app/Learning/mod/parts_model.dart';

class RankManifest {
  final String language;
  final String languageId;
  final String slug;
  final String rank;
  final int rankOrder;
  final PartsModel parts;

  RankManifest({
    required this.language,
    required this.languageId,
    required this.slug,
    required this.rank,
    required this.rankOrder,
    required this.parts,
  });

  RankManifest copyWith({
    String? language,
    String? languageId,
    String? slug,
    String? rank,
    int? rankOrder,
    PartsModel? parts,
  }) {
    return RankManifest(
      language: language ?? this.language,
      languageId: languageId ?? this.languageId,
      slug: slug ?? this.slug,
      rank: rank ?? this.rank,
      rankOrder: rankOrder ?? this.rankOrder,
      parts: parts ?? this.parts,
    );
  }

  factory RankManifest.fromJson(Map<String, dynamic> json) {
    return RankManifest(
      language: json['language'],
      languageId: json['language_id'],
      slug: json['slug'],
      rank: json['rank'],
      rankOrder: json['rank_order'],
      parts: PartsModel.fromJson(json['parts']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'language': language,
      'language_id': languageId,
      'slug': slug,
      'rank': rank,
      'rank_order': rankOrder,
      'parts': parts.toJson(),
    };
  }
}