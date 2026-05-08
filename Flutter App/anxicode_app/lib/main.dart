//import 'package:anxicode_app/login_page/login_page.dart';
//import 'package:anxicode_app/home_screen/Screens/ChatScreen/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:anxicode_app/routes/routes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: "https://knzvyzczilxhwssxaptn.supabase.co",
    anonKey: "sb_publishable_uwfy-Ctq4kcVpnBg8zFA1w_sgb7s0Rt",
  );
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.router,
      title: 'AnxiCode',
      debugShowCheckedModeBanner: false,
    );
  }
}
