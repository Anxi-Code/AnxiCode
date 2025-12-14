import 'package:anxicode_app/home_screen/Screens/BattleScreen/languages_design.dart';
import 'package:flutter/material.dart';

class Battle extends StatelessWidget {
  const Battle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
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
          SizedBox(height: 20),
          LanguagesDesign(),
        ],
      ),
    );
  }
}
