part of core.tag;

/// The class provides access to `NfcA` API for Android.
class NfcA extends NFCTag {
  /// Constructs an instance with the given values for testing.
  ///
  /// The instances constructs by this way are not valid in
  /// the production environment.
  NfcA._({
    @required NFCTagPlatform delegate,
    this.identifier,
    this.atqa,
    this.sak,
    this.maxTransceiveLength,
    int timeout,
  }) :  _timeout = timeout,
        super._(delegate);

  /// Get an instance of `NfcA` for the given tag.
  ///
  /// Returns null if the tag is not compatible with `NfcA`.
  factory NfcA._from({
    @required NFCTagPlatform delegate,
  }) {
    if ( delegate.type.isNotNfcA ) {
      return null;
    }

    final _data = Map<String, dynamic>.from(delegate.data);

    return NfcA._(
      delegate: delegate,
      identifier: Uint8List.fromList(
        _data['identifier'] as List<int>),
      atqa: Uint8List.fromList(
        _data['atqa'] as List<int>),
      sak: _data['sak'] as int,
      maxTransceiveLength: _data['maxTransceiveLength'] as int,
      timeout: _data['timeout'] as int);
  }

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
          'type': 'NfcA',
          'data': data,
          'timeout': timeout,
        }))
        .toList();
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