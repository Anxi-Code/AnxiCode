import 'package:anxicode_app/design/bg_gradient/bg_gradient.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'achievement_data.dart';
import 'achievement_controller.dart';

class Achievements extends StatefulWidget {
  const Achievements({super.key});

  @override
  State<Achievements> createState() => _AchievementsState();
}

class _AchievementsState extends State<Achievements> {
  void unlockAchievement(String id) {
    setState(() {
      AchievementController.unlockAchievement(id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final totalPoints = AchievementController.getTotalPoints();

    return Stack(
      children: [
        const BgGradient(),

        Scaffold(
          backgroundColor: Colors.transparent,

          appBar: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            elevation: 0,

            title: Text(
              "Achievements",
              style: GoogleFonts.orbitron(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),

          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),

              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(30),

                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(20),
                    ),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),

                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.purple,
                              ),

                              child: const Icon(
                                Icons.emoji_events,
                                color: Colors.amber,
                              ),
                            ),

                            const SizedBox(width: 15),

                            Text(
                              "Meesum Afzaal",
                              style: GoogleFonts.orbitron(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,

                          children: [
                            Text(
                              totalPoints.toString(),
                              style: GoogleFonts.orbitron(
                                color: Colors.white,
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(width: 10),

                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),

                              child: Text(
                                "points",
                                style: GoogleFonts.orbitron(
                                  color: Colors.white70,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  Container(
                    padding: const EdgeInsets.all(20),

                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(35),
                    ),

                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),

                      itemCount: achievementsData.length,

                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 25,

                        childAspectRatio:
                        MediaQuery.of(context).orientation ==
                            Orientation.portrait
                            ? 0.90
                            : 1.9,
                      ),

                      itemBuilder: (context, index) {
                        final achievement = achievementsData[index];

                        return AchievementItem(
                          color: achievement.color,
                          title: achievement.title,
                          points: achievement.points,
                          icon: achievement.icon,
                          unlocked: achievement.unlocked,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class AchievementItem extends StatelessWidget {
  final Color color;
  final String title;
  final String points;
  final IconData icon;
  final bool unlocked;

  const AchievementItem({
    super.key,
    required this.color,
    required this.title,
    required this.points,
    required this.icon,
    required this.unlocked,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: unlocked ? 1 : 0.35,

      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(14),

            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: unlocked ? color : Colors.grey.shade700,

              boxShadow: [
                BoxShadow(
                  color: unlocked
                      ? color.withOpacity(0.7)
                      : Colors.black26,
                  blurRadius: 18,
                  spreadRadius: 1,
                ),
              ],
            ),

            child: Icon(
              unlocked ? icon : Icons.lock,
              color: Colors.white,
              size: 36,
            ),
          ),

          const SizedBox(height: 15),

          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.orbitron(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            unlocked ? points : "Locked",
            style: GoogleFonts.orbitron(
              color: unlocked ? Colors.amber : Colors.white54,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}