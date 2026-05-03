import 'package:anxicode_app/home_screen/Screens/BattleScreen/battle_mode_design.dart';
import 'package:anxicode_app/home_screen/Screens/BattleScreen/languages_design.dart';
import 'package:anxicode_app/home_screen/Screens/BattleScreen/opponent_selection_design.dart';
import 'package:anxicode_app/home_screen/Screens/BattleScreen/problem_categories_design.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Battle extends StatefulWidget {
  const Battle({super.key});

  @override
  State<Battle> createState() => _BattleState();
}

class _BattleState extends State<Battle> {
  String? selectedLanguage;

  @override
  Widget build(BuildContext context) {
    final supabase = Supabase.instance.client;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF120458),
            Color(0xFF2B0B98),
            Color(0xFF5F0A87),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ProblemCategoriesDesign(),
              const SizedBox(height: 10),

              const Padding(
                padding: EdgeInsets.only(left: 14),
                child: Text(
                  "Select Programming Language",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              LanguagesDesign(
                onLanguageSelected: (lang) {
                  setState(() {
                    selectedLanguage = lang;
                  });
                },
              ),

              const SizedBox(height: 10),

              const Padding(
                padding: EdgeInsets.only(left: 14),
                child: Text(
                  "Select Battle Mode",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 10),
              const BattleModeDesign(),

              const SizedBox(height: 10),

              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "Select Opponent",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 10),
              const OpponentSelectionDesign(),

              const SizedBox(height: 30),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF00C9A7), Color(0xFF007CF0)],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (selectedLanguage == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please select a language"),
                          ),
                        );
                        return;
                      }

                      await supabase.from('match_queue').insert({
                        'user_id': supabase.auth.currentUser!.id,
                        'ranking': 500,
                        'language': selectedLanguage,
                        'status': 'waiting',
                      });

                      context.push('/matchmaking');
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 55),
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      "Start Battle",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}