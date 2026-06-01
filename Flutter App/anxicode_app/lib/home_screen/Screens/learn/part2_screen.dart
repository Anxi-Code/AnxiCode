import 'package:anxicode_app/Learning/mod/part1.dart';
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
  final VoidCallback nextPage;

  const Part2Screen({super.key, required this.slug,required this.part2topic,required this.nextTopic,required this.nextPage});

  @override
  State<Part2Screen> createState() => _Part2FlowState();
}

class _Part2FlowState extends State<Part2Screen> {
  final PageController _controller=PageController(
      viewportFraction: 1.0
  );
  QuizResult result=QuizResult.empty();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
  void goToQuiz(){
    _controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
  }
  void goToResult(QuizResult quizResult)async{
    setState(() {
      result=quizResult;
    });
    _controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
  }
  @override
  Widget build(BuildContext context) {


    return PageView.builder(
        controller: _controller,
        itemCount: 3,

        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context,index){
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
                nextPage: widget.nextPage,
              );

            default:
              return Stack(
                children: [
                  BgGradient(),
                  Center(child: CircularProgressIndicator())
                ],
              );
          }
        }
    );

  }
}
