import 'package:anxicode_app/Services/supabase_db.dart';
import 'package:anxicode_app/design/bg_gradient/bg_gradient.dart';
import 'package:anxicode_app/design/custom_nav_bar/custom_nav_bar.dart';
import 'package:anxicode_app/home_screen/Screens/learn/languages_screen.dart';
import 'package:flutter/material.dart';
import 'package:anxicode_app/home_screen/Screens/LeaderBoardScreen/leaderboard_screen.dart';
import 'package:anxicode_app/home_screen/Screens/weekly_challenge_screen/weekly_challenge_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:anxicode_app/home_screen/Screens/DrawerScreens/account_info.dart';
import 'package:anxicode_app/home_screen/Screens/DrawerScreens/helpcenter_screen.dart';
import 'package:anxicode_app/home_screen/Screens/DrawerScreens/aboutus_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 2;
  PageController pageController = PageController(initialPage: 1);
  SupabaseAuthService _auth = SupabaseAuthService();

  List<Widget> screens = [
    Leaderboard(),
    LanguagesScreen(),
    WeeklyChallengeScreen(),
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
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: Colors.transparent,
            title: Text(
              "AnxiCode",
              style: GoogleFonts.orbitron(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
          ),
          drawer: Drawer(
            backgroundColor: Colors.black87,
            child: ListView(
              children: [
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: Colors.transparent),
                  accountName: Text(
                    "Meesum Afzaal",
                    style: GoogleFonts.orbitron(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  accountEmail: Text(
                    "abcd@example.com",
                    style: TextStyle(
                      color: Colors.grey.shade400,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  currentAccountPicture: Container(
                    height: 120,
                    width: 120,
                    padding: EdgeInsetsGeometry.all(5.0),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blueAccent.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                        ),
                      ],
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.cyanAccent, width: 2.5),
                    ),
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/images/user1.png'),
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.person_2_outlined, color: Colors.white),
                  title: Text(
                    "Account Information",
                    style: GoogleFonts.orbitron(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),

                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AccountInfo(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.help_outline, color: Colors.white),

                  title: Text(
                    "Help Center",
                    style: GoogleFonts.orbitron(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),

                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HelpCenterScreen(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.info_outline, color: Colors.white),

                  title: Text(
                    "About Us",
                    style: GoogleFonts.orbitron(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),

                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AboutUsScreen(),
                      ),
                    );
                  },
                ),
                GestureDetector(
                  onTap: () {
                    _auth.signOut();
                  },
                  child: ListTile(
                    leading: Icon(Icons.logout, color: Colors.white),
                    title: Text(
                      "Log out",
                      style: GoogleFonts.orbitron(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
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
