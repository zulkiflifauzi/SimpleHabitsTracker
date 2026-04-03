import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/database/app_database.dart';
import '../../../core/extensions/context_extensions.dart';
import '../../../l10n/app_localizations.dart';
import '../../../shared/models/habit_badge.dart';
import '../../checkin/widgets/checkin_sheet.dart';
import '../../habits/providers/habits_provider.dart';
import '../../habits/widgets/habit_card.dart';
import '../providers/habit_detail_provider.dart';
import '../widgets/history_calendar.dart';

class HabitDetailScreen extends ConsumerWidget {
  const HabitDetailScreen({super.key, required this.habit});

  final Habit habit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;

    final accentColor =
        habit.accentColor != null ? Color(habit.accentColor!) : scheme.primary;

    final statsAsync = ref.watch(habitDetailStatsProvider(habit));
    final historyAsync = ref.watch(habitHistoryProvider(habit));
    final notesAsync = ref.watch(habitNotesProvider(habit));
    final badgesAsync = ref.watch(habitBadgesProvider(habit));

    // Watch today's check-in for the FAB state
    final habitsAsync = ref.watch(habitsWithStatusProvider);
    final habitWithStatus = habitsAsync.whenData((list) {
      try {
        return list.firstWhere((h) => h.habit.id == habit.id);
      } catch (_) {
        return null;
      }
    }).valueOrNull;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // ── Collapsing app bar ──────────────────────────────────────
          SliverAppBar(
            expandedHeight: 140,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding:
                  const EdgeInsets.only(left: 56, bottom: 14, right: 16),
              title: Text(
                habit.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      accentColor.withValues(alpha: 0.8),
                      accentColor.withValues(alpha: 0.4),
                    ],
                  ),
                ),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 60, right: 20),
                    child: habit.category != null
                        ? Chip(
                            label: Text(habit.category!),
                            backgroundColor:
                                Colors.white.withValues(alpha: 0.25),
                            labelStyle: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                            side: BorderSide.none,
                          )
                        : null,
                  ),
                ),
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // ── Stats row ─────────────────────────────────────────
                _SectionHeader(l10n.detailStats),
                const SizedBox(height: 12),
                statsAsync.when(
                  data: (stats) => Row(
                    children: [
                      Expanded(
                        child: _StatCard(
                          icon: Icons.local_fire_department_rounded,
                          iconColor: const Color(0xFFFF6B6B),
                          value: '${stats.currentStreak}',
                          label: l10n.detailCurrentStreak,
                          sub: l10n.days(stats.currentStreak),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _StatCard(
                          icon: Icons.emoji_events_rounded,
                          iconColor: const Color(0xFFFFB347),
                          value: '${stats.longestStreak}',
                          label: l10n.detailLongestStreak,
                          sub: l10n.days(stats.longestStreak),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _StatCard(
                          icon: Icons.check_circle_rounded,
                          iconColor: const Color(0xFF66BB6A),
                          value: '${stats.totalCompletions}',
                          label: l10n.detailTotal,
                          sub: l10n.days(stats.totalCompletions),
                        ),
                      ),
                    ],
                  ),
                  loading: () => const SizedBox(
                      height: 80,
                      child: Center(child: CircularProgressIndicator())),
                  error: (e, _) => Text('Error: $e'),
                ),

                const SizedBox(height: 24),

                // ── Badges ────────────────────────────────────────────
                _SectionHeader(l10n.detailBadges),
                const SizedBox(height: 12),
                badgesAsync.when(
                  data: (badges) => _BadgesGrid(badges: badges),
                  loading: () => const SizedBox(
                      height: 60,
                      child: Center(child: CircularProgressIndicator())),
                  error: (e, _) => Text('Error: $e'),
                ),

                const SizedBox(height: 24),

                // ── History calendar ──────────────────────────────────
                _SectionHeader(l10n.detailHistory),
                const SizedBox(height: 12),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: historyAsync.when(
                      data: (history) => HistoryCalendar(history: history),
                      loading: () => const SizedBox(
                          height: 100,
                          child: Center(child: CircularProgressIndicator())),
                      error: (e, _) => Text('Error: $e'),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // ── Recent notes ──────────────────────────────────────
                _SectionHeader(l10n.detailRecentNotes),
                const SizedBox(height: 12),
                notesAsync.when(
                  data: (notes) => notes.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            l10n.detailNoNotes,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    color: scheme.onSurfaceVariant),
                          ),
                        )
                      : Column(
                          children: notes
                              .map((ci) => _NoteCard(checkIn: ci, accentColor: accentColor))
                              .toList(),
                        ),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Text('Error: $e'),
                ),
              ]),
            ),
          ),
        ],
      ),

      // ── Check-in FAB ───────────────────────────────────────────────
      floatingActionButton: habitWithStatus != null && !habit.isPaused
          ? FloatingActionButton.extended(
              onPressed: () => showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                useSafeArea: true,
                builder: (_) =>
                    CheckinSheet(habitWithStatus: habitWithStatus!),
              ),
              icon: Icon(habitWithStatus!.isCompletedToday
                  ? Icons.edit_rounded
                  : Icons.check_rounded),
              label: Text(habitWithStatus!.isCompletedToday
                  ? context.l10n.editHabit
                  : context.l10n.logForToday),
            )
          : null,
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

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.iconColor,
    required this.value,
    required this.label,
    required this.sub,
  });

  final IconData icon;
  final Color iconColor;
  final String value;
  final String label;
  final String sub;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: iconColor, size: 22),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

