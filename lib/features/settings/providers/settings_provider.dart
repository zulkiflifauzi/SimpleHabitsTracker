import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/core_providers.dart';

class AppSettings {
  const AppSettings({
    this.locale = const Locale('en'),
    this.authEnabled = false,
    this.onboardingComplete = false,
    this.themeMode = ThemeMode.system,
  });

  final Locale locale;
  final bool authEnabled;
  final bool onboardingComplete;
  final ThemeMode themeMode;

  AppSettings copyWith({
    Locale? locale,
    bool? authEnabled,
    bool? onboardingComplete,
    ThemeMode? themeMode,
  }) =>
      AppSettings(
        locale: locale ?? this.locale,
        authEnabled: authEnabled ?? this.authEnabled,
        onboardingComplete: onboardingComplete ?? this.onboardingComplete,
        themeMode: themeMode ?? this.themeMode,
      );
}

class SettingsNotifier extends Notifier<AppSettings> {
  static const _keyLocale = 'locale';
  static const _keyAuth = 'auth_enabled';
  static const _keyOnboarding = 'onboarding_complete';
  static const _keyTheme = 'theme_mode';

  @override
  AppSettings build() {
    final prefs = ref.read(sharedPreferencesProvider);
    return AppSettings(
      locale: Locale(prefs.getString(_keyLocale) ?? 'en'),
      authEnabled: prefs.getBool(_keyAuth) ?? false,
      onboardingComplete: prefs.getBool(_keyOnboarding) ?? false,
      themeMode: _parseThemeMode(prefs.getString(_keyTheme)),
    );
  }

  static ThemeMode _parseThemeMode(String? value) {
    switch (value) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  Future<void> setLocale(Locale locale) async {
    await ref.read(sharedPreferencesProvider).setString(_keyLocale, locale.languageCode);
    state = state.copyWith(locale: locale);
  }

  Future<void> setAuthEnabled(bool enabled) async {
    await ref.read(sharedPreferencesProvider).setBool(_keyAuth, enabled);
    state = state.copyWith(authEnabled: enabled);
  }

  Future<void> completeOnboarding() async {
    await ref.read(sharedPreferencesProvider).setBool(_keyOnboarding, true);
    state = state.copyWith(onboardingComplete: true);
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    final value = mode == ThemeMode.light
        ? 'light'
        : mode == ThemeMode.dark
            ? 'dark'
            : 'system';
    await ref.read(sharedPreferencesProvider).setString(_keyTheme, value);
    state = state.copyWith(themeMode: mode);
  }
}

final settingsProvider = NotifierProvider<SettingsNotifier, AppSettings>(
  SettingsNotifier.new,
);
