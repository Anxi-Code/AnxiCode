class FilePart {
  final String filePath;

  FilePart({
    required this.filePath,
  });

  FilePart copyWith({
    String? filePath,
  }) {
    return FilePart(
      filePath: filePath ?? this.filePath,
    );
  }

  factory FilePart.fromJson(Map<String, dynamic> json) {
    return FilePart(
      filePath: json['file_path'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'file_path': filePath,
    };
  }
}