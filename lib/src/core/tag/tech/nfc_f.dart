part of core.tag;

/// The class provides access to `NfcF` API for Android.
class NfcF extends NFCTag {
  /// Constructs an instance with the given values for testing.
  ///
  /// The instances constructs by this way are not valid in
  /// the production environment.
  NfcF._({
    required NFCTagPlatform delegate,
    required this.identifier,
    required this.manufacturer,
    required this.systemCode,
    required this.maxTransceiveLength,
    required int timeout,
  }) :  _timeout = timeout,
        super._(delegate);

  /// Get an instance of `NfcF` for the given tag.
  ///
  /// Returns null if the tag is not compatible with `NfcF`.
  factory NfcF._from(
    Map<String, dynamic> _data, {
    required NFCTagPlatform delegate,
  }) => NfcF._(
          delegate: delegate,
          identifier: _data['identifier'],
          manufacturer: _data['manufacturer'],
          systemCode: _data['systemCode'],
          maxTransceiveLength: _data['maxTransceiveLength'],
          timeout: _data['timeout']);

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
    required Uint8List data,
    int? timeout,
  }) {
    timeout ??= _timeout;
    _timeout = timeout;

    return channel.invokeMethod(
      "transceive", {
        'handle': handle,
        'type': 'NfcF',
        'data': data,
        'timeout': timeout,
      })
      .then(
        (value) => Int8List.fromList(value!).toList());
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