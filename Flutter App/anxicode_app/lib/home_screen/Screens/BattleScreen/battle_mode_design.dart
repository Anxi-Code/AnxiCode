import 'package:flutter/material.dart';

class BattleModeDesign extends StatefulWidget {
  const BattleModeDesign({super.key});

  @override
  State<BattleModeDesign> createState() => _BattleModeDesignState();
}

class _BattleModeDesignState extends State<BattleModeDesign> {
  int selectedIndex = -1;

  Widget buildBox({required int index, required IconData icon, required String text}) {
    bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        height: 90,
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.grey[850],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.yellow : Colors.white24,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30, color: Colors.white),
            SizedBox(height: 10),
            Text(
              text,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Expanded(child: buildBox(index: 0, icon: Icons.emoji_events, text: "Ranked")),
          SizedBox(width: 10),
          Expanded(child: buildBox(index: 1, icon: Icons.sports_esports, text: "Unranked")),
        ],
      ),
    );
  }
}