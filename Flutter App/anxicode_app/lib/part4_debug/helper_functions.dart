import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

BoxDecoration glassCard() => BoxDecoration(
  borderRadius: BorderRadius.circular(15),
  gradient: RadialGradient(
    radius: 4,
    colors: [
      Colors.cyanAccent.withValues(alpha: 0.10),
      Colors.white.withValues(alpha: 0.15),
    ],
  ),
  border: Border.all(color: Colors.cyanAccent.withValues(alpha: 0.15)),
);

Container headerCard() {
  return Container(
    padding: EdgeInsets.all(10),
    decoration: glassCard(),
    child: Row(
      children: [
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.cyanAccent.withValues(alpha: 0.4),
                blurRadius: 15,
              ),
            ],
          ),
          child: const Icon(
            Icons.bug_report_rounded,
            color: Colors.cyanAccent,
            size: 30,
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "DEBUG CHALLENGE",
                style: GoogleFonts.orbitron(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "Shadow Rank",
                style: GoogleFonts.orbitron(
                  color: Colors.grey.shade400,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
