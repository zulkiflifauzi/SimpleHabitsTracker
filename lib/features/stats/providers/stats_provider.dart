import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/providers/core_providers.dart';

const _kNumWeeks = 17;

/// The Monday that starts the heatmap range (17 weeks back from current week).
DateTime heatmapStartDate() {
  final today = DateTime.now();
  final todayDate = DateTime(today.year, today.month, today.day);
  final daysFromMonday = (today.weekday - 1) % 7;
  final currentWeekMonday = todayDate.subtract(Duration(days: daysFromMonday));
  return currentWeekMonday.subtract(const Duration(days: 7 * (_kNumWeeks - 1)));
}

/// Live stream of check-ins for the stats window (last 17 weeks).
/// Re-emits automatically whenever any check-in is added or updated.
final statsCheckInsProvider = StreamProvider.autoDispose<List<CheckIn>>((ref) {
  final db = ref.watch(databaseProvider);
  final from = heatmapStartDate();
  final to = DateTime.now().add(const Duration(days: 1));
  return db.checkInsDao.watchCheckInsInRange(from, to);
});

/// Maps each date → number of completed check-ins that day.
/// Only includes dates with at least one completion.
final heatmapDataProvider =
    Provider.autoDispose<AsyncValue<Map<DateTime, int>>>((ref) {
  return ref.watch(statsCheckInsProvider).whenData((checkIns) {
    final map = <DateTime, int>{};
    for (final ci in checkIns) {
      if (!ci.completed) continue;
      final day = DateTime(ci.date.year, ci.date.month, ci.date.day);
      map[day] = (map[day] ?? 0) + 1;
    }
    return map;
  });
});

// ── Chart data models ────────────────────────────────────────────────────────

class DayCount {
  const DayCount(this.date, this.count);
  final DateTime date;
  final int count;
}

class WeekCount {
  const WeekCount(this.weekStart, this.count);
  final DateTime weekStart;
  final int count;
}

bool _sameDay(DateTime a, DateTime b) =>
    a.year == b.year && a.month == b.month && a.day == b.day;

/// Completions per day for the last 7 days (oldest → newest).
final weeklyChartProvider =
    Provider.autoDispose<AsyncValue<List<DayCount>>>((ref) {
  return ref.watch(statsCheckInsProvider).whenData((checkIns) {
    final today = DateTime.now();
    final todayDate = DateTime(today.year, today.month, today.day);
    return List.generate(7, (i) {
      final day = todayDate.subtract(Duration(days: 6 - i));
      final count =
          checkIns.where((ci) => ci.completed && _sameDay(ci.date, day)).length;
      return DayCount(day, count);
    });
  });
});

/// Completions per week for the last 4 weeks (oldest → newest).
/// Each "week" is a 7-day block ending on today, today-7, today-14, today-21.
final monthlyChartProvider =
    Provider.autoDispose<AsyncValue<List<WeekCount>>>((ref) {
  return ref.watch(statsCheckInsProvider).whenData((checkIns) {
    final today = DateTime.now();
    final todayDate = DateTime(today.year, today.month, today.day);
    return List.generate(4, (i) {
      final blockEnd = todayDate.subtract(Duration(days: 7 * (3 - i)));
      final blockStart = blockEnd.subtract(const Duration(days: 6));
      final count = checkIns.where((ci) {
        if (!ci.completed) return false;
        final d = DateTime(ci.date.year, ci.date.month, ci.date.day);
        return !d.isBefore(blockStart) && !d.isAfter(blockEnd);
      }).length;
      return WeekCount(blockStart, count);
    });
  });
});

// ── Summary ──────────────────────────────────────────────────────────────────

class StatsSummary {
  const StatsSummary({
    required this.thisWeekCount,
    required this.thisMonthCount,
    required this.allTimeCount,
  });
  final int thisWeekCount;
  final int thisMonthCount;
  final int allTimeCount;
}

final statsSummaryProvider =
    Provider.autoDispose<AsyncValue<StatsSummary>>((ref) {
  return ref.watch(statsCheckInsProvider).whenData((checkIns) {
    final now = DateTime.now();
    final daysFromMonday = (now.weekday - 1) % 7;
    final weekStart = DateTime(now.year, now.month, now.day)
        .subtract(Duration(days: daysFromMonday));
    final monthStart = DateTime(now.year, now.month, 1);

    int thisWeek = 0, thisMonth = 0, allTime = 0;
    for (final ci in checkIns) {
      if (!ci.completed) continue;
      allTime++;
      final d = DateTime(ci.date.year, ci.date.month, ci.date.day);
      if (!d.isBefore(weekStart)) thisWeek++;
      if (!d.isBefore(monthStart)) thisMonth++;
    }
    return StatsSummary(
      thisWeekCount: thisWeek,
      thisMonthCount: thisMonth,
      allTimeCount: allTime,
    );
  });
});
