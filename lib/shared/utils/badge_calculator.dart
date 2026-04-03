import '../models/habit_badge.dart';

class BadgeCalculator {
  BadgeCalculator._();

  static List<HabitBadge> compute(int longestStreak, int totalCompletions) {
    return [
      HabitBadge(
        type: BadgeType.firstStep,
        emoji: '🌱',
        earned: totalCompletions >= 1,
      ),
      HabitBadge(
        type: BadgeType.weekWarrior,
        emoji: '🔥',
        earned: longestStreak >= 7,
      ),
      HabitBadge(
        type: BadgeType.fortnight,
        emoji: '⚡',
        earned: longestStreak >= 14,
      ),
      HabitBadge(
        type: BadgeType.monthlyMaster,
        emoji: '💪',
        earned: longestStreak >= 30,
      ),
      HabitBadge(
        type: BadgeType.centuryStreak,
        emoji: '🏆',
        earned: longestStreak >= 100,
      ),
      HabitBadge(
        type: BadgeType.yearOfHabit,
        emoji: '👑',
        earned: longestStreak >= 365,
      ),
      HabitBadge(
        type: BadgeType.dedicated,
        emoji: '⭐',
        earned: totalCompletions >= 50,
      ),
      HabitBadge(
        type: BadgeType.centuryClub,
        emoji: '🌟',
        earned: totalCompletions >= 100,
      ),
    ];
  }
}
