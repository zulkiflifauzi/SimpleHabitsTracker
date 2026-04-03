package com.simpleappinc.simplehabitstracker

import io.flutter.embedding.android.FlutterFragmentActivity

// FlutterFragmentActivity (not FlutterActivity) is required by local_auth's
// BiometricPrompt API, which needs a FragmentActivity host.
class MainActivity : FlutterFragmentActivity()
