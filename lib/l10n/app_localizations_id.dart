// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get appTitle => 'Simple Habits Tracker';

  @override
  String get navToday => 'Hari Ini';

  @override
  String get navArchive => 'Arsip';

  @override
  String get navStats => 'Statistik';

  @override
  String get today => 'Hari Ini';

  @override
  String todayDate(String date) {
    return 'Hari ini, $date';
  }

  @override
  String get noHabitsTitle => 'Belum ada kebiasaan';

  @override
  String get noHabitsSubtitle =>
      'Ketuk tombol + untuk membuat kebiasaan pertama Anda.';

  @override
  String get addHabit => 'Tambah kebiasaan';

  @override
  String get newHabit => 'Kebiasaan Baru';

  @override
  String get editHabit => 'Edit Kebiasaan';

  @override
  String get save => 'Simpan';

  @override
  String get cancel => 'Batal';

  @override
  String get delete => 'Hapus';

  @override
  String get next => 'Lanjut';

  @override
  String get skip => 'Lewati';

  @override
  String get getStarted => 'Mulai';

  @override
  String get done => 'Selesai';

  @override
  String get habitName => 'Nama kebiasaan';

  @override
  String get habitNameHint => 'mis. Lari 30 menit';

  @override
  String get habitNameRequired => 'Nama wajib diisi';

  @override
  String get category => 'Kategori';

  @override
  String get categoryHealth => 'Kesehatan';

  @override
  String get categoryWork => 'Pekerjaan';

  @override
  String get categoryPersonal => 'Pribadi';

  @override
  String get categoryFinance => 'Keuangan';

  @override
  String get categoryLearning => 'Belajar';

  @override
  String get categorySocial => 'Sosial';

  @override
  String get categoryOther => 'Lainnya';

  @override
  String get howTrack => 'Bagaimana Anda melacaknya?';

  @override
  String get trackDone => 'Selesai / Tidak selesai';

  @override
  String get trackCount => 'Hitungan';

  @override
  String get trackDuration => 'Durasi';

  @override
  String get unit => 'Satuan (opsional)';

  @override
  String get unitHint => 'mis. gelas, km, halaman';

  @override
  String get mode => 'Mode';

  @override
  String get modeOngoing => 'Berkelanjutan';

  @override
  String get modeGoalBound => 'Berbatas waktu';

  @override
  String get modeOngoingDesc =>
      'Tanpa batas — hentikan secara manual saat selesai.';

  @override
  String get modeGoalBoundDesc => 'Memiliki tanggal target akhir.';

  @override
  String get setTargetDate => 'Tentukan tanggal target';

  @override
  String targetDateLabel(String date) {
    return 'Target: $date';
  }

  @override
  String get dailyReminder => 'Pengingat harian';

  @override
  String get noReminder => 'Tanpa pengingat';

  @override
  String get gracePeriod => 'Masa tenggang';

  @override
  String get gracePeriodDesc =>
      'Lewatkan satu hari tanpa menghentikan rentetan Anda.';

  @override
  String get color => 'Warna';

  @override
  String get viewDetails => 'Lihat detail';

  @override
  String get detailStats => 'Statistik';

  @override
  String get detailHistory => '5 Minggu Terakhir';

  @override
  String get detailRecentNotes => 'Catatan Terbaru';

  @override
  String get detailCurrentStreak => 'Rentetan Saat Ini';

  @override
  String get detailLongestStreak => 'Rentetan Terpanjang';

  @override
  String get detailTotal => 'Sepanjang Waktu';

  @override
  String get detailThisMonth => 'Bulan Ini';

  @override
  String get detailNoNotes => 'Belum ada catatan untuk kebiasaan ini.';

  @override
  String days(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count hari',
      one: '1 hari',
    );
    return '$_temp0';
  }

  @override
  String get pauseHabit => 'Jeda kebiasaan';

  @override
  String get resumeHabit => 'Lanjutkan kebiasaan';

  @override
  String get paused => 'Dijeda';

  @override
  String pausedUntil(String date) {
    return 'Dijeda hingga $date';
  }

  @override
  String get pauseDuration => 'Jeda berapa lama?';

  @override
  String get pauseTomorrow => 'Besok';

  @override
  String get pause3Days => '3 hari';

  @override
  String get pause1Week => '1 minggu';

  @override
  String get pause2Weeks => '2 minggu';

  @override
  String get pauseIndefinitely => 'Tanpa batas';

  @override
  String get archiveHabit => 'Arsipkan kebiasaan';

  @override
  String get archiveHabitBody =>
      'Kebiasaan ini akan dipindahkan ke Arsip. Anda bisa melihatnya kapan saja.';

  @override
  String get setTargetDateFirst => 'Silakan tentukan tanggal target.';

  @override
  String get logForToday => 'Catat untuk hari ini';

  @override
  String get noteOptional => 'Catatan (opsional)';

  @override
  String get noteHint => 'Bagaimana hasilnya?';

  @override
  String get markAsDone => 'Tandai selesai';

  @override
  String get completedLabel => 'Selesai!';

  @override
  String get invalidValue => 'Masukkan nilai yang valid.';

  @override
  String get amount => 'Jumlah';

  @override
  String get durationLabel => 'Durasi';

  @override
  String get minutes => 'menit';

  @override
  String daysRemaining(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days hari tersisa',
      one: '1 hari tersisa',
      zero: 'Target tercapai hari ini!',
    );
    return '$_temp0';
  }

  @override
  String get noArchivedHabits => 'Tidak ada kebiasaan yang diarsipkan';

  @override
  String get noArchivedHabitsSubtitle =>
      'Kebiasaan berbatas waktu yang selesai dan kebiasaan berkelanjutan yang dihentikan akan muncul di sini.';

  @override
  String completedOn(String date) {
    return 'Selesai $date';
  }

  @override
  String get statsComingSoon => 'Statistik hadir di v1.5';

  @override
  String get statsComingSoonSubtitle =>
      'Heatmap, ringkasan mingguan, dan grafik penyelesaian akan ada di sini.';

  @override
  String get journal => 'Jurnal';

  @override
  String get journalEmpty => 'Belum ada catatan';

  @override
  String get journalEmptySubtitle =>
      'Tambahkan catatan saat check-in kebiasaan untuk memulai jurnal Anda.';

  @override
  String get statsActivity => 'Aktivitas';

  @override
  String get statsSummary => 'Ringkasan';

  @override
  String get statsThisWeek => 'Minggu Ini';

  @override
  String get statsThisMonth => 'Bulan Ini';

  @override
  String get statsAllTime => 'Sepanjang Waktu';

  @override
  String statsCheckIns(int count) {
    return '$count check-in';
  }

  @override
  String get statsActiveHabits => 'Kebiasaan Aktif';

  @override
  String get statsNoActivity => 'Belum ada aktivitas';

  @override
  String get statsNoActivitySubtitle =>
      'Selesaikan kebiasaan untuk melihat perkembangan Anda di sini.';

  @override
  String get settings => 'Pengaturan';

  @override
  String get language => 'Bahasa';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageBahasa => 'Bahasa Indonesia';

  @override
  String get appearance => 'Tampilan';

  @override
  String get themeMode => 'Tema';

  @override
  String get themeModeSystem => 'Ikuti sistem';

  @override
  String get themeModeLight => 'Terang';

  @override
  String get themeModeDark => 'Gelap';

  @override
  String get security => 'Keamanan';

  @override
  String get biometricLock => 'Kunci biometrik / PIN';

  @override
  String get biometricLockDesc =>
      'Memerlukan autentikasi saat membuka aplikasi.';

  @override
  String get biometricNotAvailable =>
      'Autentikasi biometrik tidak tersedia di perangkat ini.';

  @override
  String get biometricEnableFirst =>
      'Autentikasi gagal. Kunci tidak diaktifkan.';

  @override
  String get authenticateReason =>
      'Autentikasi untuk membuka Simple Habits Tracker';

  @override
  String get unlock => 'Buka Kunci';

  @override
  String get authFailed => 'Autentikasi gagal. Silakan coba lagi.';

  @override
  String get welcomeTitle => 'Selamat Datang di\nSimple Habits Tracker';

  @override
  String get welcomeSubtitle =>
      'Bangun kebiasaan lebih baik, satu hari dalam satu waktu.';

  @override
  String get chooseLanguage => 'Pilih bahasa Anda';

  @override
  String get chooseLanguageSubtitle =>
      'Anda bisa mengubahnya nanti di Pengaturan.';

  @override
  String get setupSecurity => 'Amankan aplikasi Anda';

  @override
  String get setupSecurityDesc =>
      'Aktifkan kunci biometrik atau PIN untuk melindungi kebiasaan Anda. Anda bisa mengubahnya di Pengaturan.';

  @override
  String get enableLock => 'Aktifkan kunci';

  @override
  String get disableAuthRecovery => 'Bermasalah? Nonaktifkan autentikasi';

  @override
  String get disableAuthTitle => 'Nonaktifkan autentikasi';

  @override
  String get disableAuthBody =>
      'Ini akan mematikan layar kunci. Anda bisa mengaktifkannya kembali di Pengaturan.';

  @override
  String get disableAuthConfirm => 'Nonaktifkan';

  @override
  String get intentionTitle => 'Niat Hari Ini';

  @override
  String get intentionHint => 'Apa yang ingin Anda fokuskan hari ini?';

  @override
  String get intentionPlaceholder => 'Tetapkan niat Anda untuk hari ini…';

  @override
  String get intentionSave => 'Simpan';

  @override
  String get intentionClear => 'Hapus';

  @override
  String get intentionEmpty => 'Belum ada niat';

  @override
  String get detailBadges => 'Lencana';

  @override
  String get badgeFirstStep => 'Langkah Pertama';

  @override
  String get badgeFirstStepDesc => 'Selesaikan check-in pertama Anda';

  @override
  String get badgeWeekWarrior => 'Pejuang Mingguan';

  @override
  String get badgeWeekWarriorDesc => 'Capai rentetan 7 hari';

  @override
  String get badgeFortnight => 'Dua Minggu';

  @override
  String get badgeFortnightDesc => 'Capai rentetan 14 hari';

  @override
  String get badgeMonthlyMaster => 'Master Bulanan';

  @override
  String get badgeMonthlyMasterDesc => 'Capai rentetan 30 hari';

  @override
  String get badgeCenturyStreak => 'Rentetan Seabad';

  @override
  String get badgeCenturyStreakDesc => 'Capai rentetan 100 hari';

  @override
  String get badgeYearOfHabit => 'Setahun Berkebiasaan';

  @override
  String get badgeYearOfHabitDesc => 'Capai rentetan 365 hari';

  @override
  String get badgeDedicated => 'Berdedikasi';

  @override
  String get badgeDedicatedDesc => 'Selesaikan 50 check-in';

  @override
  String get badgeCenturyClub => 'Klub Seabad';

  @override
  String get badgeCenturyClubDesc => 'Selesaikan 100 check-in';

  @override
  String get restoreHabit => 'Pulihkan kebiasaan';

  @override
  String get deletePermanently => 'Hapus permanen';

  @override
  String deleteHabitConfirm(String name) {
    return 'Hapus \"$name\" secara permanen? Tindakan ini tidak dapat dibatalkan.';
  }

  @override
  String habitRestored(String name) {
    return '\"$name\" dipulihkan ke kebiasaan aktif.';
  }
}
