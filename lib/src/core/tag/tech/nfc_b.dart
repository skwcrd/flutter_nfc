part of core.tag;

/// The class provides access to `NfcB` API for Android.
class NfcB extends NFCTag {
  /// Constructs an instance with the given values for testing.
  ///
  /// The instances constructs by this way are not valid in
  /// the production environment.
  NfcB._({
    required NFCTagPlatform delegate,
    required this.identifier,
    required this.applicationData,
    required this.protocolInfo,
    required this.maxTransceiveLength,
  }) : super._(delegate);

  /// Get an instance of `NfcB` for the given tag.
  ///
  /// Returns null if the tag is not compatible with `NfcB`.
  static NfcB? _from({
    required NFCTagPlatform delegate,
  }) {
    if ( delegate.type.isNotNfcB ) {
      return null;
    }

    final _data = Map<String, dynamic>.from(delegate.data);

    return NfcB._(
      delegate: delegate,
      identifier: _data['identifier'],
      applicationData: _data['applicationData'],
      protocolInfo: _data['protocolInfo'],
      maxTransceiveLength: _data['maxTransceiveLength']);
  }

  /// The value from [Tag#id] on Android.
  final Uint8List identifier;

  /// The value from [NfcB#applicationData] on Android.
  final Uint8List applicationData;

  /// The value from [NfcB#protocolInfo] on Android.
  final Uint8List protocolInfo;

  /// The value from [NfcB#maxTransceiveLength] on Android.
  final int maxTransceiveLength;

  /// Sends the `NfcB` command to the tag.
  ///
  /// This uses [NfcB#transceive] API on Android.
  Future<List<int>> transceive({
    required Uint8List data,
  }) =>
      channel.invokeMethod(
        "transceive", {
          'handle': handle,
          'type': 'NfcB',
          'data': data,
        })
        .then(
          (value) => Int8List.fromList(value!).toList());

  @override
  String toString() =>
      "[NfcB] "
      "identifier: ${identifier.toHexString()}, "
      "applicationData: ${applicationData.toHexString()}, "
      "protocolInfo: ${protocolInfo.toHexString()}, "
      "maxTransceiveLength: $maxTransceiveLength";
}