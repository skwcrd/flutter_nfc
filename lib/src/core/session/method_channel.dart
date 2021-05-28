part of core.session;

class _MethodChannelNFCSession extends NFCPlatform {
  _MethodChannelNFCSession._() : super._() {
    channel.setMethodCallHandler(_handleMethodCall);
  }

  /// Returns a stub instance to allow the platform interface
  /// to access the class instance statically.
  // ignore: prefer_constructors_over_static_methods
  static _MethodChannelNFCSession get instance =>
      _MethodChannelNFCSession._();

  static NFCPlatform? _methodChannelNFCInstance;

  @override
  NFCPlatform delegate() =>
      _methodChannelNFCInstance ??= _MethodChannelNFCSession._();

  TagCallback? _onTag;
  ErrorCallback? _onError;

  @override
  Future<bool> isAvailable() =>
      channel
        .invokeMethod("isAvailable")
        .then((value) => value!);

  @override
  Future<void> openSetting() =>
      channel.invokeMethod("openSetting");

  @override
  Future<void> startSession({
    required TagCallback onTagDiscovered,
    required Set<NFCTagPollingOption> pollingOption,
    String? alertMessage,
    ErrorCallback? onError,
  }) {
    _onTag = onTagDiscovered;
    _onError = onError;

    return channel.invokeMethod(
      "startSession", {
        'pollingOption': pollingOption.map((tag) => tag.value).toList(),
        'alertMessage': alertMessage,
      });
  }

  @override
  Future<void> stopSession({
    String? errorMessage,
    String? alertMessage,
  }) async {
    _onTag = null;
    _onError = null;

    return channel.invokeMethod(
      "stopSession", {
        'errorMessage': errorMessage,
        'alertMessage': alertMessage,
      });
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
    final _tag = NFCTag.instanceFor(
      delegate: NFCTagPlatform.instanceFor(
        data: Map<String, dynamic>.from(call.arguments as Map),
      ));

    _onTag?.call(_tag);
  }

  void _handleOnError(MethodCall call) {
    final _error = SessionError.fromMap(
      Map<String, dynamic>.from(call.arguments as Map));

    _onError?.call(_error);
  }
}