import '../../core/database/app_database.dart';

/// Combines a [Habit] with its today check-in and computed streaks.
/// Built in the provider layer so the UI never touches the DB directly.
class HabitWithStatus {
  const HabitWithStatus({
    required this.habit,
    required this.currentStreak,
    required this.longestStreak,
    this.todayCheckIn,
  });

  final Habit habit;
  final CheckIn? todayCheckIn;
  final int currentStreak;
  final int longestStreak;

  bool get isCompletedToday => todayCheckIn?.completed == true;
  double? get todayValue => todayCheckIn?.value;

  /// Days remaining until target date. Null if ongoing or no target.
  int? get daysRemaining {
    if (habit.isOngoing || habit.targetDate == null) return null;
    final today = DateTime.now();
    final target = habit.targetDate!;
    final diff = DateTime(target.year, target.month, target.day)
        .difference(DateTime(today.year, today.month, today.day))
        .inDays;
    return diff < 0 ? 0 : diff;
  }
}
