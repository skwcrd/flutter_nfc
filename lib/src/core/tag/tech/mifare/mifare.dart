part of core.tag;

/// The class provides access to `NFCMiFareTag` API for iOS.
class Mifare extends NFCTag {
  /// Constructs an instance with the given values for testing.
  ///
  /// The instances constructs by this way are not valid in
  /// the production environment.
  Mifare._({
    @required NFCTagPlatform delegate,
    this.mifareFamily,
    this.identifier,
    this.historicalBytes,
  }) : super._(delegate);

  /// Get an instance of `Mifare` for the given tag.
  ///
  /// Returns null if the tag is not compatible with `Mifare`.
  factory Mifare._from({
    @required NFCTagPlatform delegate,
  }) {
    if ( delegate.type.isNotMifare ) {
      return null;
    }

    final _data = Map<String, dynamic>.from(delegate.data);

    return Mifare._(
      delegate: delegate,
      identifier: Uint8List.fromList(
        _data['identifier'] as List<int>),
      mifareFamily: MifareFamily.values
          .firstWhere(
            (e) => e.value == _data['mifareFamily']),
      historicalBytes: Uint8List.fromList(
        _data['historicalBytes'] as List<int>));
  }

  /// The value from [NFCMiFareTag#mifareFamily] on iOS.
  final MifareFamily mifareFamily;

  /// The value from [NFCMiFareTag#identifier] on iOS.
  final Uint8List identifier;

  /// The value from [NFCMiFareTag#historicalBytes] on iOS.
  final Uint8List historicalBytes;

  /// Sends the native `Mifare` command to the tag.
  ///
  /// This uses [NFCMiFareTag#sendMiFareCommand] API on iOS.
  Future<Uint8List> sendCommand(Uint8List commandPacket) =>
      channel.invokeMethod(
        "Mifare", {
          'handle': handle,
          'method': 'sendCommand',
          'commandPacket': commandPacket,
        });

  /// Sends the `ISO7816 APDU` to the tag.
  ///
  /// This uses [NFCMiFareTag#sendMiFareISO7816Command] API on iOS.
  Future<Iso7816ResponseApdu> sendIso7816Command({
    int instructionClass,
    int instructionCode,
    int p1Parameter,
    int p2Parameter,
    Uint8List data,
    int expectedResponseLength,
  }) =>
      channel.invokeMethod<Map>(
        "Mifare", {
          'handle': handle,
          'method': 'sendIso7816Command',
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

  /// Sends the `ISO7816 APDU` to the tag.
  ///
  /// This uses [NFCMiFareTag#sendMiFareISO7816Command] API on iOS.
  Future<Iso7816ResponseApdu> sendIso7816CommandRaw(
      Uint8List data) =>
    channel.invokeMethod<Map>(
      "Mifare", {
        'handle': handle,
        'method': 'sendIso7816CommandRaw',
        'data': data,
      })
      .then(
        (value) => Iso7816ResponseApdu.fromMap(
          Map<String, dynamic>.from(value)));

  @override
  String toString() =>
      "[Mifare] "
      "identifier: ${identifier.toHexString()}, "
      "mifareFamily: $mifareFamily, "
      "historicalBytes: ${historicalBytes.toHexString()}";
}