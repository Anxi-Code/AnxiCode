import 'package:anxicode_app/design/custom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:anxicode_app/home_screen/Screens/BattleScreen/battle_screen.dart';
import 'package:anxicode_app/home_screen/Screens/ChatScreen/chat_screen.dart';
import 'package:anxicode_app/home_screen/Screens/LeaderBoardScreen/leaderboard_screen.dart';
import 'package:anxicode_app/home_screen/Screens/Profle/profile_screen.dart';
import 'package:anxicode_app/home_screen/Screens/Achievements/achievements.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 2;
  PageController pageController = PageController(initialPage: 2);

  List<Widget> screens = [
    Chat(),
    Leaderboard(),
    Battle(),
    Achievements(),
    Profile(),
  ];

  void onTabChanged(int index) {
    setState(() {
      currentIndex = index;
    });

    pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: const Color(0xFF120458),

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF120458), Color(0xFF2B0B98), Color(0xFF5F0A87)],
          ),
        ),

        child: PageView(
          controller: pageController,
          onPageChanged: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          children: screens,
        ),
      ),

      bottomNavigationBar: CustomBottomBar(
        currentIndex: currentIndex,
        onTap: onTabChanged,
      ),
    );
  }
}
