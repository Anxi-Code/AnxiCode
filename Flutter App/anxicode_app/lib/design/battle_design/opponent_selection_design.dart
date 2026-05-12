import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      onTap: () => setState(() => selectedIndex = index),
      child: Container(
        height: 90,
        decoration: BoxDecoration(
          gradient:RadialGradient(
            radius: 4,
            colors: [
              Colors.cyanAccent.withValues(alpha: 0.2),
              Colors.white.withValues(alpha: 0.1),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.cyanAccent : Colors.transparent,
            width: 2,
          ),

          boxShadow: [
            BoxShadow(
                color: isSelected
                    ? Colors.cyanAccent.withOpacity(0.2)
                    : Colors.black.withOpacity(0.0),
                blurRadius: isSelected ? 20:0,
                spreadRadius: isSelected ? 5:0
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: isSelected ? Colors.cyanAccent:Colors.white),
            const SizedBox(height: 10),
            Text(text, style:GoogleFonts.orbitron(color: isSelected ? Colors.cyanAccent:Colors.white,fontWeight: FontWeight.bold)),
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
          const SizedBox(width: 10),
          Expanded(child: buildBox(1, Icons.person, "Friend")),
        ],
      ),
    );
  }
}