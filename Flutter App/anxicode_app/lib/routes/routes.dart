// import 'package:anxicode_app/design/wrapper.dart';
import 'package:anxicode_app/home_screen/Screens/BattleScreen/match_making/matchmaking_screen.dart';
import 'package:anxicode_app/home_screen/home.dart';
import 'package:go_router/go_router.dart';
import 'package:anxicode_app/user_registration/login_page/login_page.dart';
import 'package:anxicode_app/user_registration/sign_up_page/sign_up_page.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: [
      //wrapper
      // GoRoute(
      //   path: '/',
      //   name: 'wrapper',
      //   builder: (context, state) => Wrapper(),
      // ),
      // Login Page
      GoRoute(path: '/', name: 'login', builder: (context, state) => LogIn()),

      // SignUp Page
      GoRoute(
        path: '/signup',
        name: 'signup',
        builder: (context, state) => SignUp(),
      ),

      //home page
      GoRoute(path: '/home', name: 'home', builder: (context, state) => Home()),

      // match making page
      GoRoute(
        path: '/matchmaking',
        name: 'matchmaking',
        builder: (context, state) => Matchmaking(),
      ),
    ],

    //'errorBuilder'
    errorBuilder:
        (context, state) => Scaffold(
          body: Center(
            child: Text('Page not found!', style: TextStyle(fontSize: 24)),
          ),
        ),
  );
}
