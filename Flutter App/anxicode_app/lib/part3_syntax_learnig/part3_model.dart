class SyntaxChallenge {
  final String topic;
  final String taskDescription;
  final String hint;
  final List<String> templateParts;
  final List<String> correctAnswers;

  const SyntaxChallenge({
    required this.topic,
    required this.taskDescription,
    required this.hint,
    required this.templateParts,
    required this.correctAnswers,
  });
  factory SyntaxChallenge.fromJson(Map<String, dynamic> json) {
    return SyntaxChallenge(
      topic: json['topic'] ?? '',
      taskDescription: json['taskDescription'] ?? '',
      hint: json['hint'] ?? '',

      templateParts: List<String>.from(json['templateParts'] ?? []),
      correctAnswers: List<String>.from(json['correctAnswers'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'topic': topic,
      'taskDescription': taskDescription,
      'hint': hint,
      'templateParts': templateParts,
      'correctAnswers': correctAnswers,
    };
  }
}
