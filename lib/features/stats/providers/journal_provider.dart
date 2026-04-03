import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/core_providers.dart';
import '../../../shared/models/journal_entry.dart';

final journalProvider = StreamProvider.autoDispose<List<JournalEntry>>((ref) {
  return ref.watch(databaseProvider).checkInsDao.watchJournalEntries();
});
