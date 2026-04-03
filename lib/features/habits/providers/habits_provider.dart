import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/providers/core_providers.dart';
import '../../../shared/models/habit_with_status.dart';
import '../../../shared/utils/streak_calculator.dart';

/// Stream of all active (non-archived) habits.
final activeHabitsProvider = StreamProvider<List<Habit>>((ref) {
  return ref.watch(databaseProvider).habitsDao.watchAllActiveHabits();
});

/// Stream of all check-ins for today.
final todayCheckInsProvider = StreamProvider<List<CheckIn>>((ref) {
  return ref.watch(databaseProvider).checkInsDao.watchTodayCheckIns();
});

/// Stream of all check-ins for a single habit (used for streak calculation).
final habitCheckInsProvider =
    StreamProvider.family<List<CheckIn>, int>((ref, habitId) {
  return ref
      .watch(databaseProvider)
      .checkInsDao
      .watchCheckInsForHabit(habitId);
});

/// Derived provider: merges active habits + today's check-ins into
/// [HabitWithStatus] objects. Streaks are computed per habit from
/// [habitCheckInsProvider].
///
/// Note: streaks are NOT included here (they require per-habit streams).
/// Use [habitCheckInsProvider] + [StreakCalculator] inside each HabitCard.
final habitsWithStatusProvider =
    Provider<AsyncValue<List<HabitWithStatus>>>((ref) {
  final habitsAsync = ref.watch(activeHabitsProvider);
  final checkInsAsync = ref.watch(todayCheckInsProvider);

  return habitsAsync.when(
    data: (habits) => checkInsAsync.when(
      data: (todayCheckIns) {
        final checkInMap = <int, CheckIn>{
          for (final ci in todayCheckIns) ci.habitId: ci,
        };
        final result = habits.map((habit) {
          return HabitWithStatus(
            habit: habit,
            todayCheckIn: checkInMap[habit.id],
            currentStreak: 0, // computed per-card via habitCheckInsProvider
            longestStreak: 0,
          );
        }).toList();
        return AsyncValue.data(result);
      },
      loading: () => const AsyncValue.loading(),
      error: AsyncValue.error,
    ),
    loading: () => const AsyncValue.loading(),
    error: AsyncValue.error,
  );
});

/// Groups a flat list of [HabitWithStatus] by category.
/// Habits with no category fall under the null key.
Map<String?, List<HabitWithStatus>> groupByCategory(
  List<HabitWithStatus> habits,
) {
  final map = <String?, List<HabitWithStatus>>{};
  for (final h in habits) {
    (map[h.habit.category] ??= []).add(h);
  }
  return map;
}
