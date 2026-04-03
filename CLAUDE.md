# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

---

## Overview

A clean, minimal, fully offline habit tracker for Android (iOS later). Built with Flutter/Dart. The core differentiator is **per-habit target dates** — habits are goal-bound commitments with an end date, not just open-ended streaks. An **Archive** acts as a trophy room for completed or retired habits.

---

## Commands

> **Flutter is not in bash PATH.** Run all commands via PowerShell:
> ```powershell
> powershell -Command "& { $env:PATH = [System.Environment]::GetEnvironmentVariable('PATH','Machine') + ';' + [System.Environment]::GetEnvironmentVariable('PATH','User'); cd 'D:\SideProject\HabitTrackerApp'; flutter <command> 2>&1 }"
> ```

```bash
# Run app on connected Android device
flutter run -d 11263193CE000745

# Run tests
flutter test

# Build release APK
flutter build apk --release

# Lint / analyze
flutter analyze

# Format code
dart format lib/

# Generate Drift database code (after modifying tables/DAOs)
dart run build_runner build --delete-conflicting-outputs

# Regenerate l10n files (after modifying ARB files)
flutter gen-l10n
```

---

## Tech Stack

| Layer | Package |
|---|---|
| Framework | Flutter (Dart) |
| Database | Drift (type-safe SQLite, EF Core-like API with streams) |
| State management | Riverpod (manual providers, no code gen) |
| Notifications | flutter_local_notifications |
| Auth | local_auth (biometrics / device PIN) |
| Persistence | shared_preferences (settings, onboarding state, daily intentions) |
| Localisation | flutter_localizations + ARB files (EN + ID) |
| Charts | fl_chart (v1.5+) |
| Home widget | home_widget |

UI follows **Material 3** conventions.

---

## Project Structure

Feature-first (modular monolith):

```
lib/
├── core/
│   ├── database/          # Drift tables, DAOs, AppDatabase class
│   ├── extensions/        # ContextX — context.l10n shorthand
│   ├── notifications/     # NotificationService, per-habit scheduling
│   ├── providers/         # databaseProvider, sharedPreferencesProvider
│   └── theme/             # AppTheme (light + dark)
├── features/
│   ├── auth/
│   │   ├── screens/       # AuthGate (lock screen with recovery)
│   │   └── services/      # AuthService wrapper around local_auth
│   ├── habits/            # Home/Today screen, habit card, category section
│   ├── add_edit_habit/    # Add/Edit bottom sheet (shared for create + edit)
│   ├── checkin/           # Check-in bottom sheet: log value + optional note
│   ├── daily_intention/   # Daily intention card + sheet (stored in SharedPreferences)
│   ├── habit_detail/      # Habit detail screen: stats, history calendar, badges, notes
│   ├── onboarding/        # First-run: language picker + security setup
│   ├── settings/
│   │   ├── providers/     # settingsProvider (AppSettings: locale, auth, onboarding)
│   │   └── screens/       # Settings screen (language + biometric toggle)
│   ├── shell/             # MainShell — bottom nav (Archive | Today | Stats)
│   ├── stats/             # Stats tab (stub, v1.5)
│   └── archive/           # Archive tab: completed and retired habits
└── shared/
    ├── models/            # HabitWithStatus, HabitBadge
    ├── utils/             # StreakCalculator, BadgeCalculator
    └── widgets/           # StreakBadge, EmptyState
lib/l10n/                  # ARB files + generated AppLocalizations
```

---

## Architecture

**Data layer** — Drift tables (`Habits`, `CheckIns`) with DAOs that expose streams. Streams flow directly into Riverpod providers so the UI rebuilds reactively on any DB change. DAOs are the repository — no extra abstraction layer.

**Settings layer** — `SharedPreferences` is loaded in `main()` before `runApp()` and injected via `sharedPreferencesProvider.overrideWithValue(prefs)`. `settingsProvider` (a `Notifier`) reads from it synchronously in `build()` and persists on every mutation.

**Auth layer** — `AuthGate` wraps `MainShell`. When auth is enabled, it shows a lock screen and calls `AuthService.authenticate()`. On `AuthResult.notAvailable` (device has no lock screen), auth is auto-disabled so the user is never locked out. After 2+ failures, a recovery option appears to disable auth.

**Theme** — `AppSettings.themeMode` (`ThemeMode.system/light/dark`) persisted in SharedPreferences under key `theme_mode`. `app.dart` passes it directly to `MaterialApp.themeMode`. Toggle is a `DropdownButton` in Settings → Appearance section.

**App routing** — `app.dart` watches `settingsProvider` and routes reactively:
- `onboardingComplete == false` → `OnboardingScreen`
- `authEnabled == true` → `AuthGate` (wraps `MainShell`)
- otherwise → `MainShell`

`MainShell` lives in `features/shell/` (not `app.dart`) to avoid a circular import with `AuthGate`.

**Localisation** — `context.l10n` shorthand via `ContextX` extension. ARB files in `lib/l10n/`. Run `flutter gen-l10n` after any ARB change. Import: `import '../../l10n/app_localizations.dart'` (relative, not `flutter_gen` package).

**Notifications** — `NotificationService` in `core/notifications/` handles per-habit daily scheduling via `flutter_local_notifications`. Fully offline, no internet required.

**Daily Intention** — One intention string per day, stored in SharedPreferences as a JSON map keyed by `"YYYY-MM-DD"`. `dailyIntentionProvider` (a `Notifier<String?>`) reads/writes it synchronously. Displayed as a card at the top of the Today screen; tapping opens `IntentionSheet` (bottom sheet). No Drift table — SharedPreferences is the right fit for one value per day. Note: adding a new Drift table requires `dart run build_runner build --delete-conflicting-outputs`; drift_dev 2.32.1 has a bug parsing new table files that doesn't affect existing cached tables.

**Milestone Badges** — Computed on-the-fly from `longestStreak` and `totalCompletions` in `BadgeCalculator`. No DB table. Displayed in the habit detail screen between Stats and History. 8 badges: First Step (1 completion), Week Warrior (7-day streak), Fortnight (14-day), Monthly Master (30-day), Century Streak (100-day), Year of Habit (365-day), Dedicated (50 completions), Century Club (100 completions).

**Archive** — Archived habits can be restored (moved back to active) or deleted permanently via a ⋮ menu on each tile. `unarchiveHabit()` and `deleteHabit()` already existed in `HabitsDao`.

---

## Android Notes

- `MainActivity` must extend `FlutterFragmentActivity` (not `FlutterActivity`) — required by `local_auth`'s `BiometricPrompt`.
- `minSdk = 23` in `android/app/build.gradle.kts` — Android Studio's linter may revert this to `flutter.minSdkVersion`; restore it if it happens.
- Core library desugaring: `com.android.tools:desugar_jdk_libs:2.0.3` — required by `flutter_local_notifications`.
- Permissions in `AndroidManifest.xml`: `USE_BIOMETRIC`, `USE_FINGERPRINT`, `POST_NOTIFICATIONS`, `SCHEDULE_EXACT_ALARM`, `RECEIVE_BOOT_COMPLETED`.

---

## Database Schema

### Habits table

| Column | Type | Notes |
|---|---|---|
| id | int PK autoincrement | |
| name | text | |
| category | text nullable | e.g. Health, Work, Personal |
| completionType | text | `"boolean"` / `"numeric"` / `"duration"` |
| unit | text nullable | Unit label for numeric type |
| isOngoing | bool | true = ongoing, false = goal-bound |
| targetDate | datetime nullable | null when isOngoing = true |
| accentColor | int nullable | ARGB int |
| reminderTime | text nullable | `"HH:mm"` format |
| gracePeriodEnabled | bool | default false |
| isPaused | bool | default false |
| pauseUntil | datetime nullable | |
| isArchived | bool | default false |
| archivedAt | datetime nullable | |
| createdAt | datetime | |

### CheckIns table

| Column | Type | Notes |
|---|---|---|
| id | int PK autoincrement | |
| habitId | int FK → Habits.id | |
| date | datetime | Date only (no time component) |
| completed | bool | |
| value | real nullable | For numeric/duration types |
| note | text nullable | Optional one-liner journal note |
| createdAt | datetime | |

---

## Habit Modes & Completion Types

**Modes** (set at creation, switchable):
- **Goal-bound** — has a `targetDate`. Shows countdown on card. Auto-archives on target date.
- **Ongoing** — no target date. Manually retired to Archive by user.

**Completion types** (set at creation):
- **Boolean** — checkbox
- **Numeric** — user logs a number + unit
- **Duration** — user logs minutes

Streaks and check-ins work identically for both modes.

---

## Roadmap Scope

- **v1.0** — Habit creation, Home/Today screen, notifications, categories, home screen widget, streak tracking, grace period, **biometric/PIN lock screen**, **multilanguage (English + Bahasa Indonesia)**, **onboarding (language + security setup)**, **Settings screen**
- **v1.5** — Heatmap, weekly/monthly charts, journal notes, pause habit, habit detail screen, **dark/light/system theme toggle**
- **v2.0** — ~~Milestone badges~~ ✓, ~~Archive restore/delete~~ ✓, ~~Daily Intention screen~~ ✓, ~~per-habit accent color~~ ✓ (shipped in v1.5)

**Out of scope:** social features, AI coaching, cloud sync, gamification points.