// Returns (label, description) for a badge type using l10n.
(String, String) _badgeStrings(AppLocalizations l10n, BadgeType type) {
  switch (type) {
    case BadgeType.firstStep:
      return (l10n.badgeFirstStep, l10n.badgeFirstStepDesc);
    case BadgeType.weekWarrior:
      return (l10n.badgeWeekWarrior, l10n.badgeWeekWarriorDesc);
    case BadgeType.fortnight:
      return (l10n.badgeFortnight, l10n.badgeFortnightDesc);
    case BadgeType.monthlyMaster:
      return (l10n.badgeMonthlyMaster, l10n.badgeMonthlyMasterDesc);
    case BadgeType.centuryStreak:
      return (l10n.badgeCenturyStreak, l10n.badgeCenturyStreakDesc);
    case BadgeType.yearOfHabit:
      return (l10n.badgeYearOfHabit, l10n.badgeYearOfHabitDesc);
    case BadgeType.dedicated:
      return (l10n.badgeDedicated, l10n.badgeDedicatedDesc);
    case BadgeType.centuryClub:
      return (l10n.badgeCenturyClub, l10n.badgeCenturyClubDesc);
  }
}

class _BadgesGrid extends StatelessWidget {
  const _BadgesGrid({required this.badges});

  final List<HabitBadge> badges;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: badges.map((badge) {
        final (label, desc) = _badgeStrings(l10n, badge.type);
        return Tooltip(
          message: desc,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: badge.earned ? 1.0 : 0.3,
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                ScaffoldMessenger.of(context)
                  ..clearSnackBars()
                  ..showSnackBar(SnackBar(
                    content: Text(
                      badge.earned
                          ? '${badge.emoji} $label — $desc'
                          : '🔒 $label — $desc',
                    ),
                    behavior: SnackBarBehavior.floating,
                    width: 300,
                    duration: const Duration(seconds: 2),
                  ));
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: badge.earned
                      ? scheme.primaryContainer
                      : scheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(12),
                  border: badge.earned
                      ? Border.all(
                          color: scheme.primary.withValues(alpha: 0.4),
                          width: 1,
                        )
                      : null,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(badge.emoji, style: const TextStyle(fontSize: 18)),
                    const SizedBox(width: 6),
                    Text(
                      label,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: badge.earned
                                ? scheme.onPrimaryContainer
                                : scheme.onSurfaceVariant,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _NoteCard extends StatelessWidget {
  const _NoteCard({required this.checkIn, required this.accentColor});

  final CheckIn checkIn;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                checkIn.note!,
                style:
                    Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.5),
              ),
              const SizedBox(height: 8),
              Text(
                DateFormat('MMM d, yyyy · h:mm a').format(checkIn.createdAt),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
