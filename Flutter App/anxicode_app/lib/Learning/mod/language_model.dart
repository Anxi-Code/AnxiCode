class LanguageModel {
  final String id;
  final String name;
  final String slug;
  final String icon;

  LanguageModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.icon,
  });

  factory LanguageModel.fromMap(
      Map<String, dynamic> map,
      ) {
    return LanguageModel(
      id: map['id'],
      name: map['name'],
      slug: map['slug'],
      icon: map['icon'],
    );
  }
}