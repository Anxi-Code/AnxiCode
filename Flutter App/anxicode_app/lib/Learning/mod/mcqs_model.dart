class McqQuestion {
  final String type;
  final String question;
  final List<String> options;
  final int answer;
  final String explanation;

  McqQuestion({
    required this.type,
    required this.question,
    required this.options,
    required this.answer,
    required this.explanation,
  });

  factory McqQuestion.fromJson(Map<String, dynamic> json) {
    return McqQuestion(
      type: json['type'],
      question: json['q'],
      options: List<String>.from(json['options']),
      answer: json['answer'],
      explanation: json['explanation'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'q': question,
      'options': options,
      'answer': answer,
      'explanation': explanation,
    };
  }
}