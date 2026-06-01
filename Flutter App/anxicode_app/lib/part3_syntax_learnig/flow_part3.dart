import 'package:anxicode_app/Learning/pro/learning_provider.dart';
import 'package:anxicode_app/design/bg_gradient/bg_gradient.dart';
import 'package:anxicode_app/part3_syntax_learnig/part3.dart';
import 'package:anxicode_app/part3_syntax_learnig/part3_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
class Part3Flow extends ConsumerStatefulWidget {
  final String path;
  final String slug;
  const Part3Flow({super.key, required this.path, required this.slug});

  @override
  ConsumerState<Part3Flow> createState() => _Part3FlowState();
}

class _Part3FlowState extends ConsumerState<Part3Flow> {
  List<SyntaxChallenge>? challenges;
  bool loading=true;
  PageController _controller=PageController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadSyntaxChallenges();
  }
  void loadSyntaxChallenges()async{
    final learningService=ref.read(learningServiceProvider);
    final _challenges=await learningService.getSyntax(widget.slug, widget.path);
    setState(() {
      challenges=_challenges;
      loading=false;
    });

  }
  void onNext(){
    _controller.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeIn);

  }
  @override
  Widget build(BuildContext context) {
    return loading ? Stack(
      children: [
        BgGradient(),
        Center(
          child: CircularProgressIndicator(color: Colors.cyanAccent,),
        )

      ],
    ): PageView.builder(
      controller: _controller,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: challenges!.length,
        itemBuilder: (context, index) {
          return SyntaxForge(challenge: challenges![index], onNext: onNext,);
        }
    );
  }
}
