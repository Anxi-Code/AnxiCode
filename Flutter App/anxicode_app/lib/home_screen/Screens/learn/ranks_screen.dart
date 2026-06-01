import 'package:anxicode_app/Learning/pro/learning_provider.dart';
import 'package:anxicode_app/design/bg_gradient/bg_gradient.dart';
import 'package:anxicode_app/home_screen/Screens/learn/parts_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class RanksScreen extends ConsumerWidget {
  final String languageId;
  final String languageName;

  const RanksScreen({
    super.key,
    required this.languageId,
    required this.languageName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ranksAsync = ref.watch(ranksProvider(languageId));

    return Stack(
      children: [
        const BgGradient(),

        Scaffold(
          backgroundColor: Colors.transparent,

          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              languageName.toUpperCase(),
              style: GoogleFonts.orbitron(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
            centerTitle: true,
            leading: BackButton(color: Colors.white,),
          ),

          body: ranksAsync.when(
            data: (ranks) {
              /// 🔁 SORT RANKS ASCENDING
              final sortedRanks = [...ranks]
                ..sort((a, b) => a.rankOrder.compareTo(b.rankOrder));

              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 14,
                ),
                itemCount: sortedRanks.length,
                itemBuilder: (context, index) {

                  final rank = sortedRanks[index];

                  return TweenAnimationBuilder(
                    duration: Duration(milliseconds: 400 + (index * 80)),
                    tween: Tween<double>(begin: 0, end: 1),
                    builder: (context, value, child) {
                      return Transform.translate(
                        offset: Offset(0, 25 * (1 - value)),
                        child: Opacity(
                          opacity: value,
                          child: child,
                        ),
                      );
                    },

                    child: GestureDetector(
                      onTap: (){

                        Navigator.push(context, MaterialPageRoute(builder: (context)=>RankPartsScreen(rank: rank)));

                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(28),
                          gradient: RadialGradient(
                            radius: 3,
                            colors: [
                              Colors.cyanAccent.withValues(alpha: 0.1),
                              Colors.white.withValues(alpha: 0.1),
                            ],
                          ),

                        ),

                        child: Row(
                          children: [
                            /// ICON
                            Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: RadialGradient(
                                  colors: [
                                    Colors.cyanAccent.withValues(alpha: 0.2),
                                    Colors.white.withValues(alpha: 0.1),
                                  ],
                                ),

                              ),
                              child: const Icon(
                                Icons.workspace_premium,
                                color: Colors.cyanAccent,
                                size: 28,
                              ),
                            ),

                            const SizedBox(width: 16),

                            /// TEXT
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Rank ${rank.rankOrder}",
                                    style: GoogleFonts.orbitron(
                                      color: Colors.cyanAccent,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      letterSpacing: 1.2,
                                    ),
                                  ),

                                  const SizedBox(height: 8),

                                  Text(
                                    rank.rankName,
                                    style: GoogleFonts.orbitron(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  const SizedBox(height: 6),

                                  Text(
                                    rank.description,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.orbitron(
                                      color: Colors.white,
                                      fontSize: 12,

                                    ),
                                  ),
                                ],
                              ),
                            ),

                            /// RIGHT ARROW
                            const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.cyanAccent,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },

            error: (e, _) {
              return Center(
                child: Text(
                  e.toString(),
                  style: GoogleFonts.orbitron(
                    color: Colors.red,
                  ),
                ),
              );
            },

            loading: () {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.cyanAccent,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}