import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';

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
                child: GlassContainer(
                  height: 90,
                  width: double.infinity,
                  gradient: LinearGradient(
                    colors: [Colors.white.withValues(alpha:0.50), Colors.white.withValues(alpha:0.10)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),

                  blur: 15.0,
                  borderWidth: 1.5,
                  elevation: 4.0,
                  borderRadius: BorderRadius.circular(25),
                  shadowColor: Colors.black.withValues(alpha: 0.2),
                  alignment: Alignment.center,
                  frostedOpacity: 0.35,
                  margin: EdgeInsets.all(8.0),
                  padding: EdgeInsets.all(8.0),
                  borderGradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: selectedIndex == 0
                          ? [
                        Colors.blue.withValues(alpha: 1.0),
                        Colors.yellow.withValues(alpha: 1.0),
                      ]
                          : [
                        Colors.white.withValues(alpha: 0.35),
                        Colors.white.withValues(alpha: 0.25),
                      ],
                      stops: [0.0,0.8]
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.people,size: 30,color: Colors.white,),
                      SizedBox(height: 10),
                      Text(
                        "Random",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: selectedIndex==0 ? Colors.white:Colors.white70,
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
                child: GlassContainer(
                  height: 90,
                  width: double.infinity,
                  gradient: LinearGradient(
                    colors: [Colors.white.withValues(alpha:0.50), Colors.white.withValues(alpha:0.10)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),

                  blur: 8.0,
                  borderWidth: 1.5,
                  elevation: 4.0,
                  borderRadius: BorderRadius.circular(25),
                  shadowColor: Colors.black.withValues(alpha: 0.2),
                  alignment: Alignment.center,
                  frostedOpacity: 0.35,
                  margin: EdgeInsets.all(8.0),
                  padding: EdgeInsets.all(8.0),
                  borderGradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: selectedIndex == 1
                          ? [
                        Colors.blue.withValues(alpha: 1.0),
                        Colors.yellow.withValues(alpha: 1.0),
                      ]
                          : [
                        Colors.white.withValues(alpha: 0.35),
                        Colors.white.withValues(alpha: 0.25),
                      ],
                      stops: [0.0,0.8]
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.person,size: 30,color: Colors.white,),
                      SizedBox(height: 10),
                      Text(
                        "Friend",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: selectedIndex==1 ? Colors.white:Colors.white70,
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
