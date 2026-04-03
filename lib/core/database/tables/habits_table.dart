import 'package:drift/drift.dart';

/// Drift table definition for habits.
/// completionType: 'boolean' | 'numeric' | 'duration'
class Habits extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get category => text().nullable()();
  TextColumn get completionType =>
      text().withDefault(const Constant('boolean'))();
  TextColumn get unit => text().nullable()(); // e.g. "glasses", "km"
  BoolColumn get isOngoing =>
      boolean().withDefault(const Constant(true))(); // false = goal-bound
  DateTimeColumn get targetDate => dateTime().nullable()();
  IntColumn get accentColor => integer().nullable()(); // ARGB int
  TextColumn get reminderTime => text().nullable()(); // "HH:mm"
  BoolColumn get gracePeriodEnabled =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get isPaused => boolean().withDefault(const Constant(false))();
  DateTimeColumn get pauseUntil => dateTime().nullable()();
  BoolColumn get isArchived =>
      boolean().withDefault(const Constant(false))();
  DateTimeColumn get archivedAt => dateTime().nullable()();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
}
