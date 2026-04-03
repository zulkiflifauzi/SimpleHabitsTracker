import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/stats_provider.dart';

const _kNumWeeks = 17;
const _cellSize = 14.0;
const _gap = 3.0;
// Fixed bottom space in every column — today's dot lives here.
const _indicatorH = 10.0;

class HeatmapWidget extends StatefulWidget {
  const HeatmapWidget({super.key, required this.data});

  final Map<DateTime, int> data;

  @override
  State<HeatmapWidget> createState() => _HeatmapWidgetState();
}

class _HeatmapWidgetState extends State<HeatmapWidget> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final todayDate = DateTime(today.year, today.month, today.day);
    final startMonday = heatmapStartDate();
    final scheme = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context)
        .textTheme
        .labelSmall!
        .copyWith(fontSize: 9, color: scheme.onSurfaceVariant);

    return SingleChildScrollView(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _MonthLabels(startMonday: startMonday, textStyle: textStyle),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _DayLabels(textStyle: textStyle),
              const SizedBox(width: 4),
              ...List.generate(_kNumWeeks, (weekIndex) {
                final weekStart =
                    startMonday.add(Duration(days: 7 * weekIndex));
                return _WeekColumn(
                  weekStart: weekStart,
                  todayDate: todayDate,
                  data: widget.data,
                  scheme: scheme,
                );
              }),
            ],
          ),
          const SizedBox(height: 8),
          _Legend(scheme: scheme, textStyle: textStyle),
        ],
      ),
    );
  }
}

class _MonthLabels extends StatelessWidget {
  const _MonthLabels({required this.startMonday, required this.textStyle});
  final DateTime startMonday;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    String? lastLabel;
    final cells = <Widget>[
      const SizedBox(width: 16 + 4),
    ];
    for (int w = 0; w < _kNumWeeks; w++) {
      final weekStart = startMonday.add(Duration(days: 7 * w));
      final label = DateFormat('MMM').format(weekStart);
      final show = label != lastLabel;
      cells.add(SizedBox(
        width: _cellSize + _gap,
        child: show
            ? Text(label, style: textStyle, overflow: TextOverflow.visible)
            : null,
      ));
      if (show) lastLabel = label;
    }
    return Row(children: cells);
  }
}

class _DayLabels extends StatelessWidget {
  const _DayLabels({required this.textStyle});
  final TextStyle textStyle;

  static const _labels = ['M', '', 'W', '', 'F', '', ''];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ..._labels.map((l) => SizedBox(
              width: 12,
              height: _cellSize + _gap,
              child: Text(l, style: textStyle),
            )),
        // Space matching the today-indicator row
        SizedBox(height: _indicatorH),
      ],
    );
  }
}

class _WeekColumn extends StatelessWidget {
  const _WeekColumn({
    required this.weekStart,
    required this.todayDate,
    required this.data,
    required this.scheme,
  });

  final DateTime weekStart;
  final DateTime todayDate;
  final Map<DateTime, int> data;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    // Check if today falls in this week column
    final todayInThisWeek = !todayDate.isBefore(weekStart) &&
        todayDate.isBefore(weekStart.add(const Duration(days: 7)));

    return Padding(
      padding: const EdgeInsets.only(right: _gap),
      child: Column(
        children: [
          ...List.generate(7, (dayIndex) {
            final date = weekStart.add(Duration(days: dayIndex));
            return _Cell(
              date: date,
              todayDate: todayDate,
              count: data[date] ?? 0,
              scheme: scheme,
            );
          }),
          // Today dot indicator (same height in every column for alignment)
          SizedBox(
            height: _indicatorH,
            width: _cellSize,
            child: todayInThisWeek
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 4,
                          height: 4,
                          decoration: BoxDecoration(
                            color: scheme.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                  )
                : null,
          ),
        ],
      ),
    );
  }
}

class _Cell extends StatelessWidget {
  const _Cell({
    required this.date,
    required this.todayDate,
    required this.count,
    required this.scheme,
  });

  final DateTime date;
  final DateTime todayDate;
  final int count;
  final ColorScheme scheme;

  Color _cellColor() {
    if (date.isAfter(todayDate)) {
      return scheme.surfaceContainerHighest.withValues(alpha: 0.3);
    }
    if (count == 0) return scheme.surfaceContainerHighest;
    if (count == 1) return const Color(0xFFFFCDD2);
    if (count <= 3) return const Color(0xFFFF8A80);
    return const Color(0xFFFF6B6B);
  }

  @override
  Widget build(BuildContext context) {
    final isToday = date == todayDate;
    final isFuture = date.isAfter(todayDate);

    return GestureDetector(
      onTap: isFuture
          ? null
          : () {
              final dateStr = DateFormat('MMM d').format(date);
              final msg = count > 0
                  ? '$dateStr · $count check-in${count == 1 ? '' : 's'}'
                  : '$dateStr · No check-ins';
              ScaffoldMessenger.of(context)
                ..clearSnackBars()
                ..showSnackBar(SnackBar(
                  content: Text(msg),
                  duration: const Duration(seconds: 2),
                  behavior: SnackBarBehavior.floating,
                  width: 220,
                ));
            },
      child: Padding(
        padding: const EdgeInsets.only(bottom: _gap),
        child: Container(
          width: _cellSize,
          height: _cellSize,
          decoration: BoxDecoration(
            color: _cellColor(),
            borderRadius: BorderRadius.circular(3),
            border: isToday
                ? Border.all(color: scheme.primary, width: 2)
                : null,
            boxShadow: isToday
                ? [
                    BoxShadow(
                      color: scheme.primary.withValues(alpha: 0.4),
                      blurRadius: 4,
                      spreadRadius: 1,
                    )
                  ]
                : null,
          ),
        ),
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  const _Legend({required this.scheme, required this.textStyle});
  final ColorScheme scheme;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Less', style: textStyle),
        const SizedBox(width: 4),
        _legendCell(scheme.surfaceContainerHighest),
        const SizedBox(width: 3),
        _legendCell(const Color(0xFFFFCDD2)),
        const SizedBox(width: 3),
        _legendCell(const Color(0xFFFF8A80)),
        const SizedBox(width: 3),
        _legendCell(const Color(0xFFFF6B6B)),
        const SizedBox(width: 4),
        Text('More', style: textStyle),
      ],
    );
  }

  Widget _legendCell(Color color) => Container(
        width: _cellSize,
        height: _cellSize,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(3),
        ),
      );
}
