import 'package:anxicode_app/Learning/mod/answer_review.dart';

class QuizResult {
  final String topicName;
  final String subjectName;

  final int totalQuestions;
  final int correctAnswers;
  final int wrongAnswers;

  final double percentage;

  final Duration totalTime;
  final Duration avgTimePerAnswer;

  final String nextChapter;

  final List<AnswerReview> answers;

  const QuizResult({
    required this.topicName,
    required this.subjectName,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.wrongAnswers,
    required this.percentage,
    required this.totalTime,
    required this.avgTimePerAnswer,
    required this.nextChapter,
    required this.answers,
  });
  const QuizResult.empty()
      : topicName = '',
        subjectName = '',
        totalQuestions = 0,
        correctAnswers = 0,
        wrongAnswers = 0,
        percentage = 0.0,
        totalTime = Duration.zero,
        avgTimePerAnswer = Duration.zero,
        nextChapter = '',
        answers = const [];
}