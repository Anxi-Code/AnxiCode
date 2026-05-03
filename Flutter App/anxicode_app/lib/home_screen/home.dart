import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
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
  List<Widget> screens = [
    Chat(),
    Leaderboard(),
    Battle(),
    Achievements(),
    Profile(),
  ];

  List<Widget> bottomNavBarItems = [
    const Icon(Icons.chat, color: Colors.white),
    const Icon(Icons.leaderboard, color: Colors.white),
    const Icon(Icons.bolt, color: Colors.white),
    const Icon(Icons.emoji_events, color: Colors.white),
    const Icon(Icons.person, color: Colors.white),
  ];

  int currentIndex = 2;
  PageController pageController = PageController(initialPage: 2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: const Color(0xFF120458),

      appBar: AppBar(
        toolbarHeight: 40,
        backgroundColor: const Color(0xFF120458),
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),

      body: Container(
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
        child: PageView(
          controller: pageController,
          scrollDirection: Axis.horizontal,
          onPageChanged: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          children: screens,
        ),
      ),

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.cyanAccent.withOpacity(0.25),
              blurRadius: 20,
              spreadRadius: 2,
            ),
          ],
        ),
        child: CurvedNavigationBar(
          items: bottomNavBarItems,
          index: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
            pageController.jumpToPage(index);
          },
          color: const Color(0xFF1B1B3A),
          buttonBackgroundColor: const Color(0xFF00C9A7),
          backgroundColor: Colors.transparent,
          animationDuration: const Duration(milliseconds: 300),
          animationCurve: Curves.easeInOut,
        ),
      ),
    );
  }
}