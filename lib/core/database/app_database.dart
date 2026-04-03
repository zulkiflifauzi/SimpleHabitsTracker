import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'daos/check_ins_dao.dart';
import 'daos/habits_dao.dart';
import 'tables/check_ins_table.dart';
import 'tables/habits_table.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [Habits, CheckIns],
  daos: [HabitsDao, CheckInsDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) => m.createAll(),
      );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbDir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbDir.path, 'habits.db'));
    return NativeDatabase.createInBackground(file);
  });
}
