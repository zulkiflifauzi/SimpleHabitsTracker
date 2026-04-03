import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/extensions/context_extensions.dart';
import '../../auth/services/auth_service.dart' show AuthService, AuthResult;
import '../../help/screens/help_screen.dart';
import '../providers/settings_provider.dart';

// Maps ThemeMode → icon
IconData _themeModeIcon(ThemeMode mode) {
  switch (mode) {
    case ThemeMode.light:
      return Icons.light_mode_rounded;
    case ThemeMode.dark:
      return Icons.dark_mode_rounded;
    case ThemeMode.system:
      return Icons.brightness_auto_rounded;
  }
}

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings),
        scrolledUnderElevation: 0,
      ),
      body: ListView(
        children: [
          // ── Language ───────────────────────────────────────────────────
          _SectionHeader(l10n.language),
          _LangTile(
            label: l10n.languageEnglish,
            locale: const Locale('en'),
            selected: settings.locale,
            onTap: () =>
                ref.read(settingsProvider.notifier).setLocale(const Locale('en')),
          ),
          _LangTile(
            label: l10n.languageBahasa,
            locale: const Locale('id'),
            selected: settings.locale,
            onTap: () =>
                ref.read(settingsProvider.notifier).setLocale(const Locale('id')),
          ),

          const Divider(height: 32),

          // ── Appearance ─────────────────────────────────────────────────
          _SectionHeader(l10n.appearance),
          ListTile(
            leading: Icon(_themeModeIcon(settings.themeMode)),
            title: Text(l10n.themeMode),
            trailing: DropdownButton<ThemeMode>(
              value: settings.themeMode,
              underline: const SizedBox.shrink(),
              borderRadius: BorderRadius.circular(12),
              items: [
                DropdownMenuItem(
                  value: ThemeMode.system,
                  child: Text(l10n.themeModeSystem),
                ),
                DropdownMenuItem(
                  value: ThemeMode.light,
                  child: Text(l10n.themeModeLight),
                ),
                DropdownMenuItem(
                  value: ThemeMode.dark,
                  child: Text(l10n.themeModeDark),
                ),
              ],
              onChanged: (mode) {
                if (mode != null) {
                  ref.read(settingsProvider.notifier).setThemeMode(mode);
                }
              },
            ),
          ),

          const Divider(height: 32),

          // ── Security ───────────────────────────────────────────────────
          _SectionHeader(l10n.security),
          _BiometricTile(
            enabled: settings.authEnabled,
            onChanged: (value) => _toggleAuth(context, ref, value),
          ),

          const Divider(height: 32),

          // ── Help ───────────────────────────────────────────────────────
          _SectionHeader(l10n.help),
          ListTile(
            leading: const Icon(Icons.menu_book_rounded),
            title: Text(l10n.userGuide),
            subtitle: Text(l10n.userGuideSubtitle),
            trailing: const Icon(Icons.chevron_right_rounded),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const HelpScreen()),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _toggleAuth(
      BuildContext context, WidgetRef ref, bool enable) async {
    if (enable) {
      // Verify auth works before enabling, so the user can't lock themselves out.
      final result = await AuthService.instance.authenticate(
        context.l10n.authenticateReason,
      );
      if (result != AuthResult.success) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(context.l10n.biometricEnableFirst)),
          );
        }
        return;
      }
    }
    await ref.read(settingsProvider.notifier).setAuthEnabled(enable);
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Text(
        title.toUpperCase(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              letterSpacing: 1.2,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}

class _LangTile extends StatelessWidget {
  const _LangTile({
    required this.label,
    required this.locale,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final Locale locale;
  final Locale selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isSelected = selected == locale;
    return ListTile(
      title: Text(label),
      trailing: isSelected
          ? Icon(Icons.check_rounded,
              color: Theme.of(context).colorScheme.primary)
          : null,
      selected: isSelected,
      onTap: onTap,
    );
  }
}

class _BiometricTile extends ConsumerStatefulWidget {
  const _BiometricTile({required this.enabled, required this.onChanged});

  final bool enabled;
  final ValueChanged<bool> onChanged;

  @override
  ConsumerState<_BiometricTile> createState() => _BiometricTileState();
}

class _BiometricTileState extends ConsumerState<_BiometricTile> {
  bool _available = false;

  @override
  void initState() {
    super.initState();
    AuthService.instance.isAvailable().then((v) {
      if (mounted) setState(() => _available = v);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SwitchListTile.adaptive(
      title: Text(context.l10n.biometricLock),
      subtitle: Text(
        _available
            ? context.l10n.biometricLockDesc
            : context.l10n.biometricNotAvailable,
      ),
      value: widget.enabled,
      onChanged: _available ? widget.onChanged : null,
    );
  }
}
