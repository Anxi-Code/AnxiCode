import 'package:anxicode_app/home_screen/Screens/BattleScreen/battle_mode_design.dart';
import 'package:anxicode_app/home_screen/Screens/BattleScreen/languages_design.dart';
import 'package:anxicode_app/home_screen/Screens/BattleScreen/opponent_selection_design.dart';
import 'package:anxicode_app/home_screen/Screens/BattleScreen/problem_categories_design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glass_kit/glass_kit.dart';

class Battle extends ConsumerWidget {
  const Battle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            ProblemCategoriesDesign(),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 0, 0, 0),
              child: Text(
                "Select Programming Language",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 10),
            LanguagesDesign(),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 0, 0, 0),
              child: Text(
                "Select Battle Mode",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 10),

            BattleModeDesign(),

            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Text(
                "Select Opponent",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 10),
            OpponentSelectionDesign(),

            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: GlassContainer(
                      width: double.infinity,
                      height: 55,
                      gradient: LinearGradient(
                        colors: [Colors.white.withValues(alpha:0.50), Colors.white.withValues(alpha:0.10)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),

                      blur: 15.0,
                      borderWidth: 1.0,
                      elevation: 4.0,
                      borderRadius: BorderRadius.circular(25),
                      shadowColor: Colors.black.withValues(alpha: 0.2),
                      alignment: Alignment.center,
                      frostedOpacity: 0.2,
                      margin: EdgeInsets.all(8.0),
                      padding: EdgeInsets.all(8.0),

                      borderGradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors:
                          [
                            Colors.white.withValues(alpha: 4.0),
                            Colors.white.withValues(alpha: 1.0),
                          ],

                          stops: [0.0,0.7]
                      ),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.black45,
                          shadowColor: Colors.transparent,
                          minimumSize: Size(double.infinity, 60),
                        ),
                        child: Text("Start Battle"),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
