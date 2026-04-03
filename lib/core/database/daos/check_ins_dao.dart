import 'package:drift/drift.dart';

import '../../../shared/models/journal_entry.dart';
import '../app_database.dart';
import '../tables/check_ins_table.dart';
import '../tables/habits_table.dart';

part 'check_ins_dao.g.dart';

@DriftAccessor(tables: [CheckIns, Habits])
class CheckInsDao extends DatabaseAccessor<AppDatabase>
    with _$CheckInsDaoMixin {
  CheckInsDao(super.db);

  static DateTime _dateOnly(DateTime dt) =>
      DateTime(dt.year, dt.month, dt.day);

  /// All check-ins for a habit, newest first.
  Stream<List<CheckIn>> watchCheckInsForHabit(int habitId) {
    return (select(checkIns)
          ..where((c) => c.habitId.equals(habitId))
          ..orderBy([(c) => OrderingTerm.desc(c.date)]))
        .watch();
  }

  Future<List<CheckIn>> getCheckInsForHabit(int habitId) {
    return (select(checkIns)
          ..where((c) => c.habitId.equals(habitId))
          ..orderBy([(c) => OrderingTerm.desc(c.date)]))
        .get();
  }

  /// Returns the check-in for [habitId] on [date] (ignores time component).
  Future<CheckIn?> getCheckInForDate(int habitId, DateTime date) {
    final d = _dateOnly(date);
    final next = d.add(const Duration(days: 1));
    return (select(checkIns)
          ..where(
            (c) =>
                c.habitId.equals(habitId) &
                c.date.isBiggerOrEqualValue(d) &
                c.date.isSmallerThanValue(next),
          ))
        .getSingleOrNull();
  }

  /// All check-ins for today across all habits.
  Stream<List<CheckIn>> watchTodayCheckIns() {
    final today = _dateOnly(DateTime.now());
    final tomorrow = today.add(const Duration(days: 1));
    return (select(checkIns)
          ..where(
            (c) =>
                c.date.isBiggerOrEqualValue(today) &
                c.date.isSmallerThanValue(tomorrow),
          ))
        .watch();
  }

  /// Insert or update check-in for the given habit + date.
  Future<void> upsertCheckIn(CheckInsCompanion entry) async {
    final date = entry.date.value;
    final habitId = entry.habitId.value;
    final existing = await getCheckInForDate(habitId, date);

    if (existing == null) {
      await into(checkIns).insert(entry);
    } else {
      await (update(checkIns)..where((c) => c.id.equals(existing.id)))
          .write(entry);
    }
  }

  /// All check-ins (any habit) whose date falls in [from, to).
  Future<List<CheckIn>> getCheckInsInRange(DateTime from, DateTime to) {
    return (select(checkIns)
          ..where(
            (c) =>
                c.date.isBiggerOrEqualValue(from) &
                c.date.isSmallerThanValue(to),
          )
          ..orderBy([(c) => OrderingTerm.asc(c.date)]))
        .get();
  }

  /// Stream of all check-ins that have a note, joined with their habit.
  /// Returns newest first. Emits on any DB change.
  Stream<List<JournalEntry>> watchJournalEntries() {
    final query = select(checkIns).join([
      innerJoin(habits, habits.id.equalsExp(checkIns.habitId)),
    ])
      ..where(checkIns.note.isNotNull())
      ..orderBy([OrderingTerm.desc(checkIns.date)]);

    return query.watch().map((rows) => rows
        .map((row) => JournalEntry(
              checkIn: row.readTable(checkIns),
              habit: row.readTable(habits),
            ))
        .where((e) => e.checkIn.note != null && e.checkIn.note!.isNotEmpty)
        .toList());
  }

  /// Live stream of check-ins in [from, to) — emits on every DB change.
  Stream<List<CheckIn>> watchCheckInsInRange(DateTime from, DateTime to) {
    return (select(checkIns)
          ..where(
            (c) =>
                c.date.isBiggerOrEqualValue(from) &
                c.date.isSmallerThanValue(to),
          )
          ..orderBy([(c) => OrderingTerm.asc(c.date)]))
        .watch();
  }

  Future<void> deleteCheckInsForHabit(int habitId) {
    return (delete(checkIns)..where((c) => c.habitId.equals(habitId))).go();
  }
}
