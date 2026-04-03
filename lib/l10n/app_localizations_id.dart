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
  String get help => 'Bantuan';

  @override
  String get userGuide => 'Panduan Pengguna';

  @override
  String get userGuideSubtitle =>
      'Pelajari cara menggunakan Simple Habits Tracker';

  @override
  String get guideGettingStartedTitle => 'Memulai';

  @override
  String get guideGettingStartedBody =>
      'Simple Habits Tracker membantu Anda membangun kebiasaan lebih baik, satu hari dalam satu waktu.\n\nSaat pertama kali membuka aplikasi, Anda akan dipandu melalui pengaturan singkat:\n• Pilih bahasa yang diinginkan\n• Aktifkan kunci biometrik atau PIN secara opsional untuk melindungi data Anda\n\nSetelah selesai, Anda akan masuk ke layar Hari Ini tempat semua kebiasaan Anda berada.';

  @override
  String get guideTodayScreenTitle => 'Layar Hari Ini';

  @override
  String get guideTodayScreenBody =>
      'Layar Hari Ini adalah dasbor harian Anda.\n\n• Kebiasaan dikelompokkan berdasarkan kategori\n• Setiap kartu menampilkan nama kebiasaan, rentetan, dan status check-in hari ini\n• Ketuk tombol centang di kartu untuk mencatat penyelesaian cepat\n• Ketuk kartu untuk membuka lembar check-in dan menambahkan nilai atau catatan\n• Ketuk ⋮ pada kartu untuk opsi lainnya: Lihat Detail, Edit, Jeda\n• Kartu Niat Harian di bagian atas memungkinkan Anda menetapkan fokus untuk hari ini\n• Ketuk + (kanan bawah) untuk menambahkan kebiasaan baru';

  @override
  String get guideAddingHabitTitle => 'Menambahkan Kebiasaan';

  @override
  String get guideAddingHabitBody =>
      'Ketuk tombol + di layar Hari Ini untuk membuat kebiasaan baru.\n\nAnda akan diminta mengatur:\n• Nama — nama kebiasaan\n• Kategori — Kesehatan, Pekerjaan, Pribadi, Keuangan, Belajar, Sosial, atau Lainnya\n• Jenis pelacakan:\n  - Selesai/Tidak selesai — centang sederhana\n  - Hitungan — catat angka (mis. gelas air)\n  - Durasi — catat menit\n• Mode:\n  - Berkelanjutan — tanpa tanggal akhir, hentikan manual saat selesai\n  - Berbatas waktu — tentukan tanggal target; diarsipkan otomatis saat tercapai\n• Pengingat harian — waktu notifikasi opsional\n• Masa tenggang — mengizinkan satu hari terlewat tanpa menghentikan rentetan\n• Warna — pilih warna aksen untuk kartu kebiasaan';

  @override
  String get guideCheckInTitle => 'Check-in';

  @override
  String get guideCheckInBody =>
      'Untuk mencatat kemajuan hari ini, ketuk tombol centang pada kartu kebiasaan atau ketuk kartu untuk membuka lembar check-in.\n\n• Untuk kebiasaan Selesai/Tidak selesai, ketuk sekali untuk menandai selesai\n• Untuk kebiasaan Hitungan, masukkan jumlah dan satuannya\n• Untuk kebiasaan Durasi, masukkan jumlah menit\n• Tambahkan catatan opsional — akan muncul di Jurnal Anda\n\nAnda dapat membuka kembali lembar ini untuk mengedit entri hari ini kapan saja.';

  @override
  String get guideStreaksTitle => 'Rentetan & Masa Tenggang';

  @override
  String get guideStreaksBody =>
      'Rentetan menghitung berapa hari berturut-turut Anda menyelesaikan kebiasaan.\n\n• Rentetan saat ini ditampilkan di setiap kartu kebiasaan dengan ikon 🔥\n• Jika Anda melewatkan hari ini, rentetan masih dihitung dari kemarin — check-in nanti hari ini tidak akan mengatur ulang rentetan\n• Masa Tenggang: jika diaktifkan, Anda diizinkan melewatkan satu hari tanpa menghentikan rentetan. Masa tenggang hanya dapat digunakan sekali per rentetan.\n• Rentetan terpanjang yang pernah Anda capai ditampilkan di layar detail kebiasaan';

  @override
  String get guidePauseTitle => 'Menjeda Kebiasaan';

  @override
  String get guidePauseBody =>
      'Kadang ada halangan. Anda dapat menjeda kebiasaan agar tidak memengaruhi rentetan.\n\nUntuk menjeda, ketuk ⋮ pada kartu kebiasaan dan pilih Jeda kebiasaan. Lalu pilih durasi:\n• Besok\n• 3 hari\n• 1 minggu\n• 2 minggu\n• Tanpa batas\n\nKebiasaan yang dijeda ditampilkan dengan lencana ⏸ dan opasitas berkurang. Kebiasaan akan dilanjutkan otomatis saat periode jeda berakhir, atau Anda bisa melanjutkannya secara manual melalui menu ⋮.';

  @override
  String get guideIntentionTitle => 'Niat Harian';

  @override
  String get guideIntentionBody =>
      'Kartu Niat Harian berada di bagian atas layar Hari Ini. Gunakan untuk menetapkan fokus atau tujuan singkat untuk hari ini.\n\n• Ketuk kartu untuk membuka lembar niat\n• Ketik niat Anda dan ketuk Simpan\n• Niat Anda ditampilkan di kartu sepanjang hari\n• Ketuk kartu lagi untuk mengedit atau menghapusnya\n• Niat diatur ulang secara otomatis setiap hari baru';

  @override
  String get guideDetailBadgesTitle => 'Detail Kebiasaan & Lencana';

  @override
  String get guideDetailBadgesBody =>
      'Ketuk ⋮ pada kartu kebiasaan dan pilih Lihat Detail untuk membuka layar detail kebiasaan.\n\nAnda akan melihat:\n• Statistik — rentetan saat ini, rentetan terpanjang, total penyelesaian\n• Lencana — 8 lencana pencapaian dari kemajuan Anda:\n  🌱 Langkah Pertama (1 penyelesaian)\n  🔥 Pejuang Mingguan (rentetan 7 hari)\n  ⚡ Dua Minggu (rentetan 14 hari)\n  💪 Master Bulanan (rentetan 30 hari)\n  🏆 Rentetan Seabad (rentetan 100 hari)\n  👑 Setahun Berkebiasaan (rentetan 365 hari)\n  ⭐ Berdedikasi (50 penyelesaian)\n  🌟 Klub Seabad (100 penyelesaian)\n• Kalender riwayat 5 minggu\n• Catatan terbaru dari check-in Anda\n\nLencana yang diperoleh disorot; yang belum diperoleh disamarkan. Ketuk lencana apa pun untuk melihat persyaratannya.';

  @override
  String get guideStatsTitle => 'Statistik & Jurnal';

  @override
  String get guideStatsBody =>
      'Tab Statistik (navigasi bawah, kanan) menampilkan aktivitas keseluruhan Anda.\n\n• Heatmap aktivitas — 17 minggu data check-in; hari ini disorot dan tampilan otomatis menggulir ke minggu saat ini. Ketuk sel mana pun untuk melihat jumlah hari tersebut.\n• Minggu Ini — diagram batang 7 hari terakhir\n• 4 Minggu Terakhir — diagram batang penyelesaian mingguan\n• Kartu ringkasan — kebiasaan aktif, total check-in minggu ini, bulan ini, dan sepanjang waktu\n\nKetuk ikon 📖 di bilah aplikasi Statistik untuk membuka Jurnal, yang menampilkan semua catatan check-in dikelompokkan berdasarkan tanggal.';

  @override
  String get guideArchiveTitle => 'Arsip';

  @override
  String get guideArchiveBody =>
      'Tab Arsip (navigasi bawah, kiri) adalah catatan kebiasaan yang selesai dan dihentikan.\n\nKebiasaan dipindahkan ke Arsip saat:\n• Kebiasaan berbatas waktu mencapai tanggal targetnya\n• Anda menghentikan kebiasaan berkelanjutan secara manual\n\nDari Arsip Anda dapat:\n• Ketuk ⋮ pada kebiasaan → Pulihkan untuk memindahkannya kembali ke kebiasaan aktif\n• Ketuk ⋮ → Hapus permanen untuk menghapusnya selamanya (tidak dapat dibatalkan)';

  @override
  String get guideSettingsTitle => 'Pengaturan';

  @override
  String get guideSettingsBody =>
      'Akses Pengaturan dengan mengetuk ikon 🎛 di bilah aplikasi layar Hari Ini.\n\n• Bahasa — beralih antara Bahasa Indonesia dan English\n• Tema — pilih Terang, Gelap, atau ikuti pengaturan sistem\n• Kunci biometrik / PIN — saat diaktifkan, aplikasi memerlukan autentikasi setiap kali dibuka. Jika perangkat Anda tidak mendukung biometrik, opsi ini akan dinonaktifkan secara otomatis.';

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
