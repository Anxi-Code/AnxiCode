import 'package:anxicode_app/Learning/mod/part1.dart';
import 'package:anxicode_app/home_screen/Screens/learn/part1_screen.dart';
import 'package:flutter/material.dart';
class Part1Flow extends StatefulWidget {
  final List<Part1Topic> part1topics;
  final String slug;
  const Part1Flow({super.key, required this.slug,required this.part1topics});

  @override
  State<Part1Flow> createState() => _Part1FlowState();
}

class _Part1FlowState extends State<Part1Flow> {
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
        itemCount: widget.part1topics.length,
        physics: const NeverScrollableScrollPhysics(),

        itemBuilder: (context,index){
          return Part1Screen(slug: widget.slug, part1topic: widget.part1topics[index],nextTopic: widget.part1topics[index+1].topicName,nextPage: nextPage,);

        });
  }
}
