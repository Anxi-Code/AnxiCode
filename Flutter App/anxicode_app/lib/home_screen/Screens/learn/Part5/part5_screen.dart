import 'package:anxicode_app/Learning/mod/files_part.dart';
import 'package:anxicode_app/Learning/mod/part1.dart';
import 'package:anxicode_app/Learning/mod/part2.dart';
import 'package:anxicode_app/Learning/mod/quiz_result.dart';
import 'package:anxicode_app/design/Quiz/mcqs_design.dart';
import 'package:anxicode_app/design/Quiz/topic_screen.dart';
import 'package:anxicode_app/design/bg_gradient/bg_gradient.dart';
import 'package:anxicode_app/home_screen/Screens/learn/result_screen.dart';
import 'package:flutter/material.dart';
class Part5Screen extends StatefulWidget {
  final FilePart part5;
  final String slug;
  final String nextTopic;
  final VoidCallback nextPage;


  const Part5Screen({super.key,required this.part5,required this.slug,required this.nextTopic,required this.nextPage});

  @override
  State<Part5Screen> createState() => _Part5FlowState();
}

class _Part5FlowState extends State<Part5Screen> {
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
        itemCount: 2,

        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context,index){
          switch (index) {

            case 0:
              return Mcqs(
                goToResult: goToResult,
                slug: widget.slug,
                path: widget.part5.filePath,
                nextTopic: widget.nextTopic,
              );

            case 1:
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
