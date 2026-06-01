import 'package:anxicode_app/Learning/mod/mcqs_model.dart';

class McqQuiz {
  final String topic;
  //final String language;
  //final String part;
  final List<McqQuestion> quizzes;

  McqQuiz({
    required this.topic,
    //required this.language,
    //required this.part,
    required this.quizzes,
  });

  factory McqQuiz.fromJson(Map<String, dynamic> json) {
    return McqQuiz(
      topic: json['topic'],
      //language: json['language'],
      //part: json['part'],
      quizzes: (json['quizzes'] as List)
          .map((e) => McqQuestion.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'topic': topic,
      //'language': language,
      //'part': part,
      'quizzes': quizzes.map((e) => e.toJson()).toList(),
    };
  }
}