import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/database/app_database.dart';
import '../../../core/extensions/context_extensions.dart';
import '../../../core/providers/core_providers.dart';
import '../../../shared/models/habit_with_status.dart';
import '../../../shared/utils/streak_calculator.dart';
import '../../../shared/widgets/streak_badge.dart';
import '../../add_edit_habit/screens/add_edit_habit_sheet.dart';
import '../../checkin/widgets/checkin_sheet.dart';
import '../../habit_detail/screens/habit_detail_screen.dart';
import '../providers/habits_provider.dart';

class HabitCard extends ConsumerWidget {
  const HabitCard({super.key, required this.habitWithStatus});

  final HabitWithStatus habitWithStatus;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habit = habitWithStatus.habit;
    final checkInsAsync = ref.watch(habitCheckInsProvider(habit.id));

    // Auto-resume if pauseUntil has passed
    if (habit.isPaused &&
        habit.pauseUntil != null &&
        habit.pauseUntil!.isBefore(DateTime.now())) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(databaseProvider).habitsDao.resumeHabit(habit.id);
      });
    }

    final accentColor = habit.accentColor != null
        ? Color(habit.accentColor!)
        : Theme.of(context).colorScheme.primary;

    return checkInsAsync.when(
      data: (checkIns) {
        final completedDates =
            checkIns.where((c) => c.completed).map((c) => c.date).toList();
        final currentStreak = StreakCalculator.currentStreak(
          completedDates,
          habit.gracePeriodEnabled,
        );
        return _CardContent(
          habitWithStatus: habitWithStatus,
          currentStreak: currentStreak,
          accentColor: accentColor,
          onTap: habit.isPaused ? null : () => _openCheckin(context),
          onLongPress: () => _openOptions(context, ref),
        );
      },
      loading: () => _CardContent(
        habitWithStatus: habitWithStatus,
        currentStreak: 0,
        accentColor: accentColor,
        onTap: habit.isPaused ? null : () => _openCheckin(context),
        onLongPress: () => _openOptions(context, ref),
      ),
      error: (_, __) => const SizedBox.shrink(),
    );
  }

  void _openCheckin(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => CheckinSheet(habitWithStatus: habitWithStatus),
    );
  }

  void _openEdit(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => AddEditHabitSheet(existingHabit: habitWithStatus.habit),
    );
  }

  void _openOptions(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => _HabitOptionsSheet(
        habit: habitWithStatus.habit,
        onViewDetails: () {
          Navigator.of(ctx).pop();
          Navigator.of(context).push(MaterialPageRoute(
            builder: (_) =>
                HabitDetailScreen(habit: habitWithStatus.habit),
          ));
        },
        onEdit: () {
          Navigator.of(ctx).pop();
          _openEdit(context);
        },
        onPause: () {
          Navigator.of(ctx).pop();
          _openPausePicker(context, ref);
        },
        onResume: () {
          Navigator.of(ctx).pop();
          ref.read(databaseProvider).habitsDao.resumeHabit(habitWithStatus.habit.id);
        },
      ),
    );
  }

  void _openPausePicker(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => _PauseDurationSheet(
        onSelected: (pauseUntil) {
          Navigator.of(ctx).pop();
          ref.read(databaseProvider).habitsDao
              .pauseHabit(habitWithStatus.habit.id, pauseUntil);
        },
      ),
    );
  }
}

// ── Options sheet ─────────────────────────────────────────────────────────────

class _HabitOptionsSheet extends StatelessWidget {
  const _HabitOptionsSheet({
    required this.habit,
    required this.onViewDetails,
    required this.onEdit,
    required this.onPause,
    required this.onResume,
  });

