import 'package:anxicode_app/home_screen/Screens/BattleScreen/battle_screen.dart';
import 'package:anxicode_app/home_screen/Screens/ChatScreen/chat_screen.dart';
import 'package:anxicode_app/home_screen/Screens/LeaderBoardScreen/leaderboard_screen.dart';
import 'package:anxicode_app/home_screen/Screens/Profle/profile_screen.dart';
import 'package:anxicode_app/home_screen/Screens/Achievements/achievements.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Screens
  List<Widget> screens = [
    Chat(),
    Leaderboard(),
    Battle(),
    Achievements(),
    Profile(),
  ];
  //Icons
  List<Widget> bottomNavBarItems = [
    Icon(Icons.chat),
    Icon(Icons.leaderboard),
    Icon(Icons.bolt),
    Icon(Icons.emoji_events),
    Icon(Icons.person),
  ];
  //Index
  int currentIndex = 2;
  //PageController
  PageController pageController = PageController(initialPage: 2);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/home_background.jpeg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,

        appBar: AppBar(toolbarHeight: 35, backgroundColor: Colors.transparent),
        body: PageView(
          controller: pageController,
          scrollDirection: Axis.horizontal,
          onPageChanged:
              (index) => {
                setState(() {
                  currentIndex = index;
                }),
              },

          children: screens,
        ),

        bottomNavigationBar: Theme(
          data: Theme.of(
            context,
          ).copyWith(iconTheme: IconThemeData(color: Colors.black)),
          child: CurvedNavigationBar(
            items: bottomNavBarItems,
            index: currentIndex,
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
              pageController.jumpToPage(index);
            },
            color: Colors.white,
            backgroundColor: Colors.transparent,
            animationDuration: Duration(milliseconds: 300),
            animationCurve: Curves.easeIn,
          ),
        ),
      ),
    );
  }
}
