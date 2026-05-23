// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import 'package:anxicode_app/Providers/user_state/user_state.dart';
// import 'package:anxicode_app/user_registration/login_page/login_page.dart';

// class Wrapper extends ConsumerWidget {
//   final Widget child;

//   const Wrapper({super.key, required this.child});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final user = ref.watch(userProvider);

//     if (user == null) {
//       return const LogIn();
//     }

//     return child;
//   }
// }

import 'package:anxicode_app/design/bg_gradient/bg_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  final supabase = Supabase.instance.client;

  @override
  void initState() {
    super.initState();
    authCheck();
  }

  Future<void> authCheck() async {
    try {
      // give supabase time to restore local session
      await Future.delayed(const Duration(milliseconds: 500));

      final session = supabase.auth.currentSession;

      // no cached session
      if (session == null) {
        if (!mounted) return;
        context.go('/login');
        return;
      }

      // FORCE refresh token from server
      final refreshed = await supabase.auth.refreshSession();

      // valid session
      if (refreshed.session != null) {
        if (!mounted) return;
        context.go('/');
      } else {
        // invalid session
        await supabase.auth.signOut();

        if (!mounted) return;
        context.go('/login');
      }
    } catch (e) {
      await supabase.auth.signOut();

      if (!mounted) return;
      context.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BgGradient(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: SpinKitChasingDots(color: Colors.cyanAccent, size: 50),
          ),
        ),
      ],
    );
  }
}
