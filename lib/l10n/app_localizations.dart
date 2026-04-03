import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_id.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('id')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Simple Habits Tracker'**
  String get appTitle;

  /// No description provided for @navToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get navToday;

  /// No description provided for @navArchive.
  ///
  /// In en, this message translates to:
  /// **'Archive'**
  String get navArchive;

  /// No description provided for @navStats.
  ///
  /// In en, this message translates to:
  /// **'Stats'**
  String get navStats;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @todayDate.
  ///
  /// In en, this message translates to:
  /// **'Today, {date}'**
  String todayDate(String date);

  /// No description provided for @noHabitsTitle.
  ///
  /// In en, this message translates to:
  /// **'No habits yet'**
  String get noHabitsTitle;

  /// No description provided for @noHabitsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Tap the + button to create your first habit.'**
  String get noHabitsSubtitle;

  /// No description provided for @addHabit.
  ///
  /// In en, this message translates to:
  /// **'Add habit'**
  String get addHabit;

  /// No description provided for @newHabit.
  ///
  /// In en, this message translates to:
  /// **'New Habit'**
  String get newHabit;

  /// No description provided for @editHabit.
  ///
  /// In en, this message translates to:
  /// **'Edit Habit'**
  String get editHabit;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get started'**
  String get getStarted;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @habitName.
  ///
  /// In en, this message translates to:
  /// **'Habit name'**
  String get habitName;

  /// No description provided for @habitNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Run 30 minutes'**
  String get habitNameHint;

  /// No description provided for @habitNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get habitNameRequired;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @categoryHealth.
  ///
  /// In en, this message translates to:
  /// **'Health'**
  String get categoryHealth;

  /// No description provided for @categoryWork.
  ///
  /// In en, this message translates to:
  /// **'Work'**
  String get categoryWork;

  /// No description provided for @categoryPersonal.
  ///
  /// In en, this message translates to:
  /// **'Personal'**
  String get categoryPersonal;

  /// No description provided for @categoryFinance.
  ///
  /// In en, this message translates to:
  /// **'Finance'**
  String get categoryFinance;

  /// No description provided for @categoryLearning.
  ///
  /// In en, this message translates to:
  /// **'Learning'**
  String get categoryLearning;

  /// No description provided for @categorySocial.
  ///
  /// In en, this message translates to:
  /// **'Social'**
  String get categorySocial;

  /// No description provided for @categoryOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get categoryOther;

  /// No description provided for @howTrack.
  ///
  /// In en, this message translates to:
  /// **'How do you track it?'**
  String get howTrack;

  /// No description provided for @trackDone.
  ///
  /// In en, this message translates to:
  /// **'Done / Not done'**
  String get trackDone;

  /// No description provided for @trackCount.
  ///
  /// In en, this message translates to:
  /// **'Count'**
  String get trackCount;

  /// No description provided for @trackDuration.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get trackDuration;

  /// No description provided for @unit.
  ///
  /// In en, this message translates to:
  /// **'Unit (optional)'**
  String get unit;

  /// No description provided for @unitHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. glasses, km, pages'**
  String get unitHint;

  /// No description provided for @mode.
  ///
  /// In en, this message translates to:
  /// **'Mode'**
  String get mode;

  /// No description provided for @modeOngoing.
  ///
  /// In en, this message translates to:
  /// **'Ongoing'**
  String get modeOngoing;

  /// No description provided for @modeGoalBound.
  ///
  /// In en, this message translates to:
  /// **'Goal-bound'**
  String get modeGoalBound;

  /// No description provided for @modeOngoingDesc.
  ///
  /// In en, this message translates to:
  /// **'Open-ended — retire manually when done.'**
  String get modeOngoingDesc;

  /// No description provided for @modeGoalBoundDesc.
  ///
  /// In en, this message translates to:
  /// **'Has a target end date.'**
  String get modeGoalBoundDesc;

  /// No description provided for @setTargetDate.
  ///
  /// In en, this message translates to:
  /// **'Set target date'**
  String get setTargetDate;

  /// No description provided for @targetDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Target: {date}'**
  String targetDateLabel(String date);

  /// No description provided for @dailyReminder.
  ///
  /// In en, this message translates to:
  /// **'Daily reminder'**
  String get dailyReminder;

  /// No description provided for @noReminder.
  ///
  /// In en, this message translates to:
  /// **'No reminder'**
  String get noReminder;

  /// No description provided for @gracePeriod.
  ///
  /// In en, this message translates to:
  /// **'Grace period'**
  String get gracePeriod;

  /// No description provided for @gracePeriodDesc.
  ///
  /// In en, this message translates to:
  /// **'Miss one day without breaking your streak.'**
  String get gracePeriodDesc;

  /// No description provided for @color.
  ///
  /// In en, this message translates to:
  /// **'Color'**
  String get color;

  /// No description provided for @viewDetails.
  ///
  /// In en, this message translates to:
  /// **'View details'**
  String get viewDetails;

  /// No description provided for @detailStats.
  ///
  /// In en, this message translates to:
  /// **'Stats'**
  String get detailStats;

  /// No description provided for @detailHistory.
  ///
  /// In en, this message translates to:
  /// **'Last 5 Weeks'**
  String get detailHistory;

  /// No description provided for @detailRecentNotes.
  ///
  /// In en, this message translates to:
  /// **'Recent Notes'**
  String get detailRecentNotes;

  /// No description provided for @detailCurrentStreak.
  ///
  /// In en, this message translates to:
  /// **'Current Streak'**
  String get detailCurrentStreak;

  /// No description provided for @detailLongestStreak.
  ///
  /// In en, this message translates to:
  /// **'Longest Streak'**
  String get detailLongestStreak;

  /// No description provided for @detailTotal.
  ///
  /// In en, this message translates to:
  /// **'All Time'**
  String get detailTotal;

  /// No description provided for @detailThisMonth.
  ///
  /// In en, this message translates to:
  /// **'This Month'**
  String get detailThisMonth;

  /// No description provided for @detailNoNotes.
  ///
  /// In en, this message translates to:
  /// **'No notes for this habit yet.'**
  String get detailNoNotes;

  /// No description provided for @days.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 day} other{{count} days}}'**
  String days(int count);

  /// No description provided for @pauseHabit.
  ///
  /// In en, this message translates to:
  /// **'Pause habit'**
  String get pauseHabit;

  /// No description provided for @resumeHabit.
  ///
  /// In en, this message translates to:
  /// **'Resume habit'**
  String get resumeHabit;

  /// No description provided for @paused.
  ///
  /// In en, this message translates to:
  /// **'Paused'**
  String get paused;

  /// No description provided for @pausedUntil.
  ///
  /// In en, this message translates to:
  /// **'Paused until {date}'**
  String pausedUntil(String date);

  /// No description provided for @pauseDuration.
  ///
  /// In en, this message translates to:
  /// **'Pause for how long?'**
  String get pauseDuration;

  /// No description provided for @pauseTomorrow.
  ///
  /// In en, this message translates to:
  /// **'Tomorrow'**
  String get pauseTomorrow;

  /// No description provided for @pause3Days.
  ///
  /// In en, this message translates to:
  /// **'3 days'**
  String get pause3Days;

  /// No description provided for @pause1Week.
  ///
  /// In en, this message translates to:
  /// **'1 week'**
  String get pause1Week;

  /// No description provided for @pause2Weeks.
  ///
  /// In en, this message translates to:
  /// **'2 weeks'**
  String get pause2Weeks;

  /// No description provided for @pauseIndefinitely.
  ///
  /// In en, this message translates to:
  /// **'Indefinitely'**
  String get pauseIndefinitely;

  /// No description provided for @archiveHabit.
  ///
  /// In en, this message translates to:
  /// **'Archive habit'**
  String get archiveHabit;

  /// No description provided for @archiveHabitBody.
  ///
  /// In en, this message translates to:
  /// **'This habit will be moved to the Archive. You can view it there any time.'**
  String get archiveHabitBody;

  /// No description provided for @setTargetDateFirst.
  ///
  /// In en, this message translates to:
  /// **'Please set a target date.'**
  String get setTargetDateFirst;

  /// No description provided for @logForToday.
  ///
  /// In en, this message translates to:
  /// **'Log for today'**
  String get logForToday;

  /// No description provided for @noteOptional.
  ///
  /// In en, this message translates to:
  /// **'Note (optional)'**
  String get noteOptional;

  /// No description provided for @noteHint.
  ///
  /// In en, this message translates to:
  /// **'How did it go?'**
  String get noteHint;

  /// No description provided for @markAsDone.
  ///
  /// In en, this message translates to:
  /// **'Mark as done'**
  String get markAsDone;

  /// No description provided for @completedLabel.
  ///
  /// In en, this message translates to:
  /// **'Completed!'**
  String get completedLabel;

  /// No description provided for @invalidValue.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid value.'**
  String get invalidValue;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// No description provided for @durationLabel.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get durationLabel;

  /// No description provided for @minutes.
  ///
  /// In en, this message translates to:
  /// **'minutes'**
  String get minutes;

  /// No description provided for @daysRemaining.
  ///
  /// In en, this message translates to:
  /// **'{days, plural, =0{Target reached today!} =1{1 day remaining} other{{days} days remaining}}'**
  String daysRemaining(int days);

  /// No description provided for @noArchivedHabits.
  ///
  /// In en, this message translates to:
  /// **'No archived habits'**
  String get noArchivedHabits;

  /// No description provided for @noArchivedHabitsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Completed goal-bound habits and retired ongoing habits will appear here.'**
  String get noArchivedHabitsSubtitle;

  /// No description provided for @completedOn.
  ///
  /// In en, this message translates to:
  /// **'Completed {date}'**
  String completedOn(String date);

  /// No description provided for @statsComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Stats coming in v1.5'**
  String get statsComingSoon;

  /// No description provided for @statsComingSoonSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Heatmaps, weekly summaries, and completion charts will be here.'**
  String get statsComingSoonSubtitle;

  /// No description provided for @journal.
  ///
  /// In en, this message translates to:
  /// **'Journal'**
  String get journal;

  /// No description provided for @journalEmpty.
  ///
  /// In en, this message translates to:
  /// **'No notes yet'**
  String get journalEmpty;

  /// No description provided for @journalEmptySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Add a note when checking in a habit to start your journal.'**
  String get journalEmptySubtitle;

  /// No description provided for @statsActivity.
  ///
  /// In en, this message translates to:
  /// **'Activity'**
  String get statsActivity;

  /// No description provided for @statsSummary.
  ///
  /// In en, this message translates to:
  /// **'Summary'**
  String get statsSummary;

  /// No description provided for @statsThisWeek.
  ///
  /// In en, this message translates to:
  /// **'This Week'**
  String get statsThisWeek;

  /// No description provided for @statsThisMonth.
  ///
  /// In en, this message translates to:
  /// **'This Month'**
  String get statsThisMonth;

  /// No description provided for @statsAllTime.
  ///
  /// In en, this message translates to:
  /// **'All Time'**
  String get statsAllTime;

  /// No description provided for @statsCheckIns.
  ///
  /// In en, this message translates to:
  /// **'{count} check-ins'**
  String statsCheckIns(int count);

  /// No description provided for @statsActiveHabits.
  ///
  /// In en, this message translates to:
  /// **'Active Habits'**
  String get statsActiveHabits;

  /// No description provided for @statsNoActivity.
  ///
  /// In en, this message translates to:
  /// **'No activity yet'**
  String get statsNoActivity;

  /// No description provided for @statsNoActivitySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Complete habits to see your progress here.'**
  String get statsNoActivitySubtitle;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageBahasa.
  ///
  /// In en, this message translates to:
  /// **'Bahasa Indonesia'**
  String get languageBahasa;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @themeMode.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get themeMode;

  /// No description provided for @themeModeSystem.
  ///
  /// In en, this message translates to:
  /// **'System default'**
  String get themeModeSystem;

  /// No description provided for @themeModeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeModeLight;

  /// No description provided for @themeModeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeModeDark;

  /// No description provided for @security.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get security;

  /// No description provided for @biometricLock.
  ///
  /// In en, this message translates to:
  /// **'Biometric / PIN lock'**
  String get biometricLock;

  /// No description provided for @biometricLockDesc.
  ///
  /// In en, this message translates to:
  /// **'Require authentication when opening the app.'**
  String get biometricLockDesc;

  /// No description provided for @biometricNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'Biometric authentication is not available on this device.'**
  String get biometricNotAvailable;

  /// No description provided for @biometricEnableFirst.
  ///
  /// In en, this message translates to:
  /// **'Authentication failed. Lock not enabled.'**
  String get biometricEnableFirst;

  /// No description provided for @authenticateReason.
  ///
  /// In en, this message translates to:
  /// **'Authenticate to unlock Simple Habits Tracker'**
  String get authenticateReason;

  /// No description provided for @unlock.
  ///
  /// In en, this message translates to:
  /// **'Unlock'**
  String get unlock;

  /// No description provided for @authFailed.
  ///
  /// In en, this message translates to:
  /// **'Authentication failed. Please try again.'**
  String get authFailed;

  /// No description provided for @welcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to\nSimple Habits Tracker'**
  String get welcomeTitle;

  /// No description provided for @welcomeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Build better habits, one day at a time.'**
  String get welcomeSubtitle;

  /// No description provided for @chooseLanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose your language'**
  String get chooseLanguage;

  /// No description provided for @chooseLanguageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'You can change this later in Settings.'**
  String get chooseLanguageSubtitle;

  /// No description provided for @setupSecurity.
  ///
  /// In en, this message translates to:
  /// **'Secure your app'**
  String get setupSecurity;

  /// No description provided for @setupSecurityDesc.
  ///
  /// In en, this message translates to:
  /// **'Enable biometric or PIN lock to protect your habits. You can change this in Settings.'**
  String get setupSecurityDesc;

  /// No description provided for @enableLock.
  ///
  /// In en, this message translates to:
  /// **'Enable lock'**
  String get enableLock;

  /// No description provided for @disableAuthRecovery.
  ///
  /// In en, this message translates to:
  /// **'Having trouble? Disable authentication'**
  String get disableAuthRecovery;

  /// No description provided for @disableAuthTitle.
  ///
  /// In en, this message translates to:
  /// **'Disable authentication'**
  String get disableAuthTitle;

  /// No description provided for @disableAuthBody.
  ///
  /// In en, this message translates to:
  /// **'This will turn off the lock screen. You can re-enable it in Settings.'**
  String get disableAuthBody;

  /// No description provided for @disableAuthConfirm.
  ///
  /// In en, this message translates to:
  /// **'Disable'**
  String get disableAuthConfirm;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'id'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'id':
      return AppLocalizationsId();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
