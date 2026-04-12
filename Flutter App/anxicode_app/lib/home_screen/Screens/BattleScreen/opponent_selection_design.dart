import 'package:flutter/material.dart';

class OpponentSelectionDesign extends StatefulWidget {
  const OpponentSelectionDesign({super.key});

  @override
  State<OpponentSelectionDesign> createState() => _OpponentSelectionDesignState();
}

class _OpponentSelectionDesignState extends State<OpponentSelectionDesign> {
  int selectedIndex = -1;

  Widget buildBox(int index, IconData icon, String text) {
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
            Icon(icon, color: Colors.white),
            SizedBox(height: 10),
            Text(text, style: TextStyle(color: Colors.white)),
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
          Expanded(child: buildBox(0, Icons.people, "Random")),
          SizedBox(width: 10),
          Expanded(child: buildBox(1, Icons.person, "Friend")),
        ],
      ),
    );
  }
}