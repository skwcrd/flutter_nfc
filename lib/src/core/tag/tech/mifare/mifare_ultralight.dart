part of core.tag;

/// The class provides access to `MifareUltralight` API for Android.
class MifareUltralight extends NFCTag {
  /// Constructs an instance with the given values for testing.
  ///
  /// The instances constructs by this way are not valid in
  /// the production environment.
  MifareUltralight._({
    required NFCTagPlatform delegate,
    required this.identifier,
    required this.type,
    required this.maxTransceiveLength,
    required int timeout,
  }) :  _timeout = timeout,
        super._(delegate);

  /// Get an instance of `MifareUltralight` for the given tag.
  ///
  /// Returns null if the tag is not compatible with `MifareUltralight`.
  factory MifareUltralight._from(
    Map<String, dynamic> _data, {
    required NFCTagPlatform delegate,
  }) => MifareUltralight._(
          delegate: delegate,
          identifier: _data['identifier'],
          type: _data['type'],
          maxTransceiveLength: _data['maxTransceiveLength'],
          timeout: _data['timeout']);

  /// The value from [Tag#id] on Android.
  final Uint8List identifier;

  /// The value from [MifareUltralight#type] on Android.
  final int type;

  /// The value from [MifareUltralight#maxTransceiveLength] on Android.
  final int maxTransceiveLength;

  int _timeout;

  /// The value from [MifareUltralight#timeout] on Android.
  int get timeout => _timeout;

  /// Sends the `Read Pages` command to the tag.
  ///
  /// This uses [MifareUltralight#readPages] API on Android.
  Future<Uint8List> readPages({
    required int pageOffset,
  }) =>
      channel.invokeMethod(
        "MifareUltralight", {
          'handle': handle,
          'method': 'readPages',
          'pageOffset': pageOffset,
        })
        .then((value) => value!);

  /// Sends the `Write Page` command to the tag.
  ///
  /// This uses [MifareUltralight#writePage] API on Android.
  Future<void> writePage({
    required int pageOffset,
    required Uint8List data,
  }) =>
      channel.invokeMethod(
        "MifareUltralight", {
          'handle': handle,
          'method': 'writePage',
          'pageOffset': pageOffset,
          'data': data,
        });

  /// Sends the `MifareUltralight` command to the tag.
  ///
  /// This uses [MifareUltralight#transceive] API on Android.
  /// This is equivalent to obtaining via `NfcA` this tag
  /// and calling `NfcA#transceive`.
  Future<List<int>> transceive({
    required Uint8List data,
    int? timeout,
  }) {
    timeout ??= _timeout;
    _timeout = timeout;

    return channel.invokeMethod(
      "MifareUltralight", {
        'handle': handle,
        'method': 'transceive',
        'data': data,
        'timeout': timeout,
      })
      .then(
        (value) => Int8List.fromList(value!).toList());
  }

  @override
  String toString() =>
      "[Mifare Ultralight] "
      "identifier: ${identifier.toHexString()}, "
      "type: $type, "
      "maxTransceiveLength: $maxTransceiveLength, "
      "timeout: $timeout";
}