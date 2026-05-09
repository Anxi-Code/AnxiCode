import 'package:anxicode_app/home_screen/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
//import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  Future<void> _checkUser() async {
    await Supabase.instance.client.auth.currentSession;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _checkUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: SpinKitChasingDots(size: 80, color: Colors.white),
          );
        }
        return Home();
      },
    );
  }
}
