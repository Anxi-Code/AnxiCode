import 'package:anxicode_app/home_screen/Screens/BattleScreen/battle_mode_design.dart';
import 'package:anxicode_app/home_screen/Screens/BattleScreen/languages_design.dart';
import 'package:anxicode_app/home_screen/Screens/BattleScreen/opponent_selection_design.dart';
import 'package:anxicode_app/home_screen/Screens/BattleScreen/problem_categories_design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
            const SizedBox(height: 20),
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
            const SizedBox(height: 20),
            LanguagesDesign(),
            const SizedBox(height: 20),
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
            const SizedBox(height: 20),

            BattleModeDesign(),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.fromLTRB(14, 0, 0, 0),
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
            const SizedBox(height: 20),
            OpponentSelectionDesign(),

            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text("Start Battle"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white.withValues(alpha: 0.1),
                        foregroundColor: Colors.white,
                       elevation: 1.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),


                        ),
                        minimumSize: Size(double.infinity, 60),
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
