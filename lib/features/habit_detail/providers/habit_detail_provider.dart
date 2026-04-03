import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../features/habits/providers/habits_provider.dart';
import '../../../shared/models/habit_badge.dart';
import '../../../shared/utils/badge_calculator.dart';
import '../../../shared/utils/streak_calculator.dart';

class HabitDetailStats {
  const HabitDetailStats({
    required this.currentStreak,
    required this.longestStreak,
    required this.totalCompletions,
    required this.thisMonthCompletions,
  });
  final int currentStreak;
  final int longestStreak;
  final int totalCompletions;
  final int thisMonthCompletions;
}

/// Computed streak + summary stats for a single habit.
final habitDetailStatsProvider = Provider.autoDispose
    .family<AsyncValue<HabitDetailStats>, Habit>((ref, habit) {
  return ref.watch(habitCheckInsProvider(habit.id)).whenData((checkIns) {
    final completed = checkIns.where((c) => c.completed).toList();
    final completedDates = completed.map((c) => c.date).toList();

    final now = DateTime.now();
    final monthStart = DateTime(now.year, now.month, 1);
    final thisMonth = completed
        .where((c) =>
            !DateTime(c.date.year, c.date.month, c.date.day).isBefore(monthStart))
        .length;

    return HabitDetailStats(
      currentStreak: StreakCalculator.currentStreak(
          completedDates, habit.gracePeriodEnabled),
      longestStreak: StreakCalculator.longestStreak(
          completedDates, habit.gracePeriodEnabled),
      totalCompletions: completed.length,
      thisMonthCompletions: thisMonth,
    );
  });
});

/// date-only → completed? map for the past 35 days for a single habit.
final habitHistoryProvider = Provider.autoDispose
    .family<AsyncValue<Map<DateTime, bool>>, Habit>((ref, habit) {
  return ref.watch(habitCheckInsProvider(habit.id)).whenData((checkIns) {
    final map = <DateTime, bool>{};
    for (final ci in checkIns) {
      final day = DateTime(ci.date.year, ci.date.month, ci.date.day);
      map[day] = ci.completed;
    }
    return map;
  });
});

/// Computed milestone badges for a single habit.
final habitBadgesProvider = Provider.autoDispose
    .family<AsyncValue<List<HabitBadge>>, Habit>((ref, habit) {
  return ref.watch(habitDetailStatsProvider(habit)).whenData((stats) {
    return BadgeCalculator.compute(stats.longestStreak, stats.totalCompletions);
  });
});

/// Last 5 check-ins that have a note, newest first.
final habitNotesProvider = Provider.autoDispose
    .family<AsyncValue<List<CheckIn>>, Habit>((ref, habit) {
  return ref.watch(habitCheckInsProvider(habit.id)).whenData((checkIns) {
    return checkIns
        .where((c) => c.note != null && c.note!.isNotEmpty)
        .take(5)
        .toList();
  });
});
