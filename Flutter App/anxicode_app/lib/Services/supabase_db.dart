import 'package:anxicode_app/Models/user_info.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthService {
  final _supabase = Supabase.instance.client;

  // allows to use user id
  AppUser? _userFromSupabase(User? user) {
    return user == null ? null : AppUser(userId: user.id);
  }

  // (getter) checks the user auth from supabase
  Stream<AppUser?> get user {
    return _supabase.auth.onAuthStateChange.map(
      (data) => _userFromSupabase(data.session?.user),
    );
  }

  Future<void> registerUser({required UserInfo userInfo}) async {
    await _supabase.auth.signUp(
      email: userInfo.getEmail,
      password: userInfo.getPassword,
      data: {
        'user_name': userInfo.getUserName,
        'name': userInfo.getName,
        'display_name': userInfo.getName,
      },
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
