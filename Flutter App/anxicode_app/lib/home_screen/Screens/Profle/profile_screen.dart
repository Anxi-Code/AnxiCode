import 'package:anxicode_app/Learning/pro/learning_provider.dart';
import 'package:anxicode_app/Rank_System/user_language_progress.dart';
import 'package:anxicode_app/home_screen/Screens/Profle/achievements.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Profile extends ConsumerStatefulWidget {
  const Profile({super.key});

  @override
  ConsumerState<Profile> createState() => _ProfileState();
}

class _ProfileState extends ConsumerState<Profile> {
  final PageController _pageController = PageController(viewportFraction: 0.9);
  final String testUserId = 'bfed85ee-6caf-421a-8727-b39508313610';

  List<IconData> badges = [
    Icons.military_tech,
    Icons.whatshot,
    Icons.code,
    Icons.psychology,
    Icons.workspace_premium,
    Icons.emoji_events,
    Icons.flash_on,
    Icons.auto_awesome,
    Icons.shield,
    Icons.bolt,
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final languagesAsync = ref.watch(languagesProvider);
    final supabase = Supabase.instance.client;

    return languagesAsync.when(
      data: (languagesList) {
        // Stream for Progress
        return StreamBuilder<List<Map<String, dynamic>>>(
          stream: supabase
              .from('user_language_progress')
              .stream(primaryKey: ['id'])
              .eq('user_id', testUserId),
          builder: (context, progressSnapshot) {
            // Stream for Profile Data
            return StreamBuilder<List<Map<String, dynamic>>>(
              stream: supabase
                  .from('profiles')
                  .stream(primaryKey: ['id'])
                  .eq('id', testUserId),
              builder: (context, profileSnapshot) {
                if ((progressSnapshot.connectionState ==
                            ConnectionState.waiting &&
                        !progressSnapshot.hasData) ||
                    (profileSnapshot.connectionState ==
                            ConnectionState.waiting &&
                        !profileSnapshot.hasData)) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.cyanAccent),
                  );
                }

                final userData =
                    (profileSnapshot.data?.isNotEmpty ?? false)
                        ? profileSnapshot.data!.first
                        : {'name': 'User', 'user_name': 'user'};
                final progressList =
                    (progressSnapshot.data ?? [])
                        .map((e) => UserLanguageProgress.fromJson(e))
                        .toList();

                int totalXp = 0;
                int totalPartsCleared = 0;
                int totalRanksCompleted = 0;
                int maxPossibleParts = progressList.length * 30;

                for (var p in progressList) {
                  totalXp += p.totalPoints;
                  totalRanksCompleted += p.ranksCompleted;
                  int clearedInCurrentRank =
                      p.currentRankPart > 0 ? (p.currentRankPart - 1) : 0;
                  totalPartsCleared +=
                      (p.ranksCompleted * 5) + clearedInCurrentRank;
                }

                double progressFraction =
                    maxPossibleParts > 0
                        ? (totalPartsCleared / maxPossibleParts).clamp(0.0, 1.0)
                        : 0.0;
                int progressPercentage = (progressFraction * 100).toInt();

                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 120,
                        width: 120,
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blueAccent.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                            ),
                          ],
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.cyanAccent,
                            width: 2.5,
                          ),
                        ),
                        child: const CircleAvatar(
                          backgroundImage: AssetImage(
                            'assets/images/user1.png',
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        userData['name'] ?? "User",
                        style: GoogleFonts.orbitron(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "@${userData['user_name'] ?? "user"}",
                        style: GoogleFonts.orbitron(
                          color: Colors.grey.shade400,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Stats, Language Ranks, and Achievements remain exactly as you had them:
                      Padding(
                        padding: const EdgeInsets.fromLTRB(14.0, 14.0, 14.0, 0),
                        child: SizedBox(
                          height: 230,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Container(
                                  height: double.infinity,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    gradient: RadialGradient(
                                      radius: 4,
                                      colors: [
                                        Colors.cyanAccent.withOpacity(0.1),
                                        Colors.white.withOpacity(0.2),
                                      ],
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                            height: 110,
                                            width: 110,
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.cyanAccent
                                                      .withOpacity(0.5),
                                                  spreadRadius: 3,
                                                  blurRadius: 20,
                                                ),
                                              ],
                                              border: Border.all(
                                                color: Colors.cyanAccent,
                                                width: 2,
                                              ),
                                            ),
                                            child: TweenAnimationBuilder<
                                              double
                                            >(
                                              tween: Tween<double>(
                                                begin: 0,
                                                end: progressFraction,
                                              ),
                                              duration: const Duration(
                                                seconds: 1,
                                              ),
                                              builder:
                                                  (
                                                    context,
                                                    value,
                                                    _,
                                                  ) => CircularProgressIndicator(
                                                    value: value,
                                                    valueColor:
                                                        const AlwaysStoppedAnimation(
                                                          Colors.cyanAccent,
                                                        ),
                                                    strokeWidth: 6,
                                                  ),
                                            ),
                                          ),
                                          TweenAnimationBuilder<int>(
                                            tween: IntTween(
                                              begin: 0,
                                              end: progressPercentage,
                                            ),
                                            duration: const Duration(
                                              seconds: 1,
                                            ),
                                            builder:
                                                (context, value, _) => Text(
                                                  "$value%",
                                                  style: GoogleFonts.orbitron(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 15),
                                      Text(
                                        "Total Progress",
                                        style: TextStyle(
                                          color: Colors.grey.shade400,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: double.infinity,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
                                          gradient: RadialGradient(
                                            radius: 4,
                                            colors: [
                                              Colors.cyanAccent.withOpacity(
                                                0.1,
                                              ),
                                              Colors.white.withOpacity(0.2),
                                            ],
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Total XP",
                                              style: TextStyle(
                                                color: Colors.grey.shade400,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            TweenAnimationBuilder<int>(
                                              tween: IntTween(
                                                begin: 0,
                                                end: totalXp,
                                              ),
                                              duration: const Duration(
                                                seconds: 1,
                                              ),
                                              builder:
                                                  (
                                                    context,
                                                    value,
                                                    child,
                                                  ) => Text(
                                                    "$value XP",
                                                    style: GoogleFonts.orbitron(
                                                      color:
                                                          Colors
                                                              .lightGreenAccent,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Expanded(
                                      child: Container(
                                        height: double.infinity,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
                                          gradient: RadialGradient(
                                            radius: 4,
                                            colors: [
                                              Colors.cyanAccent.withOpacity(
                                                0.1,
                                              ),
                                              Colors.white.withOpacity(0.2),
                                            ],
                                          ),
                                        ),
                                        child:
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Total Ranks Completed",
                                                  style: TextStyle(
                                                    color: Colors.grey.shade400,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                TweenAnimationBuilder<int>(
                                                  tween: IntTween(
                                                    begin: 0,
                                                    end: totalRanksCompleted,
                                                  ),
                                                  duration: const Duration(
                                                    seconds: 1,
                                                  ),
                                                  builder:
                                                      (
                                                        context,
                                                        value,
                                                        child,
                                                      ) => Text(
                                                        "$value",
                                                        style: GoogleFonts.orbitron(
                                                          color:
                                                          Colors
                                                              .lightGreenAccent,
                                                          fontWeight:
                                                          FontWeight.bold,
                                                          fontSize: 24,
                                                        ),
                                                      ),
                                                ),
                                              ],
                                            ),


                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Language Ranks Section
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 6.0),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Language Ranks",
                              style: GoogleFonts.orbitron(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (progressList.isEmpty)
                        Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Center(
                            child: Text(
                              "No progress yet.",
                              style: TextStyle(color: Colors.grey.shade400),
                            ),
                          ),
                        )
                      else
                        SizedBox(
                          height: 100,
                          child: PageView.builder(
                            controller: _pageController,
                            itemCount: progressList.length,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              final progress = progressList[index];
                              final matchingLang =
                                  languagesList
                                      .where((l) => l.id == progress.languageId)
                                      .firstOrNull;
                              String rankNameLower = progress.currentRankName
                                  .toLowerCase()
                                  .replaceAll(' ', '');
                              String rankImagePath =
                                  'assets/ranks/$rankNameLower${progress.currentRankPart}.png';
                              return Container(
                                height: 100,
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  gradient: RadialGradient(
                                    radius: 4,
                                    colors: [
                                      Colors.cyanAccent.withOpacity(0.1),
                                      Colors.white.withOpacity(0.15),
                                    ],
                                  ),

                                ),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      rankImagePath,
                                      height: 60,
                                      width: 60,
                                      errorBuilder:
                                          (c, e, s) => const Icon(
                                            Icons.shield,
                                            color: Colors.cyanAccent,
                                            size: 50,
                                          ),
                                    ),
                                    const SizedBox(width: 15),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            progress.currentRankName,
                                            style: GoogleFonts.orbitron(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            "Part ${progress.currentRankPart} • ${matchingLang?.name ?? progress.languageId.toUpperCase()}",
                                            style: GoogleFonts.orbitron(
                                              color: Colors.cyanAccent,
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (matchingLang?.icon != null)
                                      Opacity(
                                        opacity: 0.5,
                                        child: Image.asset(
                                          matchingLang!.icon,
                                          height: 35,
                                          width: 35,
                                        ),
                                      ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      // Achievements Section
                      Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: GestureDetector(
                          onTap:
                              () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Achievements(),
                                ),
                              ),
                          child: Container(
                            height: 150,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              gradient: RadialGradient(
                                radius: 4,
                                colors: [
                                  Colors.cyanAccent.withOpacity(0.1),
                                  Colors.white.withOpacity(0.2),
                                ],
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 35,
                                        width: 35,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.yellow.withOpacity(
                                                0.5,
                                              ),
                                              spreadRadius: 1,
                                              blurRadius: 7,
                                            ),
                                          ],
                                        ),
                                        child: const Icon(
                                          Icons.emoji_events,
                                          color: Colors.yellow,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        "Achievements",
                                        style: GoogleFonts.orbitron(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                      const Spacer(),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.grey.shade400,
                                        size: 16,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 14),
                                  SizedBox(
                                    height: 70,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: badges.length,
                                      itemBuilder:
                                          (context, index) => Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                              0,
                                              0,
                                              8,
                                              0,
                                            ),
                                            child: Container(
                                              height: 70,
                                              width: 70,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                gradient: RadialGradient(
                                                  radius: 4,
                                                  colors: [
                                                    Colors.cyanAccent
                                                        .withOpacity(0.1),
                                                    Colors.white.withOpacity(
                                                      0.5,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              child: Icon(
                                                badges[index],
                                                color: Colors.yellow,
                                                size: 28,
                                              ),
                                            ),
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
      loading:
          () => const Center(
            child: CircularProgressIndicator(color: Colors.cyanAccent),
          ),
      error:
          (e, st) => Center(
            child: Text('Error: $e', style: const TextStyle(color: Colors.red)),
          ),
    );
  }
}
