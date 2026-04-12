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
    Icon(Icons.chat),
    Icon(Icons.leaderboard),
    Icon(Icons.bolt),
    Icon(Icons.emoji_events),
    Icon(Icons.person),
  ];

  int currentIndex = 2;
  PageController pageController = PageController(initialPage: 2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade100,

      appBar: AppBar(
        toolbarHeight: 40,
        backgroundColor: Colors.orange.shade100, // ✅ SAME AS BACKGROUND
        elevation: 0,
      ),

      body: Container(
        color: Colors.orange.shade100,
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

      bottomNavigationBar: CurvedNavigationBar(
        items: bottomNavBarItems,
        index: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
          pageController.jumpToPage(index);
        },

        color: Colors.white,
        backgroundColor: Colors.orange.shade100,
        animationDuration: Duration(milliseconds: 300),
        animationCurve: Curves.easeIn,
      ),
    );
  }
}