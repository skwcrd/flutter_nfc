part of core.tag;

/// The class provides access to `IsoDep` API for Android.
class IsoDep extends NFCTag {
  /// Constructs an instance with the given values for testing.
  ///
  /// The instances constructs by this way are not valid in
  /// the production environment.
  IsoDep._({
    required NFCTagPlatform delegate,
    required this.identifier,
    required this.hiLayerResponse,
    required this.historicalBytes,
    required this.isExtendedLengthApduSupported,
    required this.maxTransceiveLength,
    required int timeout,
  }) :  _timeout = timeout,
        super._(delegate);

  /// Get an instance of `IsoDep` for the given tag.
  ///
  /// Returns null if the tag is not compatible with `IsoDep`.
  static IsoDep? _from({
    required NFCTagPlatform delegate,
  }) {
    if ( delegate.type.isNotIsoDep ) {
      return null;
    }

    final _data = Map<String, dynamic>.from(delegate.data);

    return IsoDep._(
      delegate: delegate,
      identifier: _data['identifier'],
      hiLayerResponse: _data['hiLayerResponse'],
      historicalBytes: _data['historicalBytes'],
      isExtendedLengthApduSupported: _data['isExtendedLengthApduSupported'],
      maxTransceiveLength: _data['maxTransceiveLength'],
      timeout: _data['timeout']);
  }

  /// The value from [Tag#id] on Android.
  final Uint8List identifier;

  /// The value from [IsoDep#hiLayerResponse] on Android.
  final Uint8List hiLayerResponse;

  /// The value from [IsoDep#historicalBytes] on Android.
  final Uint8List historicalBytes;

  /// The value from [IsoDep#isExtendedLengthApduSupported] on Android.
  final bool isExtendedLengthApduSupported;

  /// The value from [IsoDep#maxTransceiveLength] on Android.
  final int maxTransceiveLength;

  int _timeout;

  /// The value from [IsoDep#timeout] on Android.
  int get timeout => _timeout;

  /// Sends the `IsoDep` command to the tag.
  ///
  /// This uses [IsoDep#transceive] API on Android.
  Future<List<int>> transceive({
    required Uint8List data,
    int? timeout,
  }) {
    timeout ??= _timeout;
    _timeout = timeout;

    return channel.invokeMethod(
      "transceive", {
        'handle': handle,
        'type': 'IsoDep',
        'data': data,
        'timeout': timeout,
      })
      .then(
        (value) => Int8List.fromList(value!).toList());
  }

  @override
  String toString() =>
      "[IsoDep] "
      "identifier: ${identifier.toHexString()}, "
      "hiLayerResponse: ${hiLayerResponse.toHexString()}, "
      "historicalBytes: ${historicalBytes.toHexString()}, "
      "isExtendedLengthApduSupported: $isExtendedLengthApduSupported, "
      "maxTransceiveLength: $maxTransceiveLength, "
      "timeout: $timeout";
}