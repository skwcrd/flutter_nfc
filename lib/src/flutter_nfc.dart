library flutter_nfc;

import 'core/session/session.dart';
import 'utils/utils.dart'
  show NFCPollingOption;

class FlutterNfc {
  FlutterNfc._();

  // Cached instances of [FlutterNfc].
  static FlutterNfc _flutterNfcInstance;

  /// Returns an instance.
  // ignore: prefer_constructors_over_static_methods
  static FlutterNfc get instance =>
      _flutterNfcInstance ??= FlutterNfc._();

  // Cached and lazily loaded instance of [NFCPlatform] to avoid
  // creating a [MethodChannelNFCSession] when not needed or creating an
  // instance with the default app before a user specifies an app.
  NFCPlatform _delegatePackingProperty;

  /// Returns the underlying delegate implementation.
  ///
  /// If called and no [_delegatePackingProperty] exists, it will first be
  /// created and assigned before returning the delegate.
  NFCPlatform get _delegate =>
    _delegatePackingProperty ??= NFCPlatform.delegateInstance();

  /// Checks whether the NFC features are available.
  Future<bool> isAvailable() => _delegate.isAvailable();

  Future<void> openSetting() => _delegate.openSetting();

  /// Start the session and register callbacks for
  /// tag discovery.
  ///
  /// This uses `NFCTagReaderSession` on iOS,
  /// `NfcAdapter#enableReaderMode` on Android.
  /// Requires iOS 13.0 or Android API level 19,
  /// or later.
  ///
  /// `onTagDiscovered` is called whenever the tag
  /// is discovered.
  ///
  /// `pollingOption` is used to specify the type
  /// of tags to be discovered. (default all types)
  ///
  /// On iOS only, `alertMessage` is used to display
  /// the message on the popup shown when the session
  /// is started.
  ///
  /// `onSessionError` is called when the session stops
  /// for any reason after the session started.
  Future<void> startSession({
    TagCallback onTagDiscovered,
    Set<NFCPollingOption> pollingOption,
    String alertMessage,
    ErrorCallback onError,
  }) => _delegate.startSession(
          onTagDiscovered: onTagDiscovered,
          onError: onError,
          pollingOption: pollingOption,
          alertMessage: alertMessage);

  /// Stop the session and unregister callback.
  ///
  /// This uses `NFCTagReaderSession` on iOS,
  /// `NfcAdapter#disableReaderMode` on Android.
  /// Requires iOS 13.0 or Android API level 19,
  /// or later.
  ///
  /// On iOS only, `alertMessage` and `errorMessage`
  /// are used to display the success or error message
  /// on the popup.
  ///
  /// Use `alertMessage` to indicate the success,
  /// and `errorMessage` to indicate the failure.
  ///
  /// When both are used, `errorMessage` has priority.
  Future<void> stopSession({
    String errorMessage,
    String alertMessage,
  }) => _delegate.stopSession(
          alertMessage: alertMessage,
          errorMessage: errorMessage);
}