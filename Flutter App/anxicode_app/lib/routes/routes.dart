import 'package:anxicode_app/design/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:anxicode_app/home_screen/home.dart';
import 'package:anxicode_app/home_screen/Screens/BattleScreen/match_making/matchmaking_screen.dart';
import 'package:anxicode_app/user_registration/login_page/login_page.dart';
import 'package:anxicode_app/user_registration/sign_up_page/sign_up_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/splash',

    routes: [
      GoRoute(
        path: '/splash',
        name: 'splash',
        builder: (context, state) => const Wrapper(),
      ),

      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LogIn(),
      ),

      GoRoute(
        path: '/signup',
        name: 'signup',
        builder: (context, state) => const SignUp(),
      ),

      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const Home(),
      ),

      GoRoute(
        path: '/matchmaking',
        name: 'matchmaking',
        builder: (context, state) => const Matchmaking(),
      ),
    ],

    errorBuilder:
        (context, state) => const Scaffold(
          body: Center(
            child: Text('Page not found!', style: TextStyle(fontSize: 20)),
          ),
        ),
  );
}
