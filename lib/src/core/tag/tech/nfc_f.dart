part of core.tag;

/// The class provides access to `NfcF` API for Android.
class NfcF extends NFCTag {
  /// Constructs an instance with the given values for testing.
  ///
  /// The instances constructs by this way are not valid in
  /// the production environment.
  NfcF._({
    @required NFCTagPlatform delegate,
    this.identifier,
    this.manufacturer,
    this.systemCode,
    this.maxTransceiveLength,
    int timeout,
  }) :  _timeout = timeout,
        super._(delegate);

  /// Get an instance of `NfcF` for the given tag.
  ///
  /// Returns null if the tag is not compatible with `NfcF`.
  factory NfcF._from({
    @required NFCTagPlatform delegate,
  }) {
    if ( delegate.type.isNotNfcF ) {
      return null;
    }

    final _data = Map<String, dynamic>.from(delegate.data);

    return NfcF._(
      delegate: delegate,
      identifier: Uint8List.fromList(
        _data['identifier'] as List<int>),
      manufacturer: Uint8List.fromList(
        _data['manufacturer'] as List<int>),
      systemCode: Uint8List.fromList(
        _data['systemCode'] as List<int>),
      maxTransceiveLength: _data['maxTransceiveLength'] as int,
      timeout: _data['timeout'] as int);
  }

  /// The value from [Tag#id] on Android.
  final Uint8List identifier;

  /// The value from [NfcF#manufacturer] on Android.
  final Uint8List manufacturer;

  /// The value from [NfcF#systemCode] on Android.
  final Uint8List systemCode;

  /// The value from [NfcF#maxTransceiveLength] on Android.
  final int maxTransceiveLength;

  int _timeout;

  /// The value from [NfcF#timeout] on Android.
  int get timeout => _timeout;

  /// Sends the `NfcF` command to the tag.
  ///
  /// This uses [NfcF#transceive] API on Android.
  Future<List<int>> transceive({
    @required Uint8List data,
    int timeout,
  }) async {
    assert(
      data != null && data.isNotEmpty,
      'data cannot be null and empty');

    timeout ??= _timeout;
    _timeout = timeout;

    return Int8List.fromList(
      await channel.invokeMethod(
        "transceive", {
          'handle': handle,
          'type': 'NfcF',
          'data': data,
          'timeout': timeout,
        }))
        .toList();
  }

  @override
  String toString() =>
      "[NfcF] "
      "identifier: ${identifier.toHexString()}, "
      "manufacturer: ${manufacturer.toHexString()}, "
      "systemCode: ${systemCode.toHexString()}, "
      "maxTransceiveLength: $maxTransceiveLength, "
      "timeout: $timeout";
}