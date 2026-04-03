// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_ins_dao.dart';

// ignore_for_file: type=lint
mixin _$CheckInsDaoMixin on DatabaseAccessor<AppDatabase> {
  $HabitsTable get habits => attachedDatabase.habits;
  $CheckInsTable get checkIns => attachedDatabase.checkIns;
  CheckInsDaoManager get managers => CheckInsDaoManager(this);
}

class CheckInsDaoManager {
  final _$CheckInsDaoMixin _db;
  CheckInsDaoManager(this._db);
  $$HabitsTableTableManager get habits =>
      $$HabitsTableTableManager(_db.attachedDatabase, _db.habits);
  $$CheckInsTableTableManager get checkIns =>
      $$CheckInsTableTableManager(_db.attachedDatabase, _db.checkIns);
}
