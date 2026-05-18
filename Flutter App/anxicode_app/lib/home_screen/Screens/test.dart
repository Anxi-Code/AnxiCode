import 'package:anxicode_app/design/Explaination/exp.dart';
import 'package:anxicode_app/design/Quiz/mcqs_design.dart';
import 'package:flutter/material.dart';
class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(onPressed: (){
          Navigator.push(context,MaterialPageRoute(builder: (context)=>Mcqs()));
        }
            , child: Text("Mcqs")),
        ElevatedButton(onPressed: (){
          Navigator.push(context,MaterialPageRoute(builder: (context)=>Topic()));
        }
            , child: Text("Topic"))
      ],
    );
  }
}
