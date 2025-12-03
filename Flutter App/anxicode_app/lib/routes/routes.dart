import 'package:go_router/go_router.dart';
import 'package:anxicode_app/login_page/login_page.dart';
import 'package:anxicode_app/sign_up_page/sign_up_page.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: [
      // Login Page
      GoRoute(path: '/', name: 'login', builder: (context, state) => LogIn()),

      // SignUp Page
      GoRoute(
        path: '/signup',
        name: 'signup',
        builder: (context, state) => SignUp(),
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
