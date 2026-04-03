import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/extensions/context_extensions.dart';
import '../../auth/services/auth_service.dart';
import '../../settings/providers/settings_provider.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _pageController = PageController();
  int _currentPage = 0;
  Locale _selectedLocale = const Locale('en');

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _finish({bool enableAuth = false}) async {
    final notifier = ref.read(settingsProvider.notifier);
    await notifier.setLocale(_selectedLocale);
    if (enableAuth) await notifier.setAuthEnabled(true);
    await notifier.completeOnboarding();
    // app.dart reacts to settingsProvider and navigates automatically.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Page dots
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(2, (i) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: i == _currentPage ? 20 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: i == _currentPage
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.outlineVariant,
                    ),
                  );
                }),
              ),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (i) => setState(() => _currentPage = i),
                children: [
                  _LanguagePage(
                    selected: _selectedLocale,
                    onSelect: (locale) =>
                        setState(() => _selectedLocale = locale),
                    onNext: _nextPage,
                  ),
                  _SecurityPage(
                    onFinish: _finish,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Page 1: Language ─────────────────────────────────────────────────────────

class _LanguagePage extends StatelessWidget {
  const _LanguagePage({
    required this.selected,
    required this.onSelect,
    required this.onNext,
  });

  final Locale selected;
  final ValueChanged<Locale> onSelect;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Spacer(),
          Icon(
            Icons.language_rounded,
            size: 80,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 32),
          Text(
            context.l10n.chooseLanguage,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            context.l10n.chooseLanguageSubtitle,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          _LangOption(
            label: 'English',
            sublabel: 'English',
            locale: const Locale('en'),
            selected: selected,
            onSelect: onSelect,
          ),
          const SizedBox(height: 12),
          _LangOption(
            label: 'Bahasa Indonesia',
            sublabel: 'Indonesian',
            locale: const Locale('id'),
            selected: selected,
            onSelect: onSelect,
          ),
          const Spacer(),
          FilledButton(
            onPressed: onNext,
            child: Text(context.l10n.next),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _LangOption extends StatelessWidget {
  const _LangOption({
    required this.label,
    required this.sublabel,
    required this.locale,
    required this.selected,
    required this.onSelect,
  });

  final String label;
  final String sublabel;
  final Locale locale;
  final Locale selected;
  final ValueChanged<Locale> onSelect;

  @override
  Widget build(BuildContext context) {
    final isSelected = selected == locale;
    final color = Theme.of(context).colorScheme;

    return InkWell(
      onTap: () => onSelect(locale),
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isSelected
              ? color.primaryContainer
              : color.surfaceContainerHighest,
          border: Border.all(
            color: isSelected ? color.primary : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: isSelected ? color.primary : null)),
                  Text(sublabel,
                      style: TextStyle(
                          fontSize: 12, color: color.onSurfaceVariant)),
                ],
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle_rounded, color: color.primary),
          ],
        ),
      ),
    );
  }
}

// ── Page 2: Security ──────────────────────────────────────────────────────────

class _SecurityPage extends StatefulWidget {
  const _SecurityPage({required this.onFinish});

  final Future<void> Function({bool enableAuth}) onFinish;

  @override
  State<_SecurityPage> createState() => _SecurityPageState();
}

class _SecurityPageState extends State<_SecurityPage> {
  bool _authAvailable = false;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    AuthService.instance.isAvailable().then((v) {
      if (mounted) setState(() { _authAvailable = v; _loading = false; });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Spacer(),
          Icon(
            Icons.lock_outline_rounded,
            size: 80,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 32),
          Text(
            context.l10n.setupSecurity,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            _authAvailable
                ? context.l10n.setupSecurityDesc
                : context.l10n.biometricNotAvailable,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          if (_loading)
            const Center(child: CircularProgressIndicator())
          else if (_authAvailable) ...[
            FilledButton.icon(
              onPressed: () => widget.onFinish(enableAuth: true),
              icon: const Icon(Icons.fingerprint),
              label: Text(context.l10n.enableLock),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () => widget.onFinish(enableAuth: false),
              child: Text(context.l10n.skip),
            ),
          ] else
            FilledButton(
              onPressed: () => widget.onFinish(enableAuth: false),
              child: Text(context.l10n.getStarted),
            ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
