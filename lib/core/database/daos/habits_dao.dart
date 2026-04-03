import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/check_ins_table.dart';
import '../tables/habits_table.dart';

part 'habits_dao.g.dart';

@DriftAccessor(tables: [Habits, CheckIns])
class HabitsDao extends DatabaseAccessor<AppDatabase> with _$HabitsDaoMixin {
  HabitsDao(super.db);

  /// Stream of all non-archived habits ordered by creation date.
  Stream<List<Habit>> watchAllActiveHabits() {
    return (select(habits)
          ..where((h) => h.isArchived.equals(false))
          ..orderBy([(h) => OrderingTerm.asc(h.createdAt)]))
        .watch();
  }

  /// Stream of archived habits ordered by archive date (newest first).
  Stream<List<Habit>> watchArchivedHabits() {
    return (select(habits)
          ..where((h) => h.isArchived.equals(true))
          ..orderBy([(h) => OrderingTerm.desc(h.archivedAt)]))
        .watch();
  }

  Future<Habit?> getHabitById(int id) {
    return (select(habits)..where((h) => h.id.equals(id))).getSingleOrNull();
  }

  Future<int> insertHabit(HabitsCompanion entry) =>
      into(habits).insert(entry);

  Future<bool> updateHabit(HabitsCompanion entry) =>
      update(habits).replace(entry);

  Future<int> deleteHabit(int id) =>
      (delete(habits)..where((h) => h.id.equals(id))).go();

  Future<void> archiveHabit(int id) {
    return (update(habits)..where((h) => h.id.equals(id))).write(
      HabitsCompanion(
        isArchived: const Value(true),
        archivedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> unarchiveHabit(int id) {
    return (update(habits)..where((h) => h.id.equals(id))).write(
      const HabitsCompanion(
        isArchived: Value(false),
        archivedAt: Value(null),
      ),
    );
  }

  /// Pause a habit. [pauseUntil] is null for an indefinite pause.
  Future<void> pauseHabit(int id, DateTime? pauseUntil) {
    return (update(habits)..where((h) => h.id.equals(id))).write(
      HabitsCompanion(
        isPaused: const Value(true),
        pauseUntil: Value(pauseUntil),
      ),
    );
  }

  Future<void> resumeHabit(int id) {
    return (update(habits)..where((h) => h.id.equals(id))).write(
      const HabitsCompanion(
        isPaused: Value(false),
        pauseUntil: Value(null),
      ),
    );
  }
}
