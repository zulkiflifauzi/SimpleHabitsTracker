import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// 5-week (35-day) completion grid for a single habit.
/// Columns = weeks (oldest left), rows = days Mon–Sun.
class HistoryCalendar extends StatelessWidget {
  const HistoryCalendar({super.key, required this.history});

  /// date → completed?  (only past/today dates needed)
  final Map<DateTime, bool> history;

  static const _cellSize = 32.0;
  static const _gap = 5.0;
  static const _weeks = 5;

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final todayDate = DateTime(today.year, today.month, today.day);

    // Start on the Monday 4 full weeks before the current week's Monday
    final daysFromMonday = (today.weekday - 1) % 7;
    final currentWeekMonday =
        todayDate.subtract(Duration(days: daysFromMonday));
    final startMonday =
        currentWeekMonday.subtract(const Duration(days: 7 * (_weeks - 1)));

    final scheme = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme.labelSmall!.copyWith(
          fontSize: 10,
          color: scheme.onSurfaceVariant,
        );

    const dayLabels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Month labels
        _buildMonthRow(startMonday, textStyle),
        const SizedBox(height: 4),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Day-of-week labels
            Column(
              children: dayLabels
                  .map((l) => SizedBox(
                        width: 14,
                        height: _cellSize + _gap,
                        child: Center(
                          child: Text(l, style: textStyle),
                        ),
                      ))
                  .toList(),
            ),
            const SizedBox(width: 6),
            // Week columns
            ...List.generate(_weeks, (wi) {
              final weekStart =
                  startMonday.add(Duration(days: 7 * wi));
              return Padding(
                padding: const EdgeInsets.only(right: _gap),
                child: Column(
                  children: List.generate(7, (di) {
                    final date =
                        weekStart.add(Duration(days: di));
                    return Padding(
                      padding: const EdgeInsets.only(bottom: _gap),
                      child: _DayCell(
                        date: date,
                        todayDate: todayDate,
                        completed: history[date],
                        scheme: scheme,
                      ),
                    );
                  }),
                ),
              );
            }),
          ],
        ),
        const SizedBox(height: 8),
        // Legend
        Row(
          children: [
            _legendCell(scheme.surfaceContainerHighest),
            const SizedBox(width: 4),
            Text('Missed', style: textStyle),
            const SizedBox(width: 12),
            _legendCell(const Color(0xFFFF6B6B)),
            const SizedBox(width: 4),
            Text('Completed', style: textStyle),
          ],
        ),
      ],
    );
  }

  Widget _buildMonthRow(DateTime startMonday, TextStyle textStyle) {
    String? last;
    final cells = <Widget>[const SizedBox(width: 14 + 6)];
    for (int w = 0; w < _weeks; w++) {
      final ws = startMonday.add(Duration(days: 7 * w));
      final label = DateFormat('MMM').format(ws);
      cells.add(SizedBox(
        width: _cellSize + _gap,
        child: label != last
            ? Text(label, style: textStyle, overflow: TextOverflow.visible)
            : null,
      ));
      last = label;
    }
    return Row(children: cells);
  }

  Widget _legendCell(Color color) => Container(
        width: 14,
        height: 14,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(4),
        ),
      );
}

class _DayCell extends StatelessWidget {
  const _DayCell({
    required this.date,
    required this.todayDate,
    required this.completed,
    required this.scheme,
  });

  final DateTime date;
  final DateTime todayDate;
  final bool? completed; // null = no record / future
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    final isFuture = date.isAfter(todayDate);
    final isToday = date == todayDate;

    Color bg;
    if (isFuture) {
      bg = scheme.surfaceContainerHighest.withValues(alpha: 0.3);
    } else if (completed == true) {
      bg = const Color(0xFFFF6B6B);
    } else if (completed == false) {
      bg = scheme.errorContainer.withValues(alpha: 0.4);
    } else {
      // No record yet for today or past day before habit existed
      bg = scheme.surfaceContainerHighest;
    }

    return Tooltip(
      message: isFuture
          ? ''
          : completed == true
              ? 'Completed · ${DateFormat('MMM d').format(date)}'
              : 'Missed · ${DateFormat('MMM d').format(date)}',
      child: Container(
        width: HistoryCalendar._cellSize,
        height: HistoryCalendar._cellSize,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(8),
          border: isToday
              ? Border.all(color: scheme.primary, width: 2)
              : null,
        ),
        child: completed == true
            ? Icon(Icons.check_rounded,
                size: 16,
                color: Colors.white.withValues(alpha: 0.9))
            : null,
      ),
    );
  }
}
