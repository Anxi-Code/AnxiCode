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
      onTap: () => setState(() => selectedIndex = index),
      child: Container(
        height: 90,
        decoration: BoxDecoration(
          gradient: isSelected
              ? const LinearGradient(
            colors: [Color(0xFF00C9A7), Color(0xFF007CF0)],
          )
              : const LinearGradient(
            colors: [Color(0xFF1B1B3A), Color(0xFF2D2D5A)],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.amber : Colors.white24,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? Colors.cyanAccent.withOpacity(0.3)
                  : Colors.black.withOpacity(0.2),
              blurRadius: 12,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(height: 10),
            Text(text, style: const TextStyle(color: Colors.white)),
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