import 'package:flutter/material.dart';
import 'package:anxicode_app/design/bg_gradient/bg_gradient.dart';
import 'package:google_fonts/google_fonts.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BgGradient(),

        Scaffold(
          backgroundColor: Colors.transparent,

          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,

            title: Text(
              "Help Center",
              style: GoogleFonts.orbitron(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // ================= FAQ =================

                Text(
                  "Frequently Asked Questions",
                  style: GoogleFonts.orbitron(
                    color: Colors.cyanAccent,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 15),

                buildHelpTile(
                  "How do coding battles work?",
                  "Coding battles allow users to compete with others by solving programming problems in real time.",
                ),

                buildHelpTile(
                  "How does XP system work?",
                  "You gain XP by completing lessons, battles, quizzes, and daily challenges.",
                ),

                buildHelpTile(
                  "How is anxiety score calculated?",
                  "The system tracks retries, confidence level, and coding behavior patterns.",
                ),

                buildHelpTile(
                  "How can I reset my password?",
                  "Go to Settings > Change Password to update your password securely.",
                ),

                const SizedBox(height: 25),

                // ================= SUPPORT =================

                Text(
                  "Support",
                  style: GoogleFonts.orbitron(
                    color: Colors.cyanAccent,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 15),

                ListTile(
                  leading: const Icon(
                    Icons.email_outlined,
                    color: Colors.white,
                  ),

                  title: Text(
                    "Email Support",
                    style: GoogleFonts.orbitron(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),

                  subtitle: const Text(
                    "support@anxicode.com",
                    style: TextStyle(color: Colors.white70),
                  ),
                ),

                ListTile(
                  leading: const Icon(
                    Icons.bug_report_outlined,
                    color: Colors.white,
                  ),

                  title: Text(
                    "Report a Bug",
                    style: GoogleFonts.orbitron(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),

                  subtitle: const Text(
                    "Tell us about issues in the app",
                    style: TextStyle(color: Colors.white70),
                  ),
                ),

                ListTile(
                  leading: const Icon(
                    Icons.feedback_outlined,
                    color: Colors.white,
                  ),

                  title: Text(
                    "Send Feedback",
                    style: GoogleFonts.orbitron(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),

                  subtitle: const Text(
                    "Help us improve AnxiCode",
                    style: TextStyle(color: Colors.white70),
                  ),
                ),

                const SizedBox(height: 25),

                // ================= WELLNESS =================

                Text(
                  "Coding Wellness Tips",
                  style: GoogleFonts.orbitron(
                    color: Colors.cyanAccent,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 15),

                buildTipTile(
                  "Take short breaks during coding sessions.",
                ),

                buildTipTile(
                  "Focus on learning, not perfection.",
                ),

                buildTipTile(
                  "Small progress every day matters.",
                ),

                buildTipTile(
                  "Retrying problems is part of learning.",
                ),

                const SizedBox(height: 30),

                Center(
                  child: Text(
                    "AnxiCode v1.0",
                    style: GoogleFonts.orbitron(
                      color: Colors.white54,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ================= FAQ TILE =================

  Widget buildHelpTile(String question, String answer) {
    return Card(
      color: Colors.white.withOpacity(0.08),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),

      child: ExpansionTile(
        iconColor: Colors.cyanAccent,
        collapsedIconColor: Colors.white,

        title: Text(
          question,
          style: GoogleFonts.orbitron(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),

        children: [
          Padding(
            padding: const EdgeInsets.all(15),

            child: Text(
              answer,
              style: const TextStyle(
                color: Colors.white70,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================= TIP TILE =================

  Widget buildTipTile(String text) {
    return ListTile(
      leading: const Icon(
        Icons.check_circle_outline,
        color: Colors.cyanAccent,
      ),

      title: Text(
        text,
        style: GoogleFonts.orbitron(
          color: Colors.white,
          fontSize: 13,
        ),
      ),
    );
  }
}