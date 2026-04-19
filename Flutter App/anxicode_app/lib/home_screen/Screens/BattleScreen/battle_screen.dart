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
            SizedBox(height: 10),

            Padding(
              padding: EdgeInsets.only(left: 14),
              child: Text("Select Programming Language",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),

            SizedBox(height: 10),
            LanguagesDesign(),

            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.only(left: 14),
              child: Text("Select Battle Mode",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),

            SizedBox(height: 10),
            BattleModeDesign(),

            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text("Select Opponent",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),

            SizedBox(height: 10),
            OpponentSelectionDesign(),

            SizedBox(height: 30),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 55),
                  backgroundColor: Colors.blue.shade100,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text("Start Battle",
                style: TextStyle(
                  color: Colors.white
                ),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}