import 'package:flutter/material.dart';
import 'package:anxicode_app/design/bg_gradient/bg_gradient.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

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
              "About Us",
              style: GoogleFonts.orbitron(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Center(
                  child: Icon(
                    Icons.code,
                    size: 80,
                    color: Colors.cyanAccent,
                  ),
                ),

                const SizedBox(height: 20),

                Center(
                  child: Text(
                    "AnxiCode",
                    style: GoogleFonts.orbitron(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                Center(
                  child: Text(
                    "AI-Powered Coding Confidence Platform",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.orbitron(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ),

                const SizedBox(height: 35),

                Text(
                  "About AnxiCode",
                  style: GoogleFonts.orbitron(
                    color: Colors.cyanAccent,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 15),

                Text(
                  "AnxiCode is an AI-powered adaptive coding learning platform designed to reduce programming anxiety and build confidence gradually. The platform combines gamified learning, coding battles, adaptive AI retry systems, and progress tracking to create a supportive environment for learners.",
                  style: GoogleFonts.orbitron(
                    color: Colors.white70,
                    fontSize: 13,
                    height: 1.8,
                  ),
                ),

                const SizedBox(height: 30),

                Text(
                  "Key Features",
                  style: GoogleFonts.orbitron(
                    color: Colors.cyanAccent,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 15),

                buildFeatureTile(
                  Icons.psychology_alt_outlined,
                  "AI Adaptive Learning",
                ),

                buildFeatureTile(
                  Icons.emoji_events_outlined,
                  "Gamified Coding Battles",
                ),

                buildFeatureTile(
                  Icons.analytics_outlined,
                  "Confidence & Anxiety Tracking",
                ),

                buildFeatureTile(
                  Icons.refresh_outlined,
                  "Smart Retry System",
                ),

                buildFeatureTile(
                  Icons.code_outlined,
                  "Multi-Language Learning",
                ),

                const SizedBox(height: 30),

                Text(
                  "Mission",
                  style: GoogleFonts.orbitron(
                    color: Colors.cyanAccent,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 15),

                Text(
                  "Our mission is to help learners overcome coding fear, improve confidence, and make programming more accessible, engaging, and stress-free.",
                  style: GoogleFonts.orbitron(
                    color: Colors.white70,
                    fontSize: 13,
                    height: 1.8,
                  ),
                ),

                const SizedBox(height: 40),

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

  Widget buildFeatureTile(IconData icon, String title) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.cyanAccent,
      ),

      title: Text(
        title,
        style: GoogleFonts.orbitron(
          color: Colors.white,
          fontSize: 13,
        ),
      ),
    );
  }
}