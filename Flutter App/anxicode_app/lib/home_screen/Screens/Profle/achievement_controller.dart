import 'achievement_data.dart';

class AchievementController {
  static void unlockAchievement(String id) {
    final index = achievementsData.indexWhere(
          (achievement) => achievement.id == id,
    );

    if (index != -1) {
      achievementsData[index].unlocked = true;
    }
  }

  static int getUnlockedCount() {
    return achievementsData.where((item) => item.unlocked).length;
  }

  static int getTotalPoints() {
    int total = 0;

    for (var achievement in achievementsData) {
      if (achievement.unlocked) {
        total += int.parse(
          achievement.points.replaceAll("+", ""),
        );
      }
    }

    return total;
  }
}