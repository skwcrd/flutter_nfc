part of core.tag;

/// The class provides access to `NfcA` API for Android.
class NfcA extends NFCTag {
  /// Constructs an instance with the given values for testing.
  ///
  /// The instances constructs by this way are not valid in
  /// the production environment.
  NfcA._({
    required NFCTagPlatform delegate,
    required this.identifier,
    required this.atqa,
    required this.sak,
    required this.maxTransceiveLength,
    required int timeout,
  }) :  _timeout = timeout,
        super._(delegate);

  /// Get an instance of `NfcA` for the given tag.
  ///
  /// Returns null if the tag is not compatible with `NfcA`.
  factory NfcA._from(
    Map<String, dynamic> _data, {
    required NFCTagPlatform delegate,
  }) => NfcA._(
          delegate: delegate,
          identifier: _data['identifier'],
          atqa: _data['atqa'],
          sak: _data['sak'],
          maxTransceiveLength: _data['maxTransceiveLength'],
          timeout: _data['timeout']);

  /// The value from [Tag#id] on Android.
  final Uint8List identifier;

  /// The value from [NfcA#atqa] on Android.
  final Uint8List atqa;

  /// The value from [NfcA#sak] on Android.
  final int sak;

  /// The value from [NfcA#maxTransceiveLength] on Android.
  final int maxTransceiveLength;

  int _timeout;

  /// The value from [NfcA#timeout] on Android.
  int get timeout => _timeout;

  /// Sends the `NfcA` command to the tag.
  ///
  /// This uses [NfcA#transceive] API on Android.
  Future<List<int>> transceive({
    required Uint8List data,
    int? timeout,
  }) {
    timeout ??= _timeout;
    _timeout = timeout;

    return channel.invokeMethod(
      "transceive", {
        'handle': handle,
        'type': 'NfcA',
        'data': data,
        'timeout': timeout,
      })
      .then(
        (value) => Int8List.fromList(value!).toList());
  }

  @override
  String toString() =>
      "[NfcA] "
      "identifier: ${identifier.toHexString()}, "
      "atqa: ${atqa.toHexString()}, "
      "sak: $sak, "
      "maxTransceiveLength: $maxTransceiveLength, "
      "timeout: $timeout";
}