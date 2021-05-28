part of core.tag;

/// The class provides access to `NFCISO7816Tag` API for iOS.
class Iso7816 extends NFCTag {
  /// Constructs an instance with the given values for testing.
  ///
  /// The instances constructs by this way are not valid in
  /// the production environment.
  Iso7816._({
    required NFCTagPlatform delegate,
    required this.identifier,
    required this.initialSelectedAID,
    required this.historicalBytes,
    required this.applicationData,
    required this.proprietaryApplicationDataCoding,
  }) : super._(delegate);

  /// Get an instance of `Iso7816` for the given tag.
  ///
  /// Returns null if the tag is not compatible with `Iso7816`.
  factory Iso7816._from(
    Map<String, dynamic> _data, {
    required NFCTagPlatform delegate,
  }) => Iso7816._(
          delegate: delegate,
          identifier: _data['identifier'],
          historicalBytes: _data['historicalBytes'],
          applicationData: _data['applicationData'],
          initialSelectedAID: _data['initialSelectedAID'],
          proprietaryApplicationDataCoding:
              _data['proprietaryApplicationDataCoding']);

  /// The value from [NFCISO7816Tag#identifier] on iOS.
  final Uint8List identifier;

  /// The value from [NFCISO7816Tag#initialSelectedAID] on iOS.
  final String initialSelectedAID;

  /// The value from [NFCISO7816Tag#historicalBytes] on iOS.
  final Uint8List historicalBytes;

  /// The value from [NFCISO7816Tag#applicationData] on iOS.
  final Uint8List applicationData;

  /// The value from [NFCISO7816Tag#proprietaryApplicationDataCoding] on iOS.
  final bool proprietaryApplicationDataCoding;

  /// Sends the `APDU` to the tag.
  ///
  /// This uses [NFCISO7816Tag#sendCommand] API on iOS.
  Future<Iso7816ResponseApdu> sendCommand({
    required int instructionClass,
    required int instructionCode,
    required int p1Parameter,
    required int p2Parameter,
    required Uint8List data,
    required int expectedResponseLength,
  }) =>
      channel.invokeMethod(
        'Iso7816', {
          'handle': handle,
          'method': 'sendCommand',
          'instructionClass': instructionClass,
          'instructionCode': instructionCode,
          'p1Parameter': p1Parameter,
          'p2Parameter': p2Parameter,
          'data': data,
          'expectedResponseLength': expectedResponseLength,
        })
        .then(
          (value) => Iso7816ResponseApdu.fromMap(
            Map<String, dynamic>.from(value!)));

  /// Sends the `APDU` to the tag.
  ///
  /// This uses [NFCISO7816Tag#sendCommand] API on iOS.
  Future<Iso7816ResponseApdu> sendCommandRaw(Uint8List data) =>
      channel.invokeMethod(
        'Iso7816', {
          'handle': handle,
          'method': 'sendCommandRaw',
          'data': data,
        })
        .then(
          (value) => Iso7816ResponseApdu.fromMap(
            Map<String, dynamic>.from(value!)));

  @override
  String toString() =>
      "[Iso7816] "
      "identifier: ${identifier.toHexString()}, "
      "initialSelectedAID: $initialSelectedAID, "
      "historicalBytes: ${historicalBytes.toHexString()}, "
      "applicationData: ${applicationData.toHexString()}, "
      "proprietaryApplicationDataCoding: $proprietaryApplicationDataCoding";
}