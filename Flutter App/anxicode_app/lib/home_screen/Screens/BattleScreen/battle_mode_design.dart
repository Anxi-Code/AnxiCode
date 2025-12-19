import 'package:anxicode_app/Designs/glassmorphism.dart';
import 'package:flutter/material.dart';


class BattleModeDesign extends StatefulWidget {
  const BattleModeDesign({super.key});

  @override
  State<BattleModeDesign> createState() => _BattleModeDesignState();
}

class _BattleModeDesignState extends State<BattleModeDesign> {
  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Padding(
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
              child: Glassmorphism(
                blur: 3,
                opacity:0.2,
                borderRadius: BorderRadius.circular(18),
                borderColor:
                selectedIndex == 0 ? Colors.blue : Colors.white,
                child: SizedBox(
                  width: 130,
                  height: 115,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.emoji_events,size: 60,color: Colors.yellow,),
                      SizedBox(height: 10),
                      Text(
                        "Ranked",
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
              child: Glassmorphism(
                blur: 3,
                opacity:0.2,
                borderRadius: BorderRadius.circular(18),
                borderColor:
                selectedIndex == 1 ? Colors.blue : Colors.white,
                child: SizedBox(
                  width: 130,
                  height: 115,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.sports_esports,size: 60,color: Colors.blue,),
                      SizedBox(height: 10),
                      Text(
                        "Unranked",
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
          ),
          ]
      ),
    );
  }
}
