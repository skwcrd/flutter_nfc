part of core.session;

abstract class NFCPlatform extends NFCInterface {
  NFCPlatform() : super(token: _token);

  /// Create an instance using the existing implementation
  factory NFCPlatform.instanceFor() =>
      NFCPlatform.instance.delegate();

  static final Object _token = Object();

  /// Ensures that any delegate class has extended a [NFCPlatform].
  static void verifyExtends(NFCPlatform instance) {
    NFCInterface.verifyToken(instance, _token);
  }

  /// The current default [NFCPlatform] instance.
  ///
  /// It will always default to [_MethodChannelNFCSession]
  /// if no other implementation was provided.
  static NFCPlatform get instance =>
      _instance ??= _MethodChannelNFCSession.instance;

  static NFCPlatform _instance;

  /// Sets the [NFCPlatform.instance]
  static set instance(NFCPlatform instance) {
    NFCInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Enables delegates to create new instances of themselves.
  @protected
  NFCPlatform delegate() {
    throw UnimplementedError('delegate() is not implemented');
  }

  /// Checks whether the NFC features are available.
  Future<bool> isAvailable() {
    throw UnimplementedError('isAvailable() is not implemented');
  }

  Future<void> openSetting() {
    throw UnimplementedError('openSetting() is not implemented');
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
    TagCallback onTagDiscovered,
    Set<NFCTagPollingOption> pollingOption,
    String alertMessage,
    ErrorCallback onError,
  }) async {
    throw UnimplementedError('startSession() is not implemented');
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
    String errorMessage,
    String alertMessage,
  }) async {
    throw UnimplementedError('stopSession() is not implemented');
  }
}