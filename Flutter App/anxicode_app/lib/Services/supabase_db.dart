import 'package:anxicode_app/Models/user_info.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthService {
  final _supabase = Supabase.instance.client;

  // allows to use user id
  AppUser? _userFromSupabase(User? user) {
    return user == null ? null : AppUser(userId: user.id);
  }

  Stream<AppUser?> get user async* {
    // First check existing session
    yield _userFromSupabase(_supabase.auth.currentUser);
    print(_supabase.auth.currentUser);
    // Then listen for auth changes
    await for (final data in _supabase.auth.onAuthStateChange) {
      yield _userFromSupabase(data.session?.user);
    }
  }

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
