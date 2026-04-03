import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/stats_provider.dart';

class WeeklyBarChart extends StatelessWidget {
  const WeeklyBarChart({super.key, required this.data});

  final List<DayCount> data;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final today = DateTime.now();
    final todayDate = DateTime(today.year, today.month, today.day);
    final maxY = (data.map((d) => d.count).fold(0, (a, b) => a > b ? a : b))
        .toDouble()
        .clamp(4.0, double.infinity);

    return SizedBox(
      height: 180,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: maxY + 1,
          barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
              getTooltipColor: (_) => scheme.inverseSurface,
              getTooltipItem: (group, _, rod, __) {
                final d = data[group.x];
                return BarTooltipItem(
                  '${DateFormat('MMM d').format(d.date)}\n${d.count} check-in${d.count == 1 ? '' : 's'}',
                  TextStyle(
                    color: scheme.onInverseSurface,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                );
              },
            ),
          ),
          titlesData: FlTitlesData(
            leftTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 28,
                getTitlesWidget: (value, meta) {
                  final d = data[value.toInt()];
                  final isToday = d.date == todayDate;
                  final label = DateFormat('E').format(d.date).substring(0, 1);
                  return SideTitleWidget(
                    axisSide: meta.axisSide,
                    child: Text(
                      label,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight:
                            isToday ? FontWeight.w700 : FontWeight.w400,
                        color: isToday
                            ? scheme.primary
                            : scheme.onSurfaceVariant,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: maxY > 8 ? (maxY / 4).ceilToDouble() : 2,
            getDrawingHorizontalLine: (value) => FlLine(
              color: scheme.outlineVariant.withValues(alpha: 0.5),
              strokeWidth: 1,
            ),
          ),
          barGroups: List.generate(data.length, (i) {
            final d = data[i];
            final isToday = d.date == todayDate;
            return BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                  toY: d.count.toDouble(),
                  color: d.count == 0
                      ? scheme.surfaceContainerHighest
                      : isToday
                          ? const Color(0xFFFF6B6B)
                          : const Color(0xFFFF8A80),
                  width: 28,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(8),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
