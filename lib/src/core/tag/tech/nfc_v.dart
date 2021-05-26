part of core.tag;

/// The class provides access to `NfcV` API for Android.
class NfcV extends NFCTag {
  /// Constructs an instance with the given values for testing.
  ///
  /// The instances constructs by this way are not valid in
  /// the production environment.
  NfcV._({
    required NFCTagPlatform delegate,
    required this.identifier,
    required this.dsfId,
    required this.responseFlags,
    required this.maxTransceiveLength,
  }) : super._(delegate);

  /// Get an instance of `NfcV` for the given tag.
  ///
  /// Returns null if the tag is not compatible with `NfcV`.
  static NfcV? _from({
    required NFCTagPlatform delegate,
  }) {
    if ( delegate.type.isNotNfcV ) {
      return null;
    }

    final _data = Map<String, dynamic>.from(delegate.data);

    return NfcV._(
      delegate: delegate,
      identifier: _data['identifier'],
      dsfId: _data['dsfId'],
      responseFlags: _data['responseFlags'],
      maxTransceiveLength: _data['maxTransceiveLength']);
  }

  /// The value from [Tag#id] on Android.
  final Uint8List identifier;

  /// The value from [NfcV#dsfId] on Android.
  final int dsfId;

  /// The value from [NfcV#responseFlags] on Android.
  final int responseFlags;

  /// The value from [NfcV#maxTransceiveLength] on Android.
  final int maxTransceiveLength;

  /// Sends the `NfcV` command to the tag.
  ///
  /// This uses [NfcV#transceive] API on Android.
  Future<List<int>> transceive({
    required Uint8List data,
  }) =>
      channel.invokeMethod(
        "transceive", {
          'handle': handle,
          'type': 'NfcV',
          'data': data,
        })
        .then(
          (value) => Int8List.fromList(value!).toList());

  @override
  String toString() =>
      "[NfcV] "
      "identifier: ${identifier.toHexString()}, "
      "dsfId: $dsfId, "
      "responseFlags: $responseFlags, "
      "maxTransceiveLength: $maxTransceiveLength";
}