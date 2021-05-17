part of core.session;

class MethodChannelNFCSession extends NFCPlatform {
  MethodChannelNFCSession._({
    @required Future<dynamic> Function(MethodCall) handler
  }) : super() {
    if ( handler != null ) {
      channel.setMethodCallHandler(handler);
    }
  }

  /// Returns a stub instance to allow the platform interface
  /// to access the class instance statically.
  // ignore: prefer_constructors_over_static_methods
  static MethodChannelNFCSession get instance =>
      MethodChannelNFCSession._(handler: null);

  static NFCPlatform _methodChannelNFCInstance;

  @override
  NFCPlatform delegate() =>
      _methodChannelNFCInstance ??=
          MethodChannelNFCSession._(handler: _handleMethodCall);

  ErrorCallback _onError;
  StreamSubscription _tagSub;

  @override
  Future<bool> isAvailable() async {
    try {
      return channel.invokeMethod("isAvailable");
    } on PlatformException catch (error, stackTrace) {
      throw PlatformException(
        code: "isAvailable",
        message: "NFC features are not available, "
          "fail code: ${error.code}, message error: ${error.message}",
        details: error.details,
        stacktrace: error.stacktrace ?? stackTrace?.toString());
    } catch (error, stackTrace) {
      throw PlatformException(
        code: "isAvailable",
        message: "NFC features are not available",
        details: error,
        stacktrace: stackTrace?.toString()
          ?? StackTrace.current.toString());
    }
  }

  @override
  Future<void> openSetting() async {
    try {
      return channel.invokeMethod("isAvailable");
    } on PlatformException catch (error, stackTrace) {
      throw PlatformException(
        code: "openSetting",
        message: "Open setting for enable NFC features, "
          "fail code: ${error.code}, message error: ${error.message}",
        details: error.details,
        stacktrace: error.stacktrace ?? stackTrace?.toString());
    } catch (error, stackTrace) {
      throw PlatformException(
        code: "openSetting",
        message: "Open setting for enable NFC features",
        details: error,
        stacktrace: stackTrace?.toString()
          ?? StackTrace.current.toString());
    }
  }

  @override
  Future<void> startSession({
    @required TagCallback onTagDiscovered,
    Set<NFCPollingOption> pollingOption,
    String alertMessage,
    ErrorCallback onError,
  }) async {
    try {
      _tagSub = tagController.stream.listen(onTagDiscovered);
      _onError = onError;
      pollingOption ??= NFCPollingOption.values.toSet();

      return channel.invokeMethod(
        "startSession", {
          'pollingOption': pollingOption.map((tag) => tag.value).toList(),
          'alertMessage': alertMessage,
        });
    } on PlatformException catch (error, stackTrace) {
      throw PlatformException(
        code: "startSession",
        message: "NFC features are not open NFC tag session, "
          "fail code: ${error.code}, message error: ${error.message}",
        details: error.details,
        stacktrace: error.stacktrace ?? stackTrace?.toString());
    } catch (error, stackTrace) {
      throw PlatformException(
        code: "startSession",
        message: "NFC features are not open NFC tag session",
        details: error,
        stacktrace: stackTrace?.toString()
          ?? StackTrace.current.toString());
    }
  }

  @override
  Future<void> stopSession({
    String errorMessage,
    String alertMessage,
  }) async {
    try {
      await _tagSub?.cancel();

      _tagSub = null;
      _onError = null;

      return channel.invokeMethod(
        "stopSession", {
          'errorMessage': errorMessage,
          'alertMessage': alertMessage,
        });
    } on PlatformException catch (error, stackTrace) {
      throw PlatformException(
        code: "stopSession",
        message: "NFC features are not close NFC tag session, "
          "fail code: ${error.code}, message error: ${error.message}",
        details: error.details,
        stacktrace: error.stacktrace ?? stackTrace?.toString());
    } catch (error, stackTrace) {
      throw PlatformException(
        code: "stopSession",
        message: "NFC features are not close NFC tag session",
        details: error,
        stacktrace: stackTrace?.toString()
          ?? StackTrace.current.toString());
    }
  }

  /// A callback for receiving method calls on channel.
  ///
  /// The callback will replace the currently registered
  /// callback for channel, if any. To remove the handler,
  /// pass null as the `handler` argument.
  Future<void> _handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'onTagDiscovered':
        _handleOnTagDiscovered(call);
        break;

      case 'onError':
        _handleOnError(call);
        break;

      default:
        throw MissingPluginException(
          "Not implemented: ${call.method}");
    }
  }

  void _handleOnTagDiscovered(MethodCall call) {
    dataController.add(
        Map<String, dynamic>.from(
          call.arguments as Map));
  }

  void _handleOnError(MethodCall call) {
    _onError?.call(
      SessionError.fromMap(
        Map<String, dynamic>.from(
          call.arguments as Map)));
  }
}