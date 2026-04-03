import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/extensions/context_extensions.dart';
import '../../../features/habits/providers/habits_provider.dart';
import '../providers/stats_provider.dart';
import '../widgets/heatmap_widget.dart';
import '../widgets/monthly_chart.dart';
import '../widgets/weekly_chart.dart';
import 'journal_screen.dart';

class StatsScreen extends ConsumerWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final heatmapAsync = ref.watch(heatmapDataProvider);
    final weeklyAsync = ref.watch(weeklyChartProvider);
    final monthlyAsync = ref.watch(monthlyChartProvider);
    final summaryAsync = ref.watch(statsSummaryProvider);
    final habitsAsync = ref.watch(activeHabitsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.navStats),
        scrolledUnderElevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.menu_book_rounded),
            tooltip: l10n.journal,
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const JournalScreen()),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: [
          // ── Activity Heatmap ─────────────────────────────────────────
          _SectionHeader(l10n.statsActivity),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: heatmapAsync.when(
                data: (data) => data.isEmpty
                    ? _EmptyHeatmap(
                        title: l10n.statsNoActivity,
                        subtitle: l10n.statsNoActivitySubtitle,
                      )
                    : HeatmapWidget(data: data),
                loading: () =>
                    const Center(child: CircularProgressIndicator()),
                error: (e, _) => Text('Error: $e'),
              ),
            ),
          ),

          const SizedBox(height: 24),

          // ── This Week chart ──────────────────────────────────────────
          _SectionHeader(l10n.statsThisWeek),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 16, 16, 8),
              child: weeklyAsync.when(
                data: (data) => WeeklyBarChart(data: data),
                loading: () =>
                    const SizedBox(height: 180, child: Center(child: CircularProgressIndicator())),
                error: (e, _) => Text('Error: $e'),
              ),
            ),
          ),

          const SizedBox(height: 24),

          // ── Last 4 Weeks chart ───────────────────────────────────────
          _SectionHeader(l10n.statsThisMonth),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 16, 16, 8),
              child: monthlyAsync.when(
                data: (data) => MonthlyBarChart(data: data),
                loading: () =>
                    const SizedBox(height: 180, child: Center(child: CircularProgressIndicator())),
                error: (e, _) => Text('Error: $e'),
              ),
            ),
          ),

          const SizedBox(height: 24),

          // ── Summary ──────────────────────────────────────────────────
          _SectionHeader(l10n.statsSummary),
          const SizedBox(height: 12),
          summaryAsync.when(
            data: (summary) => Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _StatCard(
                        label: l10n.statsThisWeek,
                        value: '${summary.thisWeekCount}',
                        subtitle: l10n.statsCheckIns(summary.thisWeekCount),
                        icon: Icons.calendar_view_week_rounded,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _StatCard(
                        label: l10n.statsThisMonth,
                        value: '${summary.thisMonthCount}',
                        subtitle:
                            l10n.statsCheckIns(summary.thisMonthCount),
                        icon: Icons.calendar_month_rounded,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _StatCard(
                        label: l10n.statsAllTime,
                        value: '${summary.allTimeCount}',
                        subtitle:
                            l10n.statsCheckIns(summary.allTimeCount),
                        icon: Icons.insights_rounded,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: habitsAsync.when(
                        data: (habits) => _StatCard(
                          label: l10n.statsActiveHabits,
                          value: '${habits.length}',
                          subtitle: l10n.statsCheckIns(habits.length),
                          icon: Icons.check_circle_rounded,
                        ),
                        loading: () => const _StatCardSkeleton(),
                        error: (_, __) => const SizedBox.shrink(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Text('Error: $e'),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title.toUpperCase(),
      style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            letterSpacing: 1.2,
            fontWeight: FontWeight.w600,
          ),
    );
  }
}

class _EmptyHeatmap extends StatelessWidget {
  const _EmptyHeatmap({required this.title, required this.subtitle});
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        children: [
          Icon(Icons.grid_view_rounded,
              size: 48,
              color: Theme.of(context).colorScheme.onSurfaceVariant),
          const SizedBox(height: 12),
          Text(title,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center),
          const SizedBox(height: 4),
          Text(subtitle,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color:
                        Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.label,
    required this.value,
    required this.subtitle,
    required this.icon,
  });

  final String label;
  final String value;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: scheme.primary, size: 28),
            const SizedBox(height: 12),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: scheme.primary,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 2),
            Text(label,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    )),
            Text(subtitle,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: scheme.onSurfaceVariant,
                    )),
          ],
        ),
      ),
    );
  }
}

class _StatCardSkeleton extends StatelessWidget {
  const _StatCardSkeleton();

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
