
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
class OpponentSelectionDesign extends StatefulWidget {
  const OpponentSelectionDesign({super.key});

  @override
  State<OpponentSelectionDesign> createState() => _OpponentSelectionDesignState();
}

class _OpponentSelectionDesignState extends State<OpponentSelectionDesign> {
  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: Row(

          children: [
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex=0;
                  });
                },
                child: GlassmorphicContainer(
                  width: double.infinity,
                  height: 90,
                  borderRadius: 20,
                  blur: 4,
                  alignment: Alignment.bottomCenter,
                  border: 1.5,
                  linearGradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withValues(alpha: 0.1),
                        Colors.white.withValues(alpha:0.05),
                      ],
                      stops: [
                        0.1,
                        1,
                      ]),
                  borderGradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: selectedIndex == 0
                          ? [
                        Colors.blue.withValues(alpha: 1.0),
                        Colors.red.withValues(alpha: 1.0),
                      ]
                          : [
                        Colors.white.withValues(alpha: 0.6),
                        Colors.white.withValues(alpha: 0.2),
                      ],
                      stops: [0.0,0.9]
                  ),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.people,size: 30,color: Colors.blue,),
                      SizedBox(height: 10),
                      Text(
                        "Random",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white.withValues(alpha: 0.8),
                        ),
                      )



                    ],
                  ),
                ),
              ),
            ),

            SizedBox(width: 10,),
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex=1;
                  });
                },
                child: GlassmorphicContainer(
                  width: double.infinity,
                  height: 90,
                  borderRadius: 20,
                  blur: 4,
                  alignment: Alignment.bottomCenter,
                  border: 1.5,
                  linearGradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withValues(alpha:0.1),
                        Colors.white.withValues(alpha:0.05),
                      ],
                      stops: [
                        0.1,
                        1,
                      ]),
                  borderGradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: selectedIndex == 1
                          ? [
                        Colors.blue.withValues(alpha: 1.0),
                        Colors.red.withValues(alpha: 1.0),
                      ]
                          : [
                        Colors.white.withValues(alpha: 0.6),
                        Colors.white.withValues(alpha: 0.2),
                      ],
                      stops: [0.0,0.9]
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.person,size: 30,color: Colors.red,),
                      SizedBox(height: 10),
                      Text(
                        "Friend",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white.withValues(alpha: 0.8),
                        ),
                      )



                    ],
                  ),
                ),
              ),
            ),

          ]
      ),
    );
  }
}
