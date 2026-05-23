import 'package:flutter/material.dart';
import 'package:anxicode_app/design/bg_gradient/bg_gradient.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:anxicode_app/home_screen/Screens/DrawerScreens/change_emailscreen.dart';
import 'package:anxicode_app/home_screen/Screens/DrawerScreens/helpcenter_screen.dart';
import 'package:anxicode_app/home_screen/Screens/DrawerScreens/aboutus_screen.dart';
import 'package:anxicode_app/home_screen/Screens/DrawerScreens/change_passwordscreen.dart';

class AccountInfo extends StatelessWidget {
  const AccountInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BgGradient(),

        Scaffold(
          backgroundColor: Colors.transparent,

          appBar: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            elevation: 0,
            leading: BackButton(color: Colors.white,),
            title: const Text(
              "Account Information",
              style: TextStyle(color: Colors.white),
            ),
          ),

          body: Padding(
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    height: 120,
                    width: 120,
                    padding: EdgeInsetsGeometry.all(5.0),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blueAccent.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,

                          )
                        ],
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: Colors.cyanAccent,
                            width: 2.5
                        )
                    ),
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/images/user1.png'),

                    ),
                  ),
                ),
                Divider(
                  height: 50,
                  color: Colors.blueAccent.withOpacity(0.5),
                ),
                Row(
                  children: [
                    Icon(Icons.person_2_outlined,
                      color: Colors.grey,
                    ),
                    SizedBox(width: 10,),
                    Text(
                      'Meesum Afzaal',
                      style: GoogleFonts.orbitron(
                        color: Colors.blueAccent.withOpacity(0.5),
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30,),
                Row(
                  children: [
                    Icon(Icons.mail,
                      color: Colors.grey,
                    ),
                    SizedBox(width: 10,),
                    Text(
                      'abcd@example.com',
                      style: GoogleFonts.orbitron(
                        color: Colors.blueAccent.withOpacity(0.5),
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30,),
                Row(
                  children: [
                    Icon(Icons.call,
                      color: Colors.grey,
                    ),
                    SizedBox(width: 10,),
                    Text(
                      '03334445555',
                      style: GoogleFonts.orbitron(
                        color: Colors.blueAccent.withOpacity(0.5),
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40),

                Hero(
                  tag: 'changeEmail',

                  child: Material(
                    color: Colors.transparent,

                    child: InkWell(
                      borderRadius: BorderRadius.circular(15),

                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ChangeEmailScreen(),
                          ),
                        );
                      },

                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          vertical: 18,
                          horizontal: 20,
                        ),

                        decoration: BoxDecoration(
                          color: Colors.blueAccent.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(15),

                          border: Border.all(
                            color: Colors.cyanAccent,
                            width: 1.5,
                          ),
                        ),

                        child: Row(
                          children: [

                            const Icon(
                              Icons.mail_outline,
                              color: Colors.white,
                            ),

                            const SizedBox(width: 15),

                            Text(
                              "Change Email",
                              style: GoogleFonts.orbitron(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),

                            const Spacer(),

                            const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Hero(
                  tag: 'changePassword',

                  child: Material(
                    color: Colors.transparent,

                    child: InkWell(
                      borderRadius: BorderRadius.circular(15),

                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ChangePasswordScreen(),
                          ),
                        );
                      },

                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          vertical: 18,
                          horizontal: 20,
                        ),

                        decoration: BoxDecoration(
                          color: Colors.blueAccent.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(15),

                          border: Border.all(
                            color: Colors.cyanAccent,
                            width: 1.5,
                          ),
                        ),

                        child: Row(
                          children: [

                            Icon(
                              Icons.lock_outline,
                              color: Colors.white,
                            ),

                            SizedBox(width: 15),

                            Text(
                              "Change Password",
                              style: GoogleFonts.orbitron(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),

                            Spacer(),

                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}