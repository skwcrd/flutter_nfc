part of core.tag;

/// The class provides access to `NFCISO7816Tag` API for iOS.
class Iso7816 extends NFCTag {
  /// Constructs an instance with the given values for testing.
  ///
  /// The instances constructs by this way are not valid in
  /// the production environment.
  Iso7816._({
    @required NFCTagPlatform delegate,
    this.identifier,
    this.initialSelectedAID,
    this.historicalBytes,
    this.applicationData,
    this.proprietaryApplicationDataCoding,
  }) : super._(delegate);

  /// Get an instance of `Iso7816` for the given tag.
  ///
  /// Returns null if the tag is not compatible with `Iso7816`.
  factory Iso7816._from({
    @required NFCTagPlatform delegate,
  }) {
    if ( delegate.type.isNotIso7816 ) {
      return null;
    }

    final _data = Map<String, dynamic>.from(delegate.data);

    return Iso7816._(
      delegate: delegate,
      identifier: Uint8List.fromList(
        _data['identifier'] as List<int>),
      historicalBytes: Uint8List.fromList(
        _data['historicalBytes'] as List<int>),
      applicationData: Uint8List.fromList(
        _data['applicationData'] as List<int>),
      initialSelectedAID: _data['initialSelectedAID']?.toString(),
      proprietaryApplicationDataCoding:
          _data['proprietaryApplicationDataCoding'] as bool);
  }

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
    int instructionClass,
    int instructionCode,
    int p1Parameter,
    int p2Parameter,
    Uint8List data,
    int expectedResponseLength,
  }) =>
      channel.invokeMethod<Map>(
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
            Map<String, dynamic>.from(value)));

  /// Sends the `APDU` to the tag.
  ///
  /// This uses [NFCISO7816Tag#sendCommand] API on iOS.
  Future<Iso7816ResponseApdu> sendCommandRaw(Uint8List data) =>
      channel.invokeMethod<Map>(
        'Iso7816', {
          'handle': handle,
          'method': 'sendCommandRaw',
          'data': data,
        })
        .then(
          (value) => Iso7816ResponseApdu.fromMap(
            Map<String, dynamic>.from(value)));

  @override
  String toString() =>
      "[Iso7816] "
      "identifier: ${identifier.toHexString()}, "
      "initialSelectedAID: $initialSelectedAID, "
      "historicalBytes: ${historicalBytes.toHexString()}, "
      "applicationData: ${applicationData.toHexString()}, "
      "proprietaryApplicationDataCoding: $proprietaryApplicationDataCoding";
}