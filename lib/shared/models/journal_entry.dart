import '../../core/database/app_database.dart';

class JournalEntry {
  const JournalEntry({required this.checkIn, required this.habit});
  final CheckIn checkIn;
  final Habit habit;
}
