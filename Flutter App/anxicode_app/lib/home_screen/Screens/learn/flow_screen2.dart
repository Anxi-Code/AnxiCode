import 'package:anxicode_app/Learning/mod/part1.dart';
import 'package:anxicode_app/Learning/mod/part2.dart';
import 'package:anxicode_app/home_screen/Screens/learn/part1_screen.dart';
import 'package:anxicode_app/home_screen/Screens/learn/part2_screen.dart';
import 'package:flutter/material.dart';
class Part2Flow extends StatefulWidget {
  final List<Part2Topic> part2topics;
  final String slug;
  const Part2Flow({super.key, required this.slug,required this.part2topics});

  @override
  State<Part2Flow> createState() => _Part2FlowState();
}

class _Part2FlowState extends State<Part2Flow> {
  PageController _controller=PageController();

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
  void nextPage(){
    _controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
  }
  @override
  Widget build(BuildContext context) {

    return PageView.builder(
        controller: _controller,
        itemCount: widget.part2topics.length,
        physics: const NeverScrollableScrollPhysics(),

        itemBuilder: (context,index){
          return Part2Screen(slug: widget.slug, part2topic: widget.part2topics[index],nextTopic: widget.part2topics[index+1].topicName,nextPage: nextPage,);

        });
  }
}
