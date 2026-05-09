class UserData {
  final String name;
  final String userName;
  final String email;
  final int rating;

  final int battlesPlayed;
  final int battlesWon;
  final int battlesLost;
  final int drawCount;

  final int currentStreak;
  final int bestStreak;

  final Map<String, dynamic> badges;

  UserData({
    required this.name,
    required this.userName,
    required this.email,
    required this.rating,
    required this.battlesPlayed,
    required this.battlesWon,
    required this.battlesLost,
    required this.drawCount,
    required this.currentStreak,
    required this.bestStreak,
    required this.badges,
  });

  factory UserData.fromSupabase({
    required Map<String, dynamic> profile,
    required Map<String, dynamic> stats,
  }) {
    return UserData(
      name: profile['user_name'] ?? '',
      userName: profile['user_name'] ?? '',
      email: profile['email'] ?? '',
      rating: profile['rating'] ?? 500,

      battlesPlayed: stats['battles_played'] ?? 0,
      battlesWon: stats['battles_won'] ?? 0,
      battlesLost: stats['battles_lost'] ?? 0,
      drawCount: stats['draw_count'] ?? 0,
      currentStreak: stats['current_streak'] ?? 0,
      bestStreak: stats['best_streak'] ?? 0,

      badges: Map<String, dynamic>.from(stats['badges'] ?? {}),
    );
  }
}
