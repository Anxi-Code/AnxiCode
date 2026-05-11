import 'package:anxicode_app/Models/user_info.dart';
import 'package:anxicode_app/Services/supabase_db.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// uses the getter from class
final authServiceProvider = Provider((Ref ref) => SupabaseAuthService());

// checks user session
final userStateProvider = StreamProvider<AppUser?>(
  (Ref ref) => ref.watch(authServiceProvider).user,
);
