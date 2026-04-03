import 'package:flutter/material.dart';
import 'l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/theme/app_theme.dart';
import 'features/auth/screens/auth_gate.dart';
import 'features/onboarding/screens/onboarding_screen.dart';
import 'features/settings/providers/settings_provider.dart';
import 'features/shell/main_shell.dart';

class HabitTrackerApp extends ConsumerWidget {
  const HabitTrackerApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);

    return MaterialApp(
      title: 'Simple Habits Tracker',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: settings.themeMode,
      locale: settings.locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: _resolveHome(settings),
      debugShowCheckedModeBanner: false,
    );
  }

  Widget _resolveHome(AppSettings settings) {
    if (!settings.onboardingComplete) return const OnboardingScreen();
    if (settings.authEnabled) return const AuthGate();
    return const MainShell();
  }
}
