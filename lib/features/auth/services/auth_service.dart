import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

enum AuthResult { success, failed, notAvailable }

/// Thin wrapper around [LocalAuthentication].
/// Never throws — errors are mapped to [AuthResult].
class AuthService {
  AuthService._();
  static final instance = AuthService._();

  final _auth = LocalAuthentication();

  /// True if the device has a PIN, pattern, password, or enrolled biometrics.
  Future<bool> isAvailable() async {
    try {
      return await _auth.isDeviceSupported();
    } on PlatformException {
      return false;
    }
  }

  /// Prompt the user to authenticate.
  /// Returns [AuthResult.notAvailable] if the device has no lock screen set up,
  /// so callers can auto-disable the setting rather than leaving the user locked out.
  Future<AuthResult> authenticate(String localizedReason) async {
    try {
      final available = await _auth.isDeviceSupported();
      if (!available) return AuthResult.notAvailable;

      final success = await _auth.authenticate(
        localizedReason: localizedReason,
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: false,
        ),
      );
      return success ? AuthResult.success : AuthResult.failed;
    } on PlatformException catch (e) {
      // NotAvailable / NotEnrolled → treat as unavailable so we can auto-disable.
      const unavailableCodes = ['NotAvailable', 'NotEnrolled', 'no_fragment_activity'];
      if (unavailableCodes.contains(e.code)) return AuthResult.notAvailable;
      return AuthResult.failed;
    }
  }
}
