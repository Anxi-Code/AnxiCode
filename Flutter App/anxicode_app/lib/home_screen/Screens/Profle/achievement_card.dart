import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'achievement_model.dart';

class AchievementCard extends StatelessWidget {
  final AchievementModel achievement;

  const AchievementCard({
    super.key,
    required this.achievement,
  });

  @override
  Widget build(BuildContext context) {

    final isUnlocked = achievement.unlocked;

    return Container(
      padding: const EdgeInsets.all(12),

      decoration: BoxDecoration(
        color: isUnlocked
            ? Colors.blueAccent.withOpacity(0.15)
            : Colors.white.withOpacity(0.05),

        borderRadius: BorderRadius.circular(20),

        border: Border.all(
          color: isUnlocked
              ? Colors.cyanAccent
              : Colors.grey,
        ),
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Icon(
            isUnlocked
                ? Icons.emoji_events
                : Icons.lock,
            size: 40,
            color: isUnlocked
                ? Colors.amber
                : Colors.grey,
          ),

          const SizedBox(height: 10),

          Text(
            achievement.title,
            textAlign: TextAlign.center,

            style: GoogleFonts.orbitron(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            achievement.description,
            textAlign: TextAlign.center,

            maxLines: 2,
            overflow: TextOverflow.ellipsis,

            style: const TextStyle(
              color: Colors.white70,
              fontSize: 10,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            "+${achievement.points} XP",

            style: const TextStyle(
              color: Colors.amber,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}