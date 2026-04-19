import 'package:anxicode_app/Models/user_info.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseDb {
  final _supabase = Supabase.instance.client;

  Future<void> registerUser({required UserInfo userInfo}) async {
    await _supabase.auth.signUp(
      email: userInfo.getEmail,
      password: userInfo.getPassword,
      data: {'user_name': userInfo.getUserName},
    );
  }

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    await _supabase.auth.signInWithPassword(password: password, email: email);
  }

  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }
}
