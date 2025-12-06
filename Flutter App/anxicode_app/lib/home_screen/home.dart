import 'package:anxicode_app/home_screen/Screens/Battle_screen.dart';
import 'package:anxicode_app/home_screen/Screens/Chat_screen.dart';
import 'package:anxicode_app/home_screen/Screens/Leaderboard_screen.dart';
import 'package:anxicode_app/home_screen/Screens/Profile_screen.dart';
import 'package:anxicode_app/home_screen/Screens/Achievements.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Screens
  List<Widget> screens=[
    Chat(),
    Leaderboard(),
    Battle(),
    Achievements(),
    Profile(),

  ];
  //Icons
  List<Widget> bottomNavBarItems=[
    Icon(Icons.chat,),
    Icon(Icons.leaderboard),
    Icon(Icons.bolt),
    Icon(Icons.emoji_events),
    Icon(Icons.person,),
  ];
  //Index
  int currentIndex=2;
  //PageController
  PageController pageController=PageController(initialPage: 2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Page'), centerTitle: true),
      body: PageView(

        controller: pageController,
        scrollDirection: Axis.horizontal,
        onPageChanged: (index)=>{
          setState(() {
            currentIndex=index;
          }),
        },

        children: screens,
      ),

      bottomNavigationBar:Theme(
        data: Theme.of(context).copyWith(
          iconTheme: IconThemeData(color: Colors.white),
        ),
        child: CurvedNavigationBar(
              items: bottomNavBarItems,
              index: currentIndex,
              onTap: (index){

                setState(() {
                  currentIndex=index;
                });
                pageController.jumpToPage(index);


              },
            color: Colors.black,
            backgroundColor: Colors.transparent,
            animationDuration: Duration(milliseconds: 300),
          animationCurve: Curves.easeIn,


          ),
      ),

    );
  }
}