  final Habit habit;
  final VoidCallback onViewDetails;
  final VoidCallback onEdit;
  final VoidCallback onPause;
  final VoidCallback onResume;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.outlineVariant,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              habit.name,
              style: Theme.of(context).textTheme.titleMedium,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.bar_chart_rounded),
            title: Text(l10n.viewDetails),
            onTap: onViewDetails,
          ),
          ListTile(
            leading: const Icon(Icons.edit_rounded),
            title: Text(l10n.editHabit),
            onTap: onEdit,
          ),
          if (habit.isPaused)
            ListTile(
              leading: Icon(Icons.play_arrow_rounded,
                  color: Theme.of(context).colorScheme.primary),
              title: Text(l10n.resumeHabit),
              onTap: onResume,
            )
          else
            ListTile(
              leading: const Icon(Icons.pause_rounded),
              title: Text(l10n.pauseHabit),
              onTap: onPause,
            ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

// ── Pause duration sheet ──────────────────────────────────────────────────────

class _PauseDurationSheet extends StatelessWidget {
  const _PauseDurationSheet({required this.onSelected});

  final ValueChanged<DateTime?> onSelected;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    final options = [
      (l10n.pauseTomorrow, today.add(const Duration(days: 1))),
      (l10n.pause3Days, today.add(const Duration(days: 3))),
      (l10n.pause1Week, today.add(const Duration(days: 7))),
      (l10n.pause2Weeks, today.add(const Duration(days: 14))),
      (l10n.pauseIndefinitely, null as DateTime?),
    ];

    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.outlineVariant,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              l10n.pauseDuration,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          const Divider(height: 1),
          ...options.map((opt) => ListTile(
                title: Text(opt.$1),
                subtitle: opt.$2 != null
                    ? Text(
                        'Until ${DateFormat('MMM d').format(opt.$2!)}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                      )
                    : null,
                onTap: () => onSelected(opt.$2),
              )),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

// ── Card content ──────────────────────────────────────────────────────────────

class _CardContent extends StatelessWidget {
  const _CardContent({
    required this.habitWithStatus,
    required this.currentStreak,
    required this.accentColor,
    required this.onTap,
    required this.onLongPress,
  });

  final HabitWithStatus habitWithStatus;
  final int currentStreak;
  final Color accentColor;
  final VoidCallback? onTap;
  final VoidCallback onLongPress;

  @override
  Widget build(BuildContext context) {
    final habit = habitWithStatus.habit;
    final isPaused = habit.isPaused;
    final isCompleted = habitWithStatus.isCompletedToday;
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    final effectiveAccent = isPaused ? scheme.outline : accentColor;

    return Opacity(
      opacity: isPaused ? 0.65 : 1.0,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          child: IntrinsicHeight(
            child: Row(
              children: [
                Container(width: 4, color: effectiveAccent),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                habit.name,
                                style: theme.textTheme.titleSmall?.copyWith(
                                  decoration: isCompleted
                                      ? TextDecoration.lineThrough
                                      : null,
                                  color: isCompleted || isPaused
                                      ? scheme.outline
                                      : null,
                                ),
                              ),
                            ),
                            if (isPaused) ...[
                              const SizedBox(width: 8),
                              _PausedBadge(habit: habit),
                            ] else if (currentStreak > 0) ...[
                              const SizedBox(width: 8),
                              StreakBadge(streak: currentStreak),
                            ],
                          ],
                        ),
                        if (isPaused && habit.pauseUntil != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            context.l10n.pausedUntil(
                              DateFormat('MMM d').format(habit.pauseUntil!),
                            ),
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: scheme.onSurfaceVariant,
                            ),
                          ),
                        ] else if (!habit.isOngoing &&
                            habitWithStatus.daysRemaining != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            context.l10n
                                .daysRemaining(habitWithStatus.daysRemaining!),
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: scheme.tertiary,
                            ),
                          ),
                        ],
                        if (!isPaused &&
                            habit.completionType != 'boolean' &&
                            habitWithStatus.todayValue != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            _valueText(
                              context,
                              habitWithStatus.todayValue!,
                              habit.completionType,
                              habit.unit,
                            ),
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: scheme.primary,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                // 3-dot menu button
                SizedBox(
                  width: 32,
                  child: IconButton(
                    icon: const Icon(Icons.more_vert, size: 18),
                    color: scheme.onSurfaceVariant,
                    padding: EdgeInsets.zero,
                    onPressed: onLongPress,
                    tooltip: 'Options',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: isPaused
                      ? const SizedBox.shrink()
                      : _CompletionControl(
                          habit: habit,
                          isCompleted: isCompleted,
                          accentColor: accentColor,
                          onTap: onTap ?? () {},
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _valueText(
      BuildContext context, double value, String type, String? unit) {
    if (type == 'duration') {
      final hours = (value / 60).floor();
      final mins = (value % 60).toInt();
      if (hours > 0) return 'Today: ${hours}h $mins${context.l10n.minutes}';
      return 'Today: $mins ${context.l10n.minutes}';
    }
    final display = value == value.truncate()
        ? value.toInt().toString()
        : value.toString();
    return 'Today: $display${unit != null ? ' $unit' : ''}';
  }
}

class _PausedBadge extends StatelessWidget {
  const _PausedBadge({required this.habit});
  final Habit habit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.pause_rounded,
              size: 12,
              color: Theme.of(context).colorScheme.onSurfaceVariant),
          const SizedBox(width: 3),
          Text(
            context.l10n.paused,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _CompletionControl extends StatelessWidget {
  const _CompletionControl({
    required this.habit,
    required this.isCompleted,
    required this.accentColor,
    required this.onTap,
  });

  final Habit habit;
  final bool isCompleted;
  final Color accentColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    if (habit.completionType == 'boolean') {
      return GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isCompleted ? accentColor : Colors.transparent,
            border: Border.all(
              color: isCompleted
                  ? accentColor
                  : Theme.of(context).colorScheme.outline,
              width: 2,
            ),
          ),
          child: isCompleted
              ? const Icon(Icons.check, size: 16, color: Colors.white)
              : null,
        ),
      );
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: isCompleted
              ? accentColor.withValues(alpha: 0.12)
              : Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          isCompleted ? Icons.edit_rounded : Icons.add_rounded,
          size: 18,
          color: isCompleted
              ? accentColor
              : Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
