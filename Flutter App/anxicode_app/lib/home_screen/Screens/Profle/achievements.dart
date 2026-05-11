import 'package:anxicode_app/design/bg_gradient/bg_gradient.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class Achievements extends StatefulWidget {
  const Achievements({super.key});

  @override
  State<Achievements> createState() => _AchievementsState();
}

class _AchievementsState extends State<Achievements> {
  @override
  Widget build(BuildContext context) {
    return  Stack(
          children: [
            BgGradient(),
            Scaffold(
              backgroundColor: Colors.transparent,
                appBar: AppBar(
                  title: Text("Achievements",style: GoogleFonts.orbitron(color: Colors.white,fontWeight:FontWeight.bold,fontSize: 18),),
                  centerTitle: true,
                  backgroundColor: Colors.transparent,
                  leading: BackButton(color: Colors.white,),
                ),
              body: Center(
                child: Text("Achievemen screen coming soon",style: GoogleFonts.orbitron(color: Colors.white,fontWeight:FontWeight.bold,fontSize: 16),),
              ),
            )
          ],
    );
  }
}
