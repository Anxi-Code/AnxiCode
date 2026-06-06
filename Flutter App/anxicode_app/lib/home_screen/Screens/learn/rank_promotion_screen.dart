import 'package:anxicode_app/design/bg_gradient/bg_gradient.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RankPromotionScreen extends StatefulWidget {
  final String nextRankName;

  const RankPromotionScreen({super.key, required this.nextRankName});

  @override
  State<RankPromotionScreen> createState() => _RankPromotionScreenState();
}

class _RankPromotionScreenState extends State<RankPromotionScreen> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String displayName = widget.nextRankName == "MAX" ? "LEGENDARY MASTER" : widget.nextRankName.toUpperCase();
    final String badgePath = widget.nextRankName == "MAX"
        ? "assets/ranks/legendary1.png" // Fallback max badge
        : "assets/ranks/${widget.nextRankName.toLowerCase()}1.png";

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          const BgGradient(),
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "RANK PROMOTION!",
                      style: GoogleFonts.orbitron(
                        color: Colors.amberAccent,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0,
                      ),
                    ),
                    const SizedBox(height: 40),

                    TweenAnimationBuilder(
                      tween: Tween<double>(begin: 0.0, end: 1.0),
                      duration: const Duration(milliseconds: 1200),
                      curve: Curves.elasticOut,
                      builder: (context, value, child) {
                        return Transform.scale(
                          scale: value,
                          child: child,
                        );
                      },
                      child: AnimatedBuilder(
                        animation: _pulseAnimation,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: _pulseAnimation.value,
                            child: Container(
                              height: 180,
                              width: 180,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.cyanAccent.withValues(alpha: 0.4),
                                    blurRadius: 40,
                                    spreadRadius: 10,
                                  ),
                                ],
                              ),
                              child: Image.asset(badgePath, fit: BoxFit.contain),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 50),

                    Text(
                      "YOU ARE NOW A",
                      style: GoogleFonts.orbitron(
                        color: Colors.white70,
                        fontSize: 14,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      displayName,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.orbitron(
                        color: Colors.cyanAccent,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0,
                      ),
                    ),

                    const SizedBox(height: 20),
                    Text(
                      "New arenas, harder challenges, and greater glory await.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey.shade400, fontSize: 15, height: 1.5),
                    ),

                    const SizedBox(height: 60),

                    SizedBox(
                      height: 56,
                      width: double.infinity,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(colors: [Color(0xFF00C9A7), Color(0xFF007CF0)]),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(color: const Color(0xFF00C9A7).withValues(alpha: 0.4), blurRadius: 12, offset: const Offset(0, 4)),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).popUntil((route) => route.isFirst);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          ),
                          child: Text(
                            "CONTINUE JOURNEY",
                            style: GoogleFonts.orbitron(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16, letterSpacing: 1.2),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}