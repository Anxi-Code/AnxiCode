import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:rxdart/rxdart.dart';

import 'user_data.dart';

part 'user_provider.g.dart';

@riverpod
class UserNotifier extends _$UserNotifier {
  final _supabase = Supabase.instance.client;

  @override
  Stream<UserData?> build() async* {
    final user = _supabase.auth.currentUser;
    if (user == null) {
      yield null;
      return;
    }

    yield* _userStream(user.id);
  }

  Stream<UserData?> _userStream(String userId) {
    try {
      final profileStream = _supabase
          .from('profiles')
          .stream(primaryKey: ['id'])
          .eq('id', userId);

      final statsStream = _supabase
          .from('user_stats')
          .stream(primaryKey: ['user_id'])
          .eq('user_id', userId);

      return Rx.combineLatest2(profileStream, statsStream, (
        List<Map<String, dynamic>> profile,
        List<Map<String, dynamic>> stats,
      ) {
        if (profile.isEmpty || stats.isEmpty) return null;

        return UserData.fromSupabase(
          profile: profile.first,
          stats: stats.first,
        );
      });
    } catch (e) {
      return Stream.value(null);
    }
  }
}

// use in profile screen meesum

// final userAsync = ref.watch(userNotifierProvider);

// Then:

// return userAsync.when(
//   data: (user) {
//     if (user == null) return const Text("No user");

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(user.name),
//         Text(user.userName),
//         Text(user.email),
//         Text("Rating: ${user.rating}"),
//         Text("Wins: ${user.battlesWon}"),
//         Text("Streak: ${user.currentStreak}"),
//       ],
//     );
//   },
//   loading: () => const CircularProgressIndicator(),
//   error: (e, _) => Text("Error: $e"),
// );
