import 'package:flutter/material.dart';

class BattleModeDesign extends StatefulWidget {
  const BattleModeDesign({super.key});

  @override
  State<BattleModeDesign> createState() => _BattleModeDesignState();
}

class _BattleModeDesignState extends State<BattleModeDesign> {
  int selectedIndex = -1;

  Widget buildBox({
    required int index,
    required IconData icon,
    required String text,
  }) {
    bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () => setState(() => selectedIndex = index),
      child: Container(
        height: 90,
        decoration: BoxDecoration(
          gradient: isSelected
              ? const LinearGradient(colors: [Color(0xFF00C9A7), Color(0xFF007CF0)])
              : const LinearGradient(colors: [Color(0xFF1B1B3A), Color(0xFF2D2D5A)]),
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
          Expanded(child: buildBox(index: 0, icon: Icons.emoji_events, text: "Ranked")),
          const SizedBox(width: 10),
          Expanded(child: buildBox(index: 1, icon: Icons.sports_esports, text: "Unranked")),
        ],
      ),
    );
  }
}