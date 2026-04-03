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
  String get help => 'Help';

  @override
  String get userGuide => 'User Guide';

  @override
  String get userGuideSubtitle => 'Learn how to use Simple Habits Tracker';

  @override
  String get guideGettingStartedTitle => 'Getting Started';

  @override
  String get guideGettingStartedBody =>
      'Simple Habits Tracker helps you build better habits one day at a time.\n\nWhen you first open the app, you will be guided through a short setup:\n• Choose your preferred language\n• Optionally enable biometric or PIN lock to protect your data\n\nOnce setup is complete, you land on the Today screen where all your habits live.';

  @override
  String get guideTodayScreenTitle => 'Today Screen';

  @override
  String get guideTodayScreenBody =>
      'The Today screen is your daily dashboard.\n\n• Habits are grouped by category\n• Each card shows the habit name, streak, and today\'s check-in status\n• Tap the check button on a card to log a quick completion\n• Tap the card itself to open the check-in sheet and add a value or note\n• Tap ⋮ on a card for more options: View Details, Edit, Pause\n• The Daily Intention card at the top lets you set a focus for the day\n• Tap + (bottom right) to add a new habit';

  @override
  String get guideAddingHabitTitle => 'Adding a Habit';

  @override
  String get guideAddingHabitBody =>
      'Tap the + button on the Today screen to create a new habit.\n\nYou will be asked to set:\n• Name — what the habit is called\n• Category — Health, Work, Personal, Finance, Learning, Social, or Other\n• Tracking type:\n  - Done/Not done — simple checkbox\n  - Count — log a number (e.g. glasses of water)\n  - Duration — log minutes\n• Mode:\n  - Ongoing — no end date, retire manually when done\n  - Goal-bound — set a target end date; auto-archives when reached\n• Daily reminder — optional notification time\n• Grace period — allows one missed day without breaking your streak\n• Colour — pick an accent colour for the habit card';

  @override
  String get guideCheckInTitle => 'Checking In';

  @override
  String get guideCheckInBody =>
      'To log today\'s progress, tap the check button on a habit card or tap the card to open the check-in sheet.\n\n• For Done/Not done habits, tap once to mark complete\n• For Count habits, enter the amount and unit\n• For Duration habits, enter the number of minutes\n• Add an optional note — it will appear in your Journal\n\nYou can re-open the sheet to edit today\'s entry at any time.';

  @override
  String get guideStreaksTitle => 'Streaks & Grace Period';

  @override
  String get guideStreaksBody =>
      'A streak counts how many consecutive days you have completed a habit.\n\n• Your current streak is shown on each habit card with a 🔥 icon\n• If you miss today, your streak still counts from yesterday — checking in later today will not reset it\n• Grace Period: if enabled, you are allowed to miss one day without breaking your streak. The grace period can only be used once per streak run.\n• The longest streak you have ever achieved is shown on the habit detail screen';

  @override
  String get guidePauseTitle => 'Pausing a Habit';

  @override
  String get guidePauseBody =>
      'Sometimes life gets in the way. You can pause a habit so it does not count against your streak.\n\nTo pause, tap ⋮ on a habit card and choose Pause habit. Then select how long:\n• Tomorrow\n• 3 days\n• 1 week\n• 2 weeks\n• Indefinitely\n\nPaused habits are shown with a ⏸ badge and reduced opacity. They resume automatically when the pause period ends, or you can resume them manually at any time via the ⋮ menu.';

  @override
  String get guideIntentionTitle => 'Daily Intention';

  @override
  String get guideIntentionBody =>
      'The Daily Intention card sits at the top of the Today screen. Use it to set a short focus or goal for the day.\n\n• Tap the card to open the intention sheet\n• Type your intention and tap Save\n• Your intention is shown on the card for the rest of the day\n• Tap the card again to edit or clear it\n• The intention resets automatically each new day';

  @override
  String get guideDetailBadgesTitle => 'Habit Detail & Badges';

  @override
  String get guideDetailBadgesBody =>
      'Tap ⋮ on a habit card and choose View Details to open the habit detail screen.\n\nYou will see:\n• Stats — current streak, longest streak, total completions\n• Badges — 8 milestone badges earned from your progress:\n  🌱 First Step (1 completion)\n  🔥 Week Warrior (7-day streak)\n  ⚡ Fortnight (14-day streak)\n  💪 Monthly Master (30-day streak)\n  🏆 Century Streak (100-day streak)\n  👑 Year of Habit (365-day streak)\n  ⭐ Dedicated (50 completions)\n  🌟 Century Club (100 completions)\n• 5-week history calendar\n• Recent notes from your check-ins\n\nEarned badges are highlighted; unearned ones are greyed out. Tap any badge to see what is needed to earn it.';

  @override
  String get guideStatsTitle => 'Stats & Journal';

  @override
  String get guideStatsBody =>
      'The Stats tab (bottom navigation, right) shows your overall activity.\n\n• Activity heatmap — 17 weeks of check-in data; today is highlighted and the view scrolls to the current week automatically. Tap any cell to see the count for that day.\n• This Week — bar chart of the last 7 days\n• Last 4 Weeks — bar chart of weekly completions\n• Summary cards — active habits, total check-ins this week, this month, and all time\n\nTap the 📖 icon in the Stats app bar to open the Journal, which shows all your check-in notes grouped by date.';

  @override
  String get guideArchiveTitle => 'Archive';

  @override
  String get guideArchiveBody =>
      'The Archive tab (bottom navigation, left) is a record of completed and retired habits.\n\nHabits move to the Archive when:\n• A goal-bound habit reaches its target date\n• You manually retire an ongoing habit\n\nFrom the Archive you can:\n• Tap ⋮ on any habit → Restore to move it back to active habits\n• Tap ⋮ → Delete permanently to remove it forever (this cannot be undone)';

  @override
  String get guideSettingsTitle => 'Settings';

  @override
  String get guideSettingsBody =>
      'Access Settings by tapping the 🎛 icon in the Today screen app bar.\n\n• Language — switch between English and Bahasa Indonesia\n• Theme — choose Light, Dark, or follow the system setting\n• Biometric / PIN lock — when enabled, the app requires authentication every time it is opened. If your device does not support biometrics, this option will be disabled automatically.';

  @override
  String get intentionTitle => 'Today\'s Intention';

  @override
  String get intentionHint => 'What do you want to focus on today?';

  @override
  String get intentionPlaceholder => 'Set your intention for today…';

  @override
  String get intentionSave => 'Save';

  @override
  String get intentionClear => 'Clear';

  @override
  String get intentionEmpty => 'No intention set';

  @override
  String get detailBadges => 'Badges';

  @override
  String get badgeFirstStep => 'First Step';

  @override
  String get badgeFirstStepDesc => 'Complete your first check-in';

  @override
  String get badgeWeekWarrior => 'Week Warrior';

  @override
  String get badgeWeekWarriorDesc => 'Reach a 7-day streak';

  @override
  String get badgeFortnight => 'Fortnight';

  @override
  String get badgeFortnightDesc => 'Reach a 14-day streak';

  @override
  String get badgeMonthlyMaster => 'Monthly Master';

  @override
  String get badgeMonthlyMasterDesc => 'Reach a 30-day streak';

  @override
  String get badgeCenturyStreak => 'Century Streak';

  @override
  String get badgeCenturyStreakDesc => 'Reach a 100-day streak';

  @override
  String get badgeYearOfHabit => 'Year of Habit';

  @override
  String get badgeYearOfHabitDesc => 'Reach a 365-day streak';

  @override
  String get badgeDedicated => 'Dedicated';

  @override
  String get badgeDedicatedDesc => 'Complete 50 check-ins';

  @override
  String get badgeCenturyClub => 'Century Club';

  @override
  String get badgeCenturyClubDesc => 'Complete 100 check-ins';

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
