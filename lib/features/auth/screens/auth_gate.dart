import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/extensions/context_extensions.dart';
import '../../settings/providers/settings_provider.dart';
import '../../shell/main_shell.dart';
import '../services/auth_service.dart';

/// Wraps [MainShell] with a lock screen.
/// Re-locks when the app is sent to background.
/// Auto-disables auth if the device has no lock screen set up.
class AuthGate extends ConsumerStatefulWidget {
  const AuthGate({super.key});

  @override
  ConsumerState<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends ConsumerState<AuthGate>
    with WidgetsBindingObserver {
  bool _authenticated = false;
  bool _authenticating = false;
  int _failCount = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) => _authenticate());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      if (mounted) setState(() => _authenticated = false);
    }
    if (state == AppLifecycleState.resumed && !_authenticated) {
      _authenticate();
    }
  }

  Future<void> _authenticate() async {
    if (_authenticating) return;
    setState(() => _authenticating = true);

    final result = await AuthService.instance.authenticate(
      context.l10n.authenticateReason,
    );

    if (!mounted) return;

    switch (result) {
      case AuthResult.success:
        setState(() {
          _authenticated = true;
          _authenticating = false;
          _failCount = 0;
        });

      case AuthResult.notAvailable:
        // Device has no lock screen — disable auth setting and let user in.
        await ref.read(settingsProvider.notifier).setAuthEnabled(false);
        if (mounted) {
          setState(() { _authenticated = true; _authenticating = false; });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(context.l10n.biometricNotAvailable)),
          );
        }

      case AuthResult.failed:
        setState(() {
          _authenticating = false;
          _failCount++;
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(context.l10n.authFailed)),
          );
        }
    }
  }

  Future<void> _disableAuth() async {
    await ref.read(settingsProvider.notifier).setAuthEnabled(false);
    // settingsProvider change causes app.dart to render MainShell directly.
  }

  @override
  Widget build(BuildContext context) {
    if (_authenticated) return const MainShell();

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.lock_outline_rounded,
                size: 72,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 24),
              Text(
                context.l10n.appTitle,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                context.l10n.authenticateReason,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              FilledButton.icon(
                onPressed: _authenticating ? null : _authenticate,
                icon: _authenticating
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.fingerprint),
                label: Text(context.l10n.unlock),
              ),
              // Recovery option — shown after 2+ failed attempts.
              if (_failCount >= 2) ...[
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () => _showDisableAuthDialog(context),
                  child: Text(
                    context.l10n.disableAuthRecovery,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showDisableAuthDialog(BuildContext context) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(context.l10n.disableAuthTitle),
        content: Text(context.l10n.disableAuthBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(context.l10n.cancel),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(context.l10n.disableAuthConfirm),
          ),
        ],
      ),
    );
    if (confirm == true) await _disableAuth();
  }
}
