library flutter_nfc;

import 'package:flutter/services.dart'
  show PlatformException;

import 'core/session/session.dart';

/// The entry point for accessing the NFC session.
class FlutterNfc {
  FlutterNfc._();

  /// Cached instances of [FlutterNfc].
  static FlutterNfc? _flutterNfcInstance;

  /// A Singleton instance of FlutterNfc.
  /// Returns an instance.
  // ignore: prefer_constructors_over_static_methods
  static FlutterNfc get instance =>
      _flutterNfcInstance ??= FlutterNfc._();

  /// Cached and lazily loaded instance of [NFCPlatform] to avoid
  /// creating a `MethodChannelNFCSession` when not needed or creating an
  /// instance with the default app before a user specifies an app.
  NFCPlatform? _delegatePackingProperty;

  /// Returns the underlying delegate implementation.
  ///
  /// If called and no [_delegatePackingProperty] exists, it will first be
  /// created and assigned before returning the delegate.
  NFCPlatform get _delegate =>
    _delegatePackingProperty ??= NFCPlatform.instanceFor();

  /// Checks whether the `NFC` features are available.
  Future<bool> isAvailable() {
    try {
      return _delegate.isAvailable();
    } on PlatformException catch (error, stackTrace) {
      throw PlatformException(
        code: "isAvailable",
        message: "NFC features are not available, "
          "fail code: ${error.code}, message error: ${error.message}",
        details: error.details,
        stacktrace: error.stacktrace ?? stackTrace.toString());
    } catch (error, stackTrace) {
      throw PlatformException(
        code: "isAvailable",
        message: "NFC features are not available",
        details: error,
        stacktrace: stackTrace.toString());
    }
  }

  /// Open setting for enable/disble the `NFC` features on Android.
  Future<void> openSetting() {
    try {
      return _delegate.openSetting();
    } on PlatformException catch (error, stackTrace) {
      throw PlatformException(
        code: "openSetting",
        message: "Open setting for enable NFC features, "
          "fail code: ${error.code}, message error: ${error.message}",
        details: error.details,
        stacktrace: error.stacktrace ?? stackTrace.toString());
    } catch (error, stackTrace) {
      throw PlatformException(
        code: "openSetting",
        message: "Open setting for enable NFC features",
        details: error,
        stacktrace: stackTrace.toString());
    }
  }

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
  /// `onError` is called when the session stops
  /// for any reason after the session started.
  Future<void> startSession({
    required TagCallback onTagDiscovered,
    Set<NFCTagPollingOption>? pollingOption,
    String? alertMessage,
    ErrorCallback? onError,
  }) {
    try {
      return _delegate.startSession(
        onTagDiscovered: onTagDiscovered,
        onError: onError,
        pollingOption: pollingOption
          ?? NFCTagPollingOption.values.toSet(),
        alertMessage: alertMessage);
    } on PlatformException catch (error, stackTrace) {
      throw PlatformException(
        code: "startSession",
        message: "NFC features cannot open NFC tag session, "
          "fail code: ${error.code}, message error: ${error.message}",
        details: error.details,
        stacktrace: error.stacktrace ?? stackTrace.toString());
    } catch (error, stackTrace) {
      throw PlatformException(
        code: "startSession",
        message: "NFC features cannot open NFC tag session",
        details: error,
        stacktrace: stackTrace.toString());
    }
  }

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
    String? errorMessage,
    String? alertMessage,
  }) {
    try {
      return _delegate.stopSession(
        alertMessage: alertMessage,
        errorMessage: errorMessage);
    } on PlatformException catch (error, stackTrace) {
      throw PlatformException(
        code: "stopSession",
        message: "NFC features cannot close NFC tag session, "
          "fail code: ${error.code}, message error: ${error.message}",
        details: error.details,
        stacktrace: error.stacktrace ?? stackTrace.toString());
    } catch (error, stackTrace) {
      throw PlatformException(
        code: "stopSession",
        message: "NFC features cannot close NFC tag session",
        details: error,
        stacktrace: stackTrace.toString());
    }
  }
}