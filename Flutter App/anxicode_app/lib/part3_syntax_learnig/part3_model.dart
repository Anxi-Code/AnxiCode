class SyntaxChallenge {
  final String topic;
  final String taskDescription;
  final String hint;
  final List<String> templateParts; // e.g. ["for(int i=0; ", " ; ", " )"]
  final List<String> correctAnswers; // one per blank

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
      // Safely converts the dynamic lists into Dart String Lists
      templateParts: List<String>.from(json['templateParts'] ?? []),
      correctAnswers: List<String>.from(json['correctAnswers'] ?? []),
    );
  }

  // Converts the SyntaxChallenge object back into a JSON map
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
