import 'package:anxicode_app/design/bg_gradient/bg_gradient.dart';
import 'package:anxicode_app/design/custom_nav_bar/custom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:anxicode_app/home_screen/Screens/BattleScreen/battle_screen.dart';
import 'package:anxicode_app/home_screen/Screens/ChatScreen/chat_screen.dart';
import 'package:anxicode_app/home_screen/Screens/LeaderBoardScreen/leaderboard_screen.dart';
import 'package:anxicode_app/home_screen/Screens/Profle/profile_screen.dart';
import 'package:anxicode_app/home_screen/Screens/weekly_challenge_screen/weekly_challenge_screen.dart';

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
    WeeklyChallengeScreen(),
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
    return Stack(
      children: [
        BgGradient(),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(backgroundColor: Colors.transparent),
          body: Center(
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
        ),
      ],
    );
  }
}
