class McqQuestion {

  final String question;
  final List<String> options;
  final int answer;

  McqQuestion({

    required this.question,
    required this.options,
    required this.answer,

  });

  factory McqQuestion.fromJson(Map<String, dynamic> json) {
    return McqQuestion(

      question: json['q'],
      options: List<String>.from(json['options']),
      answer: json['answer'],

    );
  }

  Map<String, dynamic> toJson() {
    return {

      'q': question,
      'options': options,
      'answer': answer,

    };
  }
}