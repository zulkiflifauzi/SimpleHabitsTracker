import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/extensions/context_extensions.dart';
import '../../../shared/models/journal_entry.dart';
import '../../../shared/widgets/empty_state.dart';
import '../providers/journal_provider.dart';

class JournalScreen extends ConsumerWidget {
  const JournalScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final entriesAsync = ref.watch(journalProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.journal),
        scrolledUnderElevation: 0,
      ),
      body: entriesAsync.when(
        data: (entries) {
          if (entries.isEmpty) {
            return EmptyState(
              icon: Icons.menu_book_rounded,
              title: l10n.journalEmpty,
              subtitle: l10n.journalEmptySubtitle,
            );
          }

          // Group entries by date (date-only key)
          final grouped = <DateTime, List<JournalEntry>>{};
          for (final e in entries) {
            final day = DateTime(
                e.checkIn.date.year, e.checkIn.date.month, e.checkIn.date.day);
            (grouped[day] ??= []).add(e);
          }
          final dates = grouped.keys.toList()
            ..sort((a, b) => b.compareTo(a)); // newest first

          return ListView.builder(
            padding: const EdgeInsets.only(bottom: 32),
            itemCount: dates.length,
            itemBuilder: (context, i) {
              final date = dates[i];
              final dayEntries = grouped[date]!;
              return _DateSection(date: date, entries: dayEntries);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}

class _DateSection extends StatelessWidget {
  const _DateSection({required this.date, required this.entries});
  final DateTime date;
  final List<JournalEntry> entries;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    String dateLabel;
    if (date == today) {
      dateLabel = context.l10n.today;
    } else if (date == yesterday) {
      dateLabel = 'Yesterday';
    } else {
      dateLabel = DateFormat('EEEE, d MMMM yyyy').format(date);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
          child: Text(
            dateLabel,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
          ),
        ),
        ...entries.map((e) => _JournalCard(entry: e)),
      ],
    );
  }
}

class _JournalCard extends StatelessWidget {
  const _JournalCard({required this.entry});
  final JournalEntry entry;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final habit = entry.habit;
    final checkIn = entry.checkIn;

    final accentColor = habit.accentColor != null
        ? Color(habit.accentColor!)
        : scheme.primary;

    // Build the value/completion badge label
    String? badgeLabel;
    if (habit.completionType == 'boolean') {
      badgeLabel = checkIn.completed
          ? context.l10n.completedLabel
          : null; // don't show uncompleted
    } else if (checkIn.value != null) {
      final v = checkIn.value!;
      final display =
          v == v.truncate() ? v.toInt().toString() : v.toStringAsFixed(1);
      badgeLabel = habit.completionType == 'duration'
          ? '$display ${context.l10n.minutes}'
          : '$display${habit.unit != null ? ' ${habit.unit}' : ''}';
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Colour dot
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: accentColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      habit.name,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                  if (badgeLabel != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: accentColor.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        badgeLabel,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: accentColor,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                checkIn.note!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      height: 1.5,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                DateFormat('h:mm a').format(checkIn.createdAt),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
