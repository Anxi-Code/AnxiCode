import 'package:anxicode_app/design/battle_design/battle_mode_design.dart';
import 'package:anxicode_app/design/battle_design/languages_design.dart';
import 'package:anxicode_app/design/battle_design/opponent_selection_design.dart';
import 'package:anxicode_app/home_screen/Screens/BattleScreen/match_making/matchmaking_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Battle extends StatefulWidget {
  const Battle({super.key});

  @override
  State<Battle> createState() => _BattleState();
}

class _BattleState extends State<Battle> {
  String selectedLanguage="Python";

  @override
  Widget build(BuildContext context) {
    final supabase = Supabase.instance.client;

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 14),
              child: Text(
                "Select Programming Language",
                style: TextStyle(
                  color: Colors.grey.shade400,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
      
            const SizedBox(height: 15),
      
            LanguagesDesign(
              onLanguageSelected: (lang) {
                setState(() {
                  selectedLanguage = lang;
                });
              },
            ),
      
            const SizedBox(height: 20),
      
             Padding(
              padding: EdgeInsets.only(left: 14),
              child: Text(
                "Select Battle Mode",
                style: TextStyle(
                  color: Colors.grey.shade400,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
      
            const SizedBox(height: 10),
            const BattleModeDesign(),
      
            const SizedBox(height: 30),
      
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                "Select Opponent",
                style: TextStyle(
                  color: Colors.grey.shade400,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
      
            const SizedBox(height: 10),
            const OpponentSelectionDesign(),
      
            const SizedBox(height: 50),
      
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child:Container(
                width: double.infinity,
                height: 58,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
      
      
                  gradient: const LinearGradient(
                    colors: [Color(0xFF00C9A7), Color(0xFF007CF0)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
      
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF00C2FF).withOpacity(0.7),
                      blurRadius: 18,
                      spreadRadius: 2,
                    ),
                  ],
      
      
                ),
      
                child: ElevatedButton(
                  onPressed: () async {
                    final user = supabase.auth.currentUser;

                    if (user == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("User not logged in")),
                      );
                      return;
                    }

                    await supabase.from('match_queue').insert({
                      'user_id': user.id,
                      'ranking': 500,
                      'language': selectedLanguage,
                      'status': 'waiting',
                    });

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Matchmaking()),
                    );
                  },

      
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
      
                  child: const Text(
                    "Start Battle",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              )
      
            ),
      
          ],
        ),
      ),
    );
  }
}
