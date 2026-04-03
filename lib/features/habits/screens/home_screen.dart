import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/extensions/context_extensions.dart';
import '../../../shared/widgets/empty_state.dart';
import '../../add_edit_habit/screens/add_edit_habit_sheet.dart';
import '../../daily_intention/widgets/daily_intention_card.dart';
import '../../settings/screens/settings_screen.dart';
import '../providers/habits_provider.dart';
import '../widgets/category_section.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habitsAsync = ref.watch(habitsWithStatusProvider);
    final locale = Localizations.localeOf(context).languageCode;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.today,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            Text(
              DateFormat('EEEE, d MMMM', locale).format(DateTime.now()),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune_rounded),
            tooltip: context.l10n.settings,
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const SettingsScreen()),
            ),
          ),
        ],
        scrolledUnderElevation: 0,
      ),
      body: habitsAsync.when(
        data: (habits) {
          if (habits.isEmpty) {
            return Column(
              children: [
                const DailyIntentionCard(),
                Expanded(
                  child: EmptyState(
                    icon: Icons.add_task_rounded,
                    title: context.l10n.noHabitsTitle,
                    subtitle: context.l10n.noHabitsSubtitle,
                    action: FilledButton.icon(
                      onPressed: () => _openAddHabit(context),
                      icon: const Icon(Icons.add),
                      label: Text(context.l10n.addHabit),
                    ),
                  ),
                ),
              ],
            );
          }

          final grouped = groupByCategory(habits);
          final categories = grouped.keys.toList()
            ..sort((a, b) {
              if (a == null) return 1;
              if (b == null) return -1;
              return a.compareTo(b);
            });

          return ListView.builder(
            padding: const EdgeInsets.only(bottom: 96),
            itemCount: categories.length + 1,
            itemBuilder: (context, i) {
              if (i == 0) return const DailyIntentionCard();
              final category = categories[i - 1];
              return CategorySection(
                category: category,
                habits: grouped[category]!,
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openAddHabit(context),
        tooltip: context.l10n.addHabit,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _openAddHabit(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => const AddEditHabitSheet(),
    );
  }
}
