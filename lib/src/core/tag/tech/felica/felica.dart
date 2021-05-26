part of core.tag;

/// The class provides access to `NFCFeliCaTag` API for iOS.
class Felica extends NFCTag {
  /// Constructs an instance with the given values for testing.
  ///
  /// The instances constructs by this way are not valid in
  /// the production environment.
  Felica._({
    @required NFCTagPlatform delegate,
    this.currentSystemCode,
    this.currentIDm,
  }) : super._(delegate);

  /// Get an instance of `Felica` for the given tag.
  ///
  /// Returns null if the tag is not compatible with `Felica`.
  factory Felica._from({
    @required NFCTagPlatform delegate,
  }) {
    if ( delegate.type.isNotFelica ) {
      return null;
    }

    final _data = Map<String, dynamic>.from(delegate.data);

    return Felica._(
      delegate: delegate,
      currentSystemCode: Uint8List.fromList(
        _data['currentSystemCode'] as List<int>),
      currentIDm: Uint8List.fromList(
        _data['currentIDm'] as List<int>));
  }

  /// The value from [NFCFeliCaTag#currentSystemCode] on iOS.
  final Uint8List currentSystemCode;

  /// The value from [NFCFeliCaTag#currentIDm] on iOS.
  final Uint8List currentIDm;

  /// Sends the `Polling` command to the tag.
  ///
  /// This uses [NFCFeliCaTag#polling] API on iOS.
  Future<FelicaPollingResponse> polling({
    Uint8List systemCode,
    FelicaPollingRequestCode requestCode,
    FelicaPollingTimeSlot timeSlot,
  }) =>
      channel.invokeMethod<Map>(
        "Felica", {
          'handle': handle,
          'method': 'polling',
          'systemCode': systemCode,
          'requestCode': requestCode.value,
          'timeSlot': timeSlot.value,
        })
        .then(
          (value) => _pollingResponse(
            Map<String, dynamic>.from(value)));

  FelicaPollingResponse _pollingResponse(Map<String, dynamic> arg) =>
      FelicaPollingResponse(
        manufacturerParameter: Uint8List.fromList(
          arg['manufacturerParameter'] as List<int>),
        requestData: Uint8List.fromList(
          arg['requestData'] as List<int>),
      );

  /// Sends the `Request Response` command to the tag.
  ///
  /// This uses [NFCFeliCaTag#requestResponse] API on iOS.
  Future<int> requestResponse() =>
      channel.invokeMethod(
        "Felica", {
          'handle': handle,
          'method': 'requestResponse',
        });

  /// Sends the `Request System Code` command to the tag.
  ///
  /// This uses [NFCFeliCaTag#requestSystemCode] API on iOS.
  Future<List<Uint8List>> requestSystemCode() =>
      channel.invokeMethod<List>(
        "Felica", {
          'handle': handle,
          'method': 'requestSystemCode',
        })
        .then(
          (value) => List.from(value));

  /// Sends the `Request Service` command to the tag.
  ///
  /// This uses [NFCFeliCaTag#requestService] API on iOS.
  Future<List<Uint8List>> requestService({
    List<Uint8List> nodeCodeList,
  }) =>
      channel.invokeMethod<List>(
        "Felica", {
          'handle': handle,
          'method': 'requestService',
          'nodeCodeList': nodeCodeList,
        })
        .then(
          (value) => List.from(value));

  /// Sends the `Request Service V2` command to the tag.
  ///
  /// This uses [NFCFeliCaTag#requestServiceV2] API on iOS.
  Future<FelicaRequestServiceV2Response> requestServiceV2({
    List<Uint8List> nodeCodeList,
  }) =>
      channel.invokeMethod<Map>(
        "Felica", {
          'handle': handle,
          'method': 'requestServiceV2',
          'nodeCodeList': nodeCodeList,
        })
        .then(
          (value) => _requestServiceV2Response(
            Map<String, dynamic>.from(value)));

  FelicaRequestServiceV2Response _requestServiceV2Response(
      Map<String, dynamic> arg) =>
    FelicaRequestServiceV2Response(
      statusFlag1: arg['statusFlag1'] as int,
      statusFlag2: arg['statusFlag2'] as int,
      encryptionIdentifier: arg['encryptionIdentifier'] as int,
      nodeKeyVersionListAes: List<Uint8List>.from(
        arg['nodeKeyVersionListAes'] as List),
      nodeKeyVersionListDes: List<Uint8List>.from(
        arg['nodeKeyVersionListDes'] as List),
    );

  /// Sends the `Read Without Encryption` command to the tag.
  ///
  /// This uses [NFCFeliCaTag#readWithoutEncryption] API on iOS.
  Future<FelicaReadWithoutEncryptionResponse> readWithoutEncryption({
    List<Uint8List> serviceCodeList,
    List<Uint8List> blockList,
  }) =>
      channel.invokeMethod<Map>(
        "Felica", {
          'handle': handle,
          'method': 'readWithoutEncryption',
          'serviceCodeList': serviceCodeList,
          'blockList': blockList,
        })
        .then(
          (value) => _readWithoutEncryptionResponse(
            Map<String, dynamic>.from(value)));

  FelicaReadWithoutEncryptionResponse _readWithoutEncryptionResponse(
      Map<String, dynamic> arg) =>
    FelicaReadWithoutEncryptionResponse(
      statusFlag1: arg['statusFlag1'] as int,
      statusFlag2: arg['statusFlag2'] as int,
      blockData: List<Uint8List>.from(
        arg['blockData'] as List),
    );

  /// Sends the `Write Without Encryption` command to the tag.
  ///
  /// This uses [NFCFeliCaTag#writeWithoutEncryption] API on iOS.
  Future<FelicaStatusFlag> writeWithoutEncryption({
    List<Uint8List> serviceCodeList,
    List<Uint8List> blockList,
    List<Uint8List> blockData,
  }) =>
      channel.invokeMethod<Map>(
        "Felica", {
          'handle': handle,
          'method': 'writeWithoutEncryption',
          'serviceCodeList': serviceCodeList,
          'blockList': blockList,
          'blockData': blockData,
        })
        .then(
          (value) => _statusFlag(
            Map<String, dynamic>.from(value)));

  FelicaStatusFlag _statusFlag(Map<String, dynamic> arg) =>
      FelicaStatusFlag(
        statusFlag1: arg['statusFlag1'] as int,
        statusFlag2: arg['statusFlag2'] as int,
      );

  /// Sends the `Request Specification Version` command to the tag.
  ///
  /// This uses [NFCFeliCaTag#requestSpecificationVersion] API on iOS.
  Future<FelicaRequestSpecificationVersionResponse>
      requestSpecificationVersion() =>
    channel.invokeMethod<Map>(
      "Felica", {
        'handle': handle,
        'method': 'requestSpecificationVersionResponse',
      })
      .then(
        (value) => _requestSpecificationVersionResponse(
          Map<String, dynamic>.from(value)));

  FelicaRequestSpecificationVersionResponse
      _requestSpecificationVersionResponse(Map<String, dynamic> arg) =>
    FelicaRequestSpecificationVersionResponse(
      statusFlag1: arg['statusFlag1'] as int,
      statusFlag2: arg['statusFlag2'] as int,
      basicVersion: Uint8List.fromList(
        arg['basicVersion'] as List<int>),
      optionVersion: Uint8List.fromList(
        arg['optionVersion'] as List<int>),
    );

  /// Sends the `Reset Mode` command to the tag.
  ///
  /// This uses [NFCFeliCaTag#resetMode] API on iOS.
  Future<FelicaStatusFlag> resetMode() =>
      channel.invokeMethod<Map>(
        "Felica", {
          'handle': handle,
          'method': 'resetMode',
        })
        .then(
          (value) => _statusFlag(
            Map<String, dynamic>.from(value)));

  /// Sends the `Felica` command packet data to the tag.
  ///
  /// This uses [NFCFeliCaTag#sendFeliCaCommand] API on iOS.
  Future<List<int>> sendCommand({
    @required Uint8List commandPacket,
  }) async {
    assert(
      commandPacket != null && commandPacket.isNotEmpty,
      'data cannot be null and empty');

      return Int8List.fromList(
        await channel.invokeMethod(
          "Felica", {
            'handle': handle,
            'method': 'sendCommand',
            'commandPacket': commandPacket,
          }))
          .toList();
    }

  @override
  String toString() =>
      "[Felica] "
      "currentSystemCode: ${currentSystemCode.toHexString()}, "
      "currentIDm: ${currentIDm.toHexString()}";
}