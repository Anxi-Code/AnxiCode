import 'package:anxicode_app/Learning/mod/part1.dart';
import 'package:anxicode_app/Learning/mod/parts_model.dart';
import 'package:anxicode_app/Learning/mod/rank_manifest.dart';
import 'package:anxicode_app/Learning/mod/rank_model.dart';
import 'package:anxicode_app/Learning/pro/learning_provider.dart';
import 'package:anxicode_app/design/Quiz/mcqs_design.dart';
import 'package:anxicode_app/design/Quiz/topic_screen.dart';
import 'package:anxicode_app/design/bg_gradient/bg_gradient.dart';
import 'package:anxicode_app/home_screen/Screens/learn/Part5/part5_screen.dart';
import 'package:anxicode_app/home_screen/Screens/learn/flow_screen.dart';
import 'package:anxicode_app/home_screen/Screens/learn/flow_screen2.dart';
import 'package:anxicode_app/home_screen/Screens/learn/part1_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class RankPartsScreen extends ConsumerStatefulWidget {
  final RankModel rank;

  const RankPartsScreen({super.key, required this.rank});

  @override
  ConsumerState<RankPartsScreen> createState() => _RankPartsScreenState();
}

class _RankPartsScreenState extends ConsumerState<RankPartsScreen> {
  @override
  Widget build(BuildContext context) {
    final manifestAsync = ref.watch(
      ranksManifestProvider(widget.rank.languageId,widget.rank.rankName.toLowerCase()),
    );

    late final PartsModel partModel;
    List partsList;

    return Stack(
      children: [
        /// BACKGROUND
        const BgGradient(),
        manifestAsync.when(
          data: (manfest) {
            partModel = manfest.parts;
            final parts = [
              {
                "object": partModel.part1Learning,
                "rank": "${widget.rank.rankName} V",
                "title": "Code Fundamentals",
                "subtitle": "Build your foundation and unlock essential concepts.",
                "badge": "assets/ranks/${widget.rank.rankName.toLowerCase()}1.png",
                "screen": Part1Flow(slug: manfest.slug,part1topics: partModel.part1Learning,)
              },


              {
                "object": partModel.part2Mastery,
                "rank": "${widget.rank.rankName} IV",
                "title": "Concept Mastery Lab",
                "subtitle":
                "Sharpen your practical coding skills with guided exercises.",
                "badge": "assets/ranks/${widget.rank.rankName.toLowerCase()}2.png",
                "screen":Part2Flow(slug: manfest.slug,part2topics: partModel.part2Mastery,)
              },

              {
                "object": partModel.part3SyntaxLearning,
                "rank": "${widget.rank.rankName} III",
                "title": "Syntax Dominion",
                "subtitle": "Master syntax precision and improve coding accuracy.",
                "badge": "assets/ranks/${widget.rank.rankName.toLowerCase()}3.png",
              },

              {
                "object": partModel.part4Debugging,
                "rank": "${widget.rank.rankName} II",
                "title": "Error Tracking Arena",
                "subtitle": "Track, analyze, and eliminate hidden coding mistakes.",
                "badge": "assets/ranks/${widget.rank.rankName.toLowerCase()}4.png",
              },

              {
                "object": partModel.part5ConfidenceTest,
                "rank": "${widget.rank.rankName} I",
                "title": "Confidence Test",
                "subtitle": "Conquer the final confidence and mastery evaluation.",
                "badge": "assets/ranks/${widget.rank.rankName.toLowerCase()}5.png",
                "screen":Part5Screen(slug: manfest.slug,part5: partModel.part5ConfidenceTest,nextTopic: "End of Rank",nextPage: (){})
              },
            ];
            partsList = [
              partModel.part1Learning,
              partModel.part2Mastery,
              partModel.part3SyntaxLearning,
              partModel.part4Debugging,
              partModel.part5ConfidenceTest,
            ];

            return Scaffold(
              backgroundColor: Colors.transparent,

              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                centerTitle: true,

                leading: const BackButton(color: Colors.white),

                title: Text(
                  widget.rank.rankName.toUpperCase(),
                  style: GoogleFonts.orbitron(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
              ),

              body: ListView.builder(
                physics: const BouncingScrollPhysics(),

                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 14,
                ),

                itemCount: parts.length,

                itemBuilder: (context, index) {
                  final part = parts[index];

                  return TweenAnimationBuilder(
                    duration: Duration(milliseconds: 400 + (index * 80)),

                    tween: Tween<double>(begin: 0, end: 1),

                    builder: (context, value, child) {
                      return Transform.translate(
                        offset: Offset(0, 25 * (1 - value)),

                        child: Opacity(opacity: value, child: child),
                      );
                    },

                    child: GestureDetector(
                      onTap: () {

                        Navigator.push(context, MaterialPageRoute(builder: (context)=>part["screen"] as Widget));
                      },

                      child: Container(
                        margin: const EdgeInsets.only(bottom: 16),

                        padding: const EdgeInsets.all(18),

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(28),

                          gradient: RadialGradient(
                            radius: 3,
                            colors: [
                              Colors.cyanAccent.withValues(alpha: 0.10),

                              Colors.white.withValues(alpha: 0.08),
                            ],
                          ),
                        ),

                        child: Row(
                          children: [
                            Container(
                              height: 72,
                              width: 72,
                              padding: const EdgeInsets.all(6),

                              decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(28),

                                gradient: RadialGradient(
                                  colors: [
                                    Colors.cyanAccent.withValues(alpha: 0.20),
                                    Colors.white.withValues(alpha: 0.06),
                                  ],
                                ),
                              ),

                              child: Image.asset(
                                part["badge"] as String,
                                fit: BoxFit.contain,
                              ),
                            ),

                            const SizedBox(width: 18),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  Text(
                                    part["rank"] as String,

                                    style: GoogleFonts.orbitron(
                                      color: Colors.cyanAccent,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.5,
                                    ),
                                  ),

                                  const SizedBox(height: 8),


                                  Text(
                                    part["title"] as String,

                                    style: GoogleFonts.orbitron(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  const SizedBox(height: 8),

                                  Text(
                                    part["subtitle"] as String,

                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,

                                    style: GoogleFonts.orbitron(
                                      color: Colors.white70,
                                      fontSize: 10,
                                      height: 1.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.cyanAccent,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
          error: (e, _) {
            return Center(
              child: Text(
                e.toString(),
                style: GoogleFonts.orbitron(color: Colors.red, fontSize: 14),
              ),
            );
          },

          loading: () {
            return const Center(
              child: CircularProgressIndicator(color: Colors.cyanAccent),
            );
          },
        ),
      ],
    );
  }
}
