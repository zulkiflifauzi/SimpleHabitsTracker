import 'package:drift/drift.dart';

import 'habits_table.dart';

class CheckIns extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get habitId =>
      integer().references(Habits, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get date => dateTime()(); // store as date-only (strip time in DAO)
  BoolColumn get completed =>
      boolean().withDefault(const Constant(false))();
  RealColumn get value => real().nullable()(); // numeric / duration value
  TextColumn get note => text().nullable()(); // optional journal note
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
}
