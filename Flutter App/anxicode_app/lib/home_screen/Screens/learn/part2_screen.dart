import 'package:anxicode_app/Learning/mod/part2.dart';
import 'package:anxicode_app/Learning/mod/quiz_result.dart';
import 'package:anxicode_app/design/Quiz/mcqs_design.dart';
import 'package:anxicode_app/design/Quiz/topic_screen.dart';
import 'package:anxicode_app/design/bg_gradient/bg_gradient.dart';
import 'package:anxicode_app/home_screen/Screens/learn/result_screen.dart';
import 'package:flutter/material.dart';

class Part2Screen extends StatefulWidget {
  final Part2Topic part2topic;
  final String slug;
  final String nextTopic;
  final String languageId;
  final VoidCallback nextPage;
  final int totalTopicsCount;

  const Part2Screen({
    super.key,
    required this.slug,
    required this.languageId,
    required this.part2topic,
    required this.nextTopic,
    required this.nextPage,
    required this.totalTopicsCount,
  });

  @override
  State<Part2Screen> createState() => _Part2ScreenState();
}

class _Part2ScreenState extends State<Part2Screen> {
  final PageController _controller = PageController(viewportFraction: 1.0);
  QuizResult result = QuizResult.empty();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void goToQuiz() {
    _controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  void goToResult(QuizResult quizResult) {
    setState(() {
      result = quizResult;
    });
    _controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  void resetChallenge() {
    _controller.animateToPage(
      0,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _controller,
      itemCount: 3,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        switch (index) {
          case 0:
            return TopicScreen(
              goToQuiz: goToQuiz,
              topicName: widget.part2topic.topicName,
              slug: widget.slug,
              path: widget.part2topic.explainFile,
            );

          case 1:
            return Mcqs(
              goToResult: goToResult,
              slug: widget.slug,
              path: widget.part2topic.quizFile,
              nextTopic: widget.nextTopic,
            );

          case 2:
            return ResultScreen(
              result: result,
              languageId: widget.languageId,
              nextPage: widget.nextPage,
              onResetChallenge: resetChallenge,
              totalTopicsCount: widget.totalTopicsCount,
            );

          default:
            return const Stack(
              children: [
                BgGradient(),
                Center(child: CircularProgressIndicator(color: Colors.cyanAccent))
              ],
            );
        }
      },
    );
  }
}