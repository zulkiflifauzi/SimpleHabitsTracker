import 'dart:math';

/// Pure functions for computing habit streaks from a list of completed dates.
class StreakCalculator {
  StreakCalculator._();

  /// Current streak: consecutive completed days counting back from today.
  /// If today is not checked in, the streak still counts from yesterday
  /// (so checking in later today doesn't reset to 0).
  ///
  /// With [gracePeriodEnabled], one missed day is allowed without breaking
  /// the streak (grace is consumed at most once per streak run).
  static int currentStreak(
    List<DateTime> completedDates,
    bool gracePeriodEnabled,
  ) {
    if (completedDates.isEmpty) return 0;

    final today = _dateOnly(DateTime.now());
    final dateSet = completedDates.map(_dateOnly).toSet();

    int streak = 0;
    bool graceUsed = false;
    DateTime cursor = today;

    while (true) {
      if (dateSet.contains(cursor)) {
        streak++;
        graceUsed = false; // reset grace availability after a hit
        cursor = cursor.subtract(const Duration(days: 1));
      } else if (gracePeriodEnabled && !graceUsed && streak > 0) {
        // Skip one missed day; require the day before to be completed.
        graceUsed = true;
        cursor = cursor.subtract(const Duration(days: 1));
      } else {
        break;
      }
    }

    return streak;
  }

  /// Longest streak ever recorded in [completedDates].
  static int longestStreak(
    List<DateTime> completedDates,
    bool gracePeriodEnabled,
  ) {
    if (completedDates.isEmpty) return 0;

    final dates = completedDates.map(_dateOnly).toSet().toList()..sort();

    int maxStreak = 0;
    int current = 0;
    bool graceUsed = false;

    for (int i = 0; i < dates.length; i++) {
      if (i == 0) {
        current = 1;
        graceUsed = false;
      } else {
        final diff = dates[i].difference(dates[i - 1]).inDays;
        if (diff == 1) {
          current++;
          graceUsed = false;
        } else if (diff == 2 && gracePeriodEnabled && !graceUsed) {
          current++;
          graceUsed = true;
        } else {
          maxStreak = max(maxStreak, current);
          current = 1;
          graceUsed = false;
        }
      }
    }

    return max(maxStreak, current);
  }

  static DateTime _dateOnly(DateTime dt) =>
      DateTime(dt.year, dt.month, dt.day);
}
