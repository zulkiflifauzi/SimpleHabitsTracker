import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/database/app_database.dart';
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
              return _ArchivedHabitTile(habit: habit, locale: locale);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}

class _ArchivedHabitTile extends ConsumerWidget {
  const _ArchivedHabitTile({required this.habit, required this.locale});

  final Habit habit;
  final String locale;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dao = ref.read(databaseProvider).habitsDao;
    final scheme = Theme.of(context).colorScheme;

    final archivedDateStr = habit.archivedAt != null
        ? context.l10n.completedOn(
            DateFormat('d MMM yyyy', locale).format(habit.archivedAt!),
          )
        : null;

    final subtitleParts = [
      if (habit.category != null) habit.category!,
      if (archivedDateStr != null) archivedDateStr,
    ];

    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      tileColor: scheme.surfaceContainerLow,
      leading: habit.accentColor != null
          ? CircleAvatar(
              backgroundColor: Color(habit.accentColor!),
              child: const Icon(Icons.check, color: Colors.white, size: 18),
            )
          : const CircleAvatar(
              child: Icon(Icons.archive, size: 18),
            ),
      title: Text(
        habit.name,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: subtitleParts.isNotEmpty
          ? Text(subtitleParts.join(' · '))
          : null,
      trailing: PopupMenuButton<_ArchiveAction>(
        icon: const Icon(Icons.more_vert),
        onSelected: (action) async {
          if (action == _ArchiveAction.restore) {
            await dao.unarchiveHabit(habit.id);
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(context.l10n.habitRestored(habit.name)),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          } else if (action == _ArchiveAction.delete) {
            final confirmed = await _confirmDelete(context, habit.name);
            if (confirmed == true) {
              await dao.deleteHabit(habit.id);
            }
          }
        },
        itemBuilder: (_) => [
          PopupMenuItem(
            value: _ArchiveAction.restore,
            child: ListTile(
              leading: const Icon(Icons.unarchive_outlined),
              title: Text(context.l10n.restoreHabit),
              contentPadding: EdgeInsets.zero,
            ),
          ),
          PopupMenuItem(
            value: _ArchiveAction.delete,
            child: ListTile(
              leading: Icon(Icons.delete_forever_outlined,
                  color: scheme.error),
              title: Text(context.l10n.deletePermanently,
                  style: TextStyle(color: scheme.error)),
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }

  Future<bool?> _confirmDelete(BuildContext context, String name) {
    return showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(context.l10n.deletePermanently),
        content: Text(context.l10n.deleteHabitConfirm(name)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(context.l10n.cancel),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(context.l10n.delete),
          ),
        ],
      ),
    );
  }
}

enum _ArchiveAction { restore, delete }
