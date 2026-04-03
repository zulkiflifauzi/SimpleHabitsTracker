import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/core_providers.dart';

const _kIntentionsKey = 'daily_intentions';

/// Returns today's date as a string key e.g. "2026-04-03".
String _todayKey() {
  final now = DateTime.now();
  return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
}

class DailyIntentionNotifier extends Notifier<String?> {
  static const _key = _kIntentionsKey;

  @override
  String? build() {
    final prefs = ref.read(sharedPreferencesProvider);
    final raw = prefs.getString(_key);
    if (raw == null) return null;
    final map = Map<String, String>.from(jsonDecode(raw) as Map);
    return map[_todayKey()];
  }

  Future<void> setIntention(String text) async {
    final prefs = ref.read(sharedPreferencesProvider);
    final raw = prefs.getString(_key);
    final map = raw != null
        ? Map<String, String>.from(jsonDecode(raw) as Map)
        : <String, String>{};
    map[_todayKey()] = text;
    await prefs.setString(_key, jsonEncode(map));
    state = text;
  }

  Future<void> clearIntention() async {
    final prefs = ref.read(sharedPreferencesProvider);
    final raw = prefs.getString(_key);
    if (raw == null) return;
    final map = Map<String, String>.from(jsonDecode(raw) as Map);
    map.remove(_todayKey());
    await prefs.setString(_key, jsonEncode(map));
    state = null;
  }
}

final dailyIntentionProvider =
    NotifierProvider<DailyIntentionNotifier, String?>(
  DailyIntentionNotifier.new,
);
