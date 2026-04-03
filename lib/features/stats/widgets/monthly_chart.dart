import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/stats_provider.dart';

class MonthlyBarChart extends StatelessWidget {
  const MonthlyBarChart({super.key, required this.data});

  final List<WeekCount> data;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
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
                final weekEnd =
                    d.weekStart.add(const Duration(days: 6));
                final label =
                    '${DateFormat('MMM d').format(d.weekStart)} – ${DateFormat('MMM d').format(weekEnd)}';
                return BarTooltipItem(
                  '$label\n${d.count} check-in${d.count == 1 ? '' : 's'}',
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
                  final label = DateFormat('MMM d').format(d.weekStart);
                  return SideTitleWidget(
                    axisSide: meta.axisSide,
                    child: Text(
                      label,
                      style: TextStyle(
                        fontSize: 11,
                        color: scheme.onSurfaceVariant,
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
            // Most recent week is darkest
            final opacity = 0.5 + (i / (data.length - 1)) * 0.5;
            return BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                  toY: d.count.toDouble(),
                  color: d.count == 0
                      ? scheme.surfaceContainerHighest
                      : Color.fromRGBO(255, 107, 107, opacity),
                  width: 48,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(10),
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
