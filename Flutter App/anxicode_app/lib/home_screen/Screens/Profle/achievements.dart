import 'package:anxicode_app/design/bg_gradient/bg_gradient.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Achievements extends StatefulWidget {
  const Achievements({super.key});

  @override
  State<Achievements> createState() => _AchievementsState();
}

class _AchievementsState extends State<Achievements> {

  final List<Map<String, dynamic>> achievements = [

    {
      "title": "First Quiz",
      "points": "+50",
      "icon": Icons.quiz,
      "color": Colors.orange,
      "unlocked": true,
    },

    {
      "title": "Quiz Streak",
      "points": "+100",
      "icon": Icons.local_fire_department,
      "color": Colors.red,
      "unlocked": false,
    },

    {
      "title": "Battle Winner",
      "points": "+150",
      "icon": Icons.sports_esports,
      "color": Colors.purple,
      "unlocked": false,
    },

    {
      "title": "Debug Master",
      "points": "+200",
      "icon": Icons.bug_report,
      "color": Colors.green,
      "unlocked": false,
    },

    {
      "title": "Problem Solver",
      "points": "+300",
      "icon": Icons.psychology,
      "color": Colors.blue,
      "unlocked": false,
    },

    {
      "title": "Code Warrior",
      "points": "+400",
      "icon": Icons.code,
      "color": Colors.cyan,
      "unlocked": false,
    },

    {
      "title": "No Hint Hero",
      "points": "+250",
      "icon": Icons.visibility_off,
      "color": Colors.teal,
      "unlocked": false,
    },

    {
      "title": "Fast Thinker",
      "points": "+350",
      "icon": Icons.flash_on,
      "color": Colors.yellow,
      "unlocked": false,
    },

    {
      "title": "Shadow Coder",
      "points": "+500",
      "icon": Icons.nightlight_round,
      "color": Colors.indigo,
      "unlocked": false,
    },

    {
      "title": "Apex Coder",
      "points": "+700",
      "icon": Icons.workspace_premium,
      "color": Colors.deepOrange,
      "unlocked": false,
    },

    {
      "title": "Battle Beast",
      "points": "+900",
      "icon": Icons.shield,
      "color": Colors.deepPurple,
      "unlocked": false,
    },

    {
      "title": "Legendary",
      "points": "+1500",
      "icon": Icons.emoji_events,
      "color": Colors.amber,
      "unlocked": false,
    },

    {
      "title": "Quiz Master",
      "points": "+450",
      "icon": Icons.menu_book,
      "color": Colors.lightBlue,
      "unlocked": false,
    },

    {
      "title": "Bug Hunter",
      "points": "+500",
      "icon": Icons.search,
      "color": Colors.lime,
      "unlocked": false,
    },

    {
      "title": "Night Coder",
      "points": "+600",
      "icon": Icons.dark_mode,
      "color": Colors.blueGrey,
      "unlocked": false,
    },

    {
      "title": "Logic King",
      "points": "+800",
      "icon": Icons.memory,
      "color": Colors.pink,
      "unlocked": false,
    },

    {
      "title": "Rank Climber",
      "points": "+550",
      "icon": Icons.trending_up,
      "color": Colors.greenAccent,
      "unlocked": false,
    },

    {
      "title": "Brain Storm",
      "points": "+650",
      "icon": Icons.psychology_alt,
      "color": Colors.deepPurpleAccent,
      "unlocked": false,
    },

    {
      "title": "Fearless",
      "points": "+750",
      "icon": Icons.bolt,
      "color": Colors.orangeAccent,
      "unlocked": false,
    },

    {
      "title": "Combo Streak",
      "points": "+1000",
      "icon": Icons.whatshot,
      "color": Colors.redAccent,
      "unlocked": false,
    },

    {
      "title": "Code Genius",
      "points": "+1200",
      "icon": Icons.auto_awesome,
      "color": Colors.purpleAccent,
      "unlocked": false,
    },

    {
      "title": "Battle King",
      "points": "+1300",
      "icon": Icons.gavel,
      "color": Colors.brown,
      "unlocked": false,
    },

    {
      "title": "Champion",
      "points": "+1400",
      "icon": Icons.military_tech,
      "color": Colors.amberAccent,
      "unlocked": false,
    },

    {
      "title": "Unstoppable",
      "points": "+1600",
      "icon": Icons.rocket_launch,
      "color": Colors.lightGreen,
      "unlocked": false,
    },

    {
      "title": "Ultimate Hero",
      "points": "+2000",
      "icon": Icons.star,
      "color": Colors.yellowAccent,
      "unlocked": false,
    },
  ];

  void unlockAchievement(String title) {

    final index =
    achievements.indexWhere((item) => item["title"] == title);

    if (index != -1) {

      setState(() {
        achievements[index]["unlocked"] = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [

        BgGradient(),

        Scaffold(
          backgroundColor: Colors.transparent,

          appBar: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,

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
                      color: Colors.white.withValues(alpha: 0.08),
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
                              "300",

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
                      color: Colors.white.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(35),
                    ),

                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),

                      itemCount: achievements.length,

                      gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(

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

                        final achievement = achievements[index];

                        return AchievementItem(
                          color: achievement["color"],
                          title: achievement["title"],
                          points: achievement["points"],
                          icon: achievement["icon"],
                          unlocked: achievement["unlocked"],
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
              color: unlocked
                  ? color
                  : Colors.grey.shade700,

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
              color: unlocked
                  ? Colors.amber
                  : Colors.white54,

              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}