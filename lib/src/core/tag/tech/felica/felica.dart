part of core.tag;

/// The class provides access to `NFCFeliCaTag` API for iOS.
class Felica extends NFCTag {
  /// Constructs an instance with the given values for testing.
  ///
  /// The instances constructs by this way are not valid in
  /// the production environment.
  Felica._({
    required NFCTagPlatform delegate,
    required this.currentSystemCode,
    required this.currentIDm,
  }) : super._(delegate);

  /// Get an instance of `Felica` for the given tag.
  ///
  /// Returns null if the tag is not compatible with `Felica`.
  static Felica? _from({
    required NFCTagPlatform delegate,
  }) {
    if ( delegate.type.isNotFelica ) {
      return null;
    }

    final _data = Map<String, dynamic>.from(delegate.data);

    return Felica._(
      delegate: delegate,
      currentSystemCode: _data['currentSystemCode'],
      currentIDm: _data['currentIDm']);
  }

  /// The value from [NFCFeliCaTag#currentSystemCode] on iOS.
  final Uint8List currentSystemCode;

  /// The value from [NFCFeliCaTag#currentIDm] on iOS.
  final Uint8List currentIDm;

  /// Sends the `Polling` command to the tag.
  ///
  /// This uses [NFCFeliCaTag#polling] API on iOS.
  Future<FelicaPollingResponse> polling({
    required Uint8List systemCode,
    required FelicaPollingRequestCode requestCode,
    required FelicaPollingTimeSlot timeSlot,
  }) =>
      channel.invokeMethod(
        "Felica", {
          'handle': handle,
          'method': 'polling',
          'systemCode': systemCode,
          'requestCode': requestCode.value,
          'timeSlot': timeSlot.value,
        })
        .then(
          (value) => FelicaPollingResponse.fromMap(
            Map<String, dynamic>.from(value!)));

  /// Sends the `Request Response` command to the tag.
  ///
  /// This uses [NFCFeliCaTag#requestResponse] API on iOS.
  Future<int> requestResponse() =>
      channel.invokeMethod(
        "Felica", {
          'handle': handle,
          'method': 'requestResponse',
        })
        .then((value) => value!);

  /// Sends the `Request System Code` command to the tag.
  ///
  /// This uses [NFCFeliCaTag#requestSystemCode] API on iOS.
  Future<List<Uint8List>> requestSystemCode() =>
      channel.invokeMethod(
        "Felica", {
          'handle': handle,
          'method': 'requestSystemCode',
        })
        .then(
          (value) => List<Uint8List>.from(value!));

  /// Sends the `Request Service` command to the tag.
  ///
  /// This uses [NFCFeliCaTag#requestService] API on iOS.
  Future<List<Uint8List>> requestService({
    required List<Uint8List> nodeCodeList,
  }) =>
      channel.invokeMethod(
        "Felica", {
          'handle': handle,
          'method': 'requestService',
          'nodeCodeList': nodeCodeList,
        })
        .then(
          (value) => List<Uint8List>.from(value!));

  /// Sends the `Request Service V2` command to the tag.
  ///
  /// This uses [NFCFeliCaTag#requestServiceV2] API on iOS.
  Future<FelicaRequestServiceV2Response> requestServiceV2({
    required List<Uint8List> nodeCodeList,
  }) =>
      channel.invokeMethod(
        "Felica", {
          'handle': handle,
          'method': 'requestServiceV2',
          'nodeCodeList': nodeCodeList,
        })
        .then(
          (value) => FelicaRequestServiceV2Response.fromMap(
            Map<String, dynamic>.from(value!)));

  /// Sends the `Read Without Encryption` command to the tag.
  ///
  /// This uses [NFCFeliCaTag#readWithoutEncryption] API on iOS.
  Future<FelicaReadWithoutEncryptionResponse> readWithoutEncryption({
    required List<Uint8List> serviceCodeList,
    required List<Uint8List> blockList,
  }) =>
      channel.invokeMethod(
        "Felica", {
          'handle': handle,
          'method': 'readWithoutEncryption',
          'serviceCodeList': serviceCodeList,
          'blockList': blockList,
        })
        .then(
          (value) => FelicaReadWithoutEncryptionResponse.fromMap(
            Map<String, dynamic>.from(value!)));

  /// Sends the `Write Without Encryption` command to the tag.
  ///
  /// This uses [NFCFeliCaTag#writeWithoutEncryption] API on iOS.
  Future<FelicaStatusFlag> writeWithoutEncryption({
    required List<Uint8List> serviceCodeList,
    required List<Uint8List> blockList,
    required List<Uint8List> blockData,
  }) =>
      channel.invokeMethod(
        "Felica", {
          'handle': handle,
          'method': 'writeWithoutEncryption',
          'serviceCodeList': serviceCodeList,
          'blockList': blockList,
          'blockData': blockData,
        })
        .then(
          (value) => FelicaStatusFlag.fromMap(
            Map<String, dynamic>.from(value!)));

  /// Sends the `Request Specification Version` command to the tag.
  ///
  /// This uses [NFCFeliCaTag#requestSpecificationVersion] API on iOS.
  Future<FelicaRequestSpecificationVersionResponse>
      requestSpecificationVersion() =>
    channel.invokeMethod(
      "Felica", {
        'handle': handle,
        'method': 'requestSpecificationVersionResponse',
      })
      .then(
        (value) => FelicaRequestSpecificationVersionResponse.fromMap(
          Map<String, dynamic>.from(value!)));

  /// Sends the `Reset Mode` command to the tag.
  ///
  /// This uses [NFCFeliCaTag#resetMode] API on iOS.
  Future<FelicaStatusFlag> resetMode() =>
      channel.invokeMethod(
        "Felica", {
          'handle': handle,
          'method': 'resetMode',
        })
        .then(
          (value) => FelicaStatusFlag.fromMap(
            Map<String, dynamic>.from(value!)));

  /// Sends the `Felica` command packet data to the tag.
  ///
  /// This uses [NFCFeliCaTag#sendFeliCaCommand] API on iOS.
  Future<List<int>> sendCommand({
    required Uint8List commandPacket,
  }) =>
      channel.invokeMethod(
        "Felica", {
          'handle': handle,
          'method': 'sendCommand',
          'commandPacket': commandPacket,
        })
        .then(
          (value) => Int8List.fromList(value!).toList());

  @override
  String toString() =>
      "[Felica] "
      "currentSystemCode: ${currentSystemCode.toHexString()}, "
      "currentIDm: ${currentIDm.toHexString()}";
}