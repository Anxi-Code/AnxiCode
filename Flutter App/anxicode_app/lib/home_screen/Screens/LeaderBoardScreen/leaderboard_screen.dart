import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Leaderboard extends StatefulWidget {
  const Leaderboard({super.key});

  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  final supabase = Supabase.instance.client;
  final PageController pageController = PageController();

  final List<Map<String, String>> languages = [
    {
      "name": "Java",
      "id": "450e3120-3ab5-4f78-820f-9b65f03ad45c",
    },
    {
      "name": "Python",
      "id": "b27dace4-b672-437b-bc07-d753c891b177",
    },
    {
      "name": "C++",
      "id": "e5c10fef-4d23-4eb7-b502-f961186b5c4e",
    },
    {
      "name": "JavaScript",
      "id": "841ad68d-6805-4a5f-9723-81ea27133275",
    },
  ];

  Future<List<Map<String, dynamic>>> fetchLeaderboard(String languageId) async {
    final progressData = await supabase
        .from('user_language_progress')
        .select()
        .eq('language_id', languageId)
        .order('total_points', ascending: false)
        .order('current_rank_order', ascending: false)
        .order('current_rank_part', ascending: false)
        .order('updated_at', ascending: true)
        .limit(50);

    final progressList = List<Map<String, dynamic>>.from(progressData);

    if (progressList.isEmpty) {
      return [];
    }

    final userIds = progressList.map((user) => user['user_id']).toList();

    final profileData = await supabase
        .from('profiles')
        .select('id, user_name')
        .inFilter('id', userIds);

    final profileList = List<Map<String, dynamic>>.from(profileData);

    final profileMap = {
      for (final profile in profileList) profile['id']: profile,
    };

    return progressList.asMap().entries.map((entry) {
      final index = entry.key;
      final progress = entry.value;
      final profile = profileMap[progress['user_id']];

      return {
        "rank": index + 1,
        "name": profile?['user_name'] ?? "Unknown User",
        "xp": progress["total_points"] ?? 0,
        "level": progress["current_rank_name"] ?? "Rookie",
      };
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: pageController,
      itemCount: languages.length,
      itemBuilder: (context, index) {
        final language = languages[index];

        return FutureBuilder<List<Map<String, dynamic>>>(
          future: fetchLeaderboard(language["id"]!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.cyanAccent),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Text(
                  "Error: ${snapshot.error}",
                  style: const TextStyle(color: Colors.redAccent),
                  textAlign: TextAlign.center,
                ),
              );
            }

            final users = snapshot.data ?? [];

            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Column(
                children: [
                  const SizedBox(height: 25),

                  Text(
                    "${language["name"]} Leaderboard",
                    style: GoogleFonts.orbitron(
                      color: Colors.cyanAccent,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: _topPlayer(
                          user: users.length > 1 ? users[1] : null,
                          color: Colors.blueAccent,
                          height: 165,
                        ),
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child: _topPlayer(
                          user: users.isNotEmpty ? users[0] : null,
                          color: Colors.amberAccent,
                          height: 205,
                          crown: true,
                        ),
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child: _topPlayer(
                          user: users.length > 2 ? users[2] : null,
                          color: Colors.purpleAccent,
                          height: 165,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),

                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.07),
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(
                          color: Colors.cyanAccent.withValues(alpha: 0.5),
                        ),
                      ),
                      child: users.length <= 3
                          ? const Center(
                        child: Text(
                          "Only top 3 users found",
                          style: TextStyle(color: Colors.white70),
                        ),
                      )
                          : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: users.length - 3,
                        itemBuilder: (context, index) {
                          return _leaderboardCard(
                            user: users[index + 3],
                          );
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _topPlayer({
    required Map<String, dynamic>? user,
    required Color color,
    required double height,
    bool crown = false,
  }) {
    return Container(
      height: height,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(
          color: color.withValues(alpha: 0.8),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.35),
            blurRadius: 18,
            spreadRadius: 1,
          ),
        ],
      ),
      child: user == null
          ? const Center(
        child: Text(
          "Empty",
          style: TextStyle(color: Colors.white70),
        ),
      )
          : Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (crown)
            const Icon(
              Icons.emoji_events,
              color: Colors.amberAccent,
              size: 28,
            ),

          CircleAvatar(
            radius: crown ? 38 : 30,
            backgroundColor: color,
            child: CircleAvatar(
              radius: crown ? 34 : 27,
              backgroundImage:
              const AssetImage("assets/images/user3.png"),
            ),
          ),

          const SizedBox(height: 10),

          Text(
            "#${user["rank"]}",
            style: GoogleFonts.orbitron(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),

          Text(
            user["name"],
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.orbitron(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            "${user["xp"]} XP",
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _leaderboardCard({
    required Map<String, dynamic> user,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.cyanAccent.withValues(alpha: 0.25),
        ),
      ),
      child: Row(
        children: [
          Container(
            height: 38,
            width: 38,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.cyanAccent.withValues(alpha: 0.15),
              border: Border.all(color: Colors.cyanAccent),
            ),
            child: Text(
              "${user["rank"]}",
              style: GoogleFonts.orbitron(
                color: Colors.cyanAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(width: 12),

          const CircleAvatar(
            radius: 24,
            backgroundImage: AssetImage("assets/images/user3.png"),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user["name"],
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.orbitron(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  "${user["level"]}  •  ${user["xp"]} XP",
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),

                const SizedBox(height: 7),

                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: const LinearProgressIndicator(
                    value: 0.75,
                    minHeight: 5,
                    backgroundColor: Colors.white12,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.cyanAccent,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}