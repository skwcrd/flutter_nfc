part of core.tag;

class MethodChannelNFCTag extends NFCTagPlatform {
  MethodChannelNFCTag._({
    @required Map<String, dynamic> data,
  }) : super(data: data);

  String _handle;
  String _type;

  /// Returns a stub instance to allow the platform interface
  /// to access the class instance statically.
  // ignore: prefer_constructors_over_static_methods
  static MethodChannelNFCTag get instance =>
      MethodChannelNFCTag._(data: null);

  static NFCTagPlatform _methodChannelNFCTagInstance;

  @override
  NFCTagPlatform delegate({
    @required Map<String, dynamic> data,
  }) {
    if ( _methodChannelNFCTagInstance == null ) {
      _handle = data.remove('handle').toString();
      _type = data.remove('type').toString();

      _methodChannelNFCTagInstance = MethodChannelNFCTag._(
        data: Map<String, dynamic>.from(data['data'] as Map));
    }

    return _methodChannelNFCTagInstance;
  }

  @override
  Future<void> disposeTag() async {
    try {
      return channel.invokeMethod(
        "disposeTag", {
          'handle': _handle,
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

  @override
  Future<List<int>> transceive({
    @required Uint8List data,
    int timeout,
  }) async {
    assert(
      data != null && data.isNotEmpty,
      'data cannot be null and empty');

    try {
      final _recv = Int8List.fromList(
        await channel.invokeMethod(
          "transceive", {
            'type': _type,
            'handle': _handle,
            'data': data ?? <int>[],
            'timeout': timeout,
          }));

      return _recv.toList();
    } catch (error, stackTrace) {
      throw PlatformException(
        code: "transceive",
        message: "NFC features are not communication NFC tag",
        details: error,
        stacktrace: stackTrace?.toString()
          ?? StackTrace.current.toString());
    }
  }
}