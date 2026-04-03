import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/extensions/context_extensions.dart';
import '../../../core/providers/core_providers.dart';
import '../../../shared/widgets/empty_state.dart';

final _archivedHabitsProvider = StreamProvider((ref) {
  return ref.watch(databaseProvider).habitsDao.watchArchivedHabits();
});

class ArchiveScreen extends ConsumerWidget {
  const ArchiveScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habitsAsync = ref.watch(_archivedHabitsProvider);
    final locale = Localizations.localeOf(context).languageCode;

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.navArchive),
        scrolledUnderElevation: 0,
      ),
      body: habitsAsync.when(
        data: (habits) {
          if (habits.isEmpty) {
            return EmptyState(
              icon: Icons.archive_outlined,
              title: context.l10n.noArchivedHabits,
              subtitle: context.l10n.noArchivedHabitsSubtitle,
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: habits.length,
            separatorBuilder: (_, __) => const SizedBox(height: 4),
            itemBuilder: (context, i) {
              final habit = habits[i];
              return ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                tileColor:
                    Theme.of(context).colorScheme.surfaceContainerLow,
                leading: habit.accentColor != null
                    ? CircleAvatar(
                        backgroundColor: Color(habit.accentColor!),
                        child: const Icon(Icons.check,
                            color: Colors.white, size: 18),
                      )
                    : const CircleAvatar(
                        child: Icon(Icons.archive, size: 18),
                      ),
                title: Text(
                  habit.name,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: habit.archivedAt != null
                    ? Text(
                        context.l10n.completedOn(
                          DateFormat('d MMM yyyy', locale)
                              .format(habit.archivedAt!),
                        ),
                      )
                    : null,
                trailing: habit.category != null
                    ? Chip(
                        label: Text(habit.category!),
                        materialTapTargetSize:
                            MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.compact,
                      )
                    : null,
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
