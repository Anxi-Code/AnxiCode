import 'package:anxicode_app/Learning/mod/mcqs_model.dart';

class McqQuiz {
  final String topic;
  final List<McqQuestion> quizzes;

  McqQuiz({
    required this.topic,
     required this.quizzes,
  });

  factory McqQuiz.fromJson(Map<String, dynamic> json) {
    return McqQuiz(
      topic: json['topic'],
      quizzes: (json['quizzes'] as List)
          .map((e) => McqQuestion.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'topic': topic,
      'quizzes': quizzes.map((e) => e.toJson()).toList(),
    };
  }
}