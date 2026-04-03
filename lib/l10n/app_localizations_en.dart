// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Simple Habits Tracker';

  @override
  String get navToday => 'Today';

  @override
  String get navArchive => 'Archive';

  @override
  String get navStats => 'Stats';

  @override
  String get today => 'Today';

  @override
  String todayDate(String date) {
    return 'Today, $date';
  }

  @override
  String get noHabitsTitle => 'No habits yet';

  @override
  String get noHabitsSubtitle => 'Tap the + button to create your first habit.';

  @override
  String get addHabit => 'Add habit';

  @override
  String get newHabit => 'New Habit';

  @override
  String get editHabit => 'Edit Habit';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get next => 'Next';

  @override
  String get skip => 'Skip';

  @override
  String get getStarted => 'Get started';

  @override
  String get done => 'Done';

  @override
  String get habitName => 'Habit name';

  @override
  String get habitNameHint => 'e.g. Run 30 minutes';

  @override
  String get habitNameRequired => 'Name is required';

  @override
  String get category => 'Category';

  @override
  String get categoryHealth => 'Health';

  @override
  String get categoryWork => 'Work';

  @override
  String get categoryPersonal => 'Personal';

  @override
  String get categoryFinance => 'Finance';

  @override
  String get categoryLearning => 'Learning';

  @override
  String get categorySocial => 'Social';

  @override
  String get categoryOther => 'Other';

  @override
  String get howTrack => 'How do you track it?';

  @override
  String get trackDone => 'Done / Not done';

  @override
  String get trackCount => 'Count';

  @override
  String get trackDuration => 'Duration';

  @override
  String get unit => 'Unit (optional)';

  @override
  String get unitHint => 'e.g. glasses, km, pages';

  @override
  String get mode => 'Mode';

  @override
  String get modeOngoing => 'Ongoing';

  @override
  String get modeGoalBound => 'Goal-bound';

  @override
  String get modeOngoingDesc => 'Open-ended — retire manually when done.';

  @override
  String get modeGoalBoundDesc => 'Has a target end date.';

  @override
  String get setTargetDate => 'Set target date';

  @override
  String targetDateLabel(String date) {
    return 'Target: $date';
  }

  @override
  String get dailyReminder => 'Daily reminder';

  @override
  String get noReminder => 'No reminder';

  @override
  String get gracePeriod => 'Grace period';

  @override
  String get gracePeriodDesc => 'Miss one day without breaking your streak.';

  @override
  String get color => 'Color';

  @override
  String get viewDetails => 'View details';

  @override
  String get detailStats => 'Stats';

  @override
  String get detailHistory => 'Last 5 Weeks';

  @override
  String get detailRecentNotes => 'Recent Notes';

  @override
  String get detailCurrentStreak => 'Current Streak';

  @override
  String get detailLongestStreak => 'Longest Streak';

  @override
  String get detailTotal => 'All Time';

  @override
  String get detailThisMonth => 'This Month';

  @override
  String get detailNoNotes => 'No notes for this habit yet.';

  @override
  String days(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count days',
      one: '1 day',
    );
    return '$_temp0';
  }

  @override
  String get pauseHabit => 'Pause habit';

  @override
  String get resumeHabit => 'Resume habit';

  @override
  String get paused => 'Paused';

  @override
  String pausedUntil(String date) {
    return 'Paused until $date';
  }

  @override
  String get pauseDuration => 'Pause for how long?';

  @override
  String get pauseTomorrow => 'Tomorrow';

  @override
  String get pause3Days => '3 days';

  @override
  String get pause1Week => '1 week';

  @override
  String get pause2Weeks => '2 weeks';

  @override
  String get pauseIndefinitely => 'Indefinitely';

  @override
  String get archiveHabit => 'Archive habit';

  @override
  String get archiveHabitBody =>
      'This habit will be moved to the Archive. You can view it there any time.';

  @override
  String get setTargetDateFirst => 'Please set a target date.';

  @override
  String get logForToday => 'Log for today';

  @override
  String get noteOptional => 'Note (optional)';

  @override
  String get noteHint => 'How did it go?';

  @override
  String get markAsDone => 'Mark as done';

  @override
  String get completedLabel => 'Completed!';

  @override
  String get invalidValue => 'Please enter a valid value.';

  @override
  String get amount => 'Amount';

  @override
  String get durationLabel => 'Duration';

  @override
  String get minutes => 'minutes';

  @override
  String daysRemaining(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days days remaining',
      one: '1 day remaining',
      zero: 'Target reached today!',
    );
    return '$_temp0';
  }

  @override
  String get noArchivedHabits => 'No archived habits';

  @override
  String get noArchivedHabitsSubtitle =>
      'Completed goal-bound habits and retired ongoing habits will appear here.';

  @override
  String completedOn(String date) {
    return 'Completed $date';
  }

  @override
  String get statsComingSoon => 'Stats coming in v1.5';

  @override
  String get statsComingSoonSubtitle =>
      'Heatmaps, weekly summaries, and completion charts will be here.';

  @override
  String get journal => 'Journal';

  @override
  String get journalEmpty => 'No notes yet';

  @override
  String get journalEmptySubtitle =>
      'Add a note when checking in a habit to start your journal.';

  @override
  String get statsActivity => 'Activity';

  @override
  String get statsSummary => 'Summary';

  @override
  String get statsThisWeek => 'This Week';

  @override
  String get statsThisMonth => 'This Month';

  @override
  String get statsAllTime => 'All Time';

  @override
  String statsCheckIns(int count) {
    return '$count check-ins';
  }

  @override
  String get statsActiveHabits => 'Active Habits';

  @override
  String get statsNoActivity => 'No activity yet';

  @override
  String get statsNoActivitySubtitle =>
      'Complete habits to see your progress here.';

  @override
  String get settings => 'Settings';

  @override
  String get language => 'Language';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageBahasa => 'Bahasa Indonesia';

  @override
  String get appearance => 'Appearance';

  @override
  String get themeMode => 'Theme';

  @override
  String get themeModeSystem => 'System default';

  @override
  String get themeModeLight => 'Light';

  @override
  String get themeModeDark => 'Dark';

  @override
  String get security => 'Security';

  @override
  String get biometricLock => 'Biometric / PIN lock';

  @override
  String get biometricLockDesc =>
      'Require authentication when opening the app.';

  @override
  String get biometricNotAvailable =>
      'Biometric authentication is not available on this device.';

  @override
  String get biometricEnableFirst => 'Authentication failed. Lock not enabled.';

  @override
  String get authenticateReason =>
      'Authenticate to unlock Simple Habits Tracker';

  @override
  String get unlock => 'Unlock';

  @override
  String get authFailed => 'Authentication failed. Please try again.';

  @override
  String get welcomeTitle => 'Welcome to\nSimple Habits Tracker';

  @override
  String get welcomeSubtitle => 'Build better habits, one day at a time.';

  @override
  String get chooseLanguage => 'Choose your language';

  @override
  String get chooseLanguageSubtitle => 'You can change this later in Settings.';

  @override
  String get setupSecurity => 'Secure your app';

  @override
  String get setupSecurityDesc =>
      'Enable biometric or PIN lock to protect your habits. You can change this in Settings.';

  @override
  String get enableLock => 'Enable lock';

  @override
  String get disableAuthRecovery => 'Having trouble? Disable authentication';

  @override
  String get disableAuthTitle => 'Disable authentication';

  @override
  String get disableAuthBody =>
      'This will turn off the lock screen. You can re-enable it in Settings.';

  @override
  String get disableAuthConfirm => 'Disable';

  @override
  String get restoreHabit => 'Restore habit';

  @override
  String get deletePermanently => 'Delete permanently';

  @override
  String deleteHabitConfirm(String name) {
    return 'Delete \"$name\" permanently? This cannot be undone.';
  }

  @override
  String habitRestored(String name) {
    return '\"$name\" restored to active habits.';
  }
}
