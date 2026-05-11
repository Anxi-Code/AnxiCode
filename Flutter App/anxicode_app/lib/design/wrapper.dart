import 'package:anxicode_app/home_screen/home.dart';
import 'package:anxicode_app/user_registration/login_page/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anxicode_app/Providers/user_state/user_state.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Wrapper extends ConsumerStatefulWidget {
  const Wrapper({super.key});

  @override
  ConsumerState<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends ConsumerState<Wrapper> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    final userSession = ref.watch(userStateProvider);

    return userSession.when(
      data: (user) {
        if (user != null) {
          return Home();
        } else {
          return LogIn();
        }
      },

      loading:
          () => Scaffold(
            body: Center(
              child: SpinKitFadingCircle(color: Colors.white, size: 30),
            ),
          ),

      error:
          (error, stack) =>
              Scaffold(body: Center(child: Text(error.toString()))),
    );
  }
}
