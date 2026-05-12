import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:anxicode_app/Models/user_info.dart';

final userProvider = Provider<AppUser?>((ref) {
  final authState = ref.watch(authStateProvider);

  final user = authState.asData?.value;

  if (user == null) return null;

  return AppUser(userId: user.id);
});

final authStateProvider = StreamProvider<User?>((ref) {
  return Supabase.instance.client.auth.onAuthStateChange.map(
    (event) => event.session?.user,
  );
});
