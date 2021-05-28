part of core.tag;

/// The class represents the response of the `Polling` command.
class FelicaPollingResponse {
  /// Constructs an instance with the given values.
  const FelicaPollingResponse({
    required this.manufacturerParameter,
    required this.requestData,
  });

  factory FelicaPollingResponse.fromMap(Map<String, dynamic> arg) =>
      FelicaPollingResponse(
        manufacturerParameter: arg['manufacturerParameter'],
        requestData: arg['requestData']);

  /// Manufacturer Parameter.
  final Uint8List manufacturerParameter;

  /// Request Data.
  final Uint8List requestData;

  @override
  String toString() =>
      "[Felica Polling Response] "
      "manufacturerParameter: ${manufacturerParameter.toHexString()}, "
      "requestData: ${requestData.toHexString()}";
}

/// The class represents the response of
/// the `Request Specification Version` command.
class FelicaRequestSpecificationVersionResponse {
  /// Constructs an instance with the given values.
  const FelicaRequestSpecificationVersionResponse({
    required this.statusFlag1,
    required this.statusFlag2,
    required this.basicVersion,
    required this.optionVersion,
  });

  factory FelicaRequestSpecificationVersionResponse.fromMap(
      Map<String, dynamic> arg) =>
    FelicaRequestSpecificationVersionResponse(
      statusFlag1: arg['statusFlag1'],
      statusFlag2: arg['statusFlag2'],
      basicVersion: arg['basicVersion'],
      optionVersion: arg['optionVersion']);

  /// Status Flag 1.
  final int statusFlag1;

  /// Status Flag 2.
  final int statusFlag2;

  /// Basic Version.
  final Uint8List basicVersion;

  /// Option Version.
  final Uint8List optionVersion;

  @override
  String toString() =>
      "[Felica Request Specification Version Response] "
      "statusFlag1: $statusFlag1, "
      "statusFlag2: $statusFlag2, "
      "basicVersion: ${basicVersion.toHexString()}, "
      "optionVersion: ${optionVersion.toHexString()}";
}

/// The class represents the response of
/// the `Request Service V2` command.
class FelicaRequestServiceV2Response {
  /// Constructs an instance with the given values.
  const FelicaRequestServiceV2Response({
    required this.statusFlag1,
    required this.statusFlag2,
    required this.encryptionIdentifier,
    required this.nodeKeyVersionListAes,
    required this.nodeKeyVersionListDes,
  });

  factory FelicaRequestServiceV2Response.fromMap(Map<String, dynamic> arg) =>
      FelicaRequestServiceV2Response(
        statusFlag1: arg['statusFlag1'],
        statusFlag2: arg['statusFlag2'],
        encryptionIdentifier: arg['encryptionIdentifier'],
        nodeKeyVersionListAes:
            List<Uint8List>.from(arg['nodeKeyVersionListAes']),
        nodeKeyVersionListDes:
            List<Uint8List>.from(arg['nodeKeyVersionListDes']));

  /// Status Flag 1.
  final int statusFlag1;

  /// Status Flag 2.
  final int statusFlag2;

  /// Encryption Identifier.
  final int encryptionIdentifier;

  /// Node Key Version List AES.
  final List<Uint8List> nodeKeyVersionListAes;

  /// Node Key Version List DES.
  final List<Uint8List> nodeKeyVersionListDes;

  @override
  String toString() =>
      "[Felica Request Service V2 Response] "
      "statusFlag1: $statusFlag1, "
      "statusFlag2: $statusFlag2, "
      "encryptionIdentifier: $encryptionIdentifier, "
      "nodeKeyVersionListAes: [ ${nodeKeyVersionListAes.map((d) => d.toHexString()).join(', ')} ], "
      "nodeKeyVersionListDes: [ ${nodeKeyVersionListDes.map((d) => d.toHexString()).join(', ')} ]";
}

/// The class represents the response of
/// the `Read Without Encryption` command.
class FelicaReadWithoutEncryptionResponse {
  /// Constructs an instance with the given values.
  const FelicaReadWithoutEncryptionResponse({
    required this.statusFlag1,
    required this.statusFlag2,
    required this.blockData,
  });

  factory FelicaReadWithoutEncryptionResponse.fromMap(
      Map<String, dynamic> arg) =>
    FelicaReadWithoutEncryptionResponse(
      statusFlag1: arg['statusFlag1'],
      statusFlag2: arg['statusFlag2'],
      blockData: List<Uint8List>.from(arg['blockData']));

  /// Status Flag 1.
  final int statusFlag1;

  /// Status Flag 2.
  final int statusFlag2;

  /// Block Data.
  final List<Uint8List> blockData;

  @override
  String toString() =>
      "[Felica Read Without Encryption Response] "
      "statusFlag1: $statusFlag1, "
      "statusFlag2: $statusFlag2, "
      "blockData: [ ${blockData.map((d) => d.toHexString()).join(', ')} ]";
}

/// The class represents the `Status Flags` of the command.
class FelicaStatusFlag {
  /// Constructs an instance with the given values.
  const FelicaStatusFlag({
    required this.statusFlag1,
    required this.statusFlag2,
  });

  factory FelicaStatusFlag.fromMap(Map<String, dynamic> arg) =>
      FelicaStatusFlag(
        statusFlag1: arg['statusFlag1'],
        statusFlag2: arg['statusFlag2']);

  /// Status Flag 1.
  final int statusFlag1;

  /// Status Flag 2.
  final int statusFlag2;

  @override
  String toString() =>
      "[Felica Status Flag] "
      "statusFlag1: $statusFlag1, "
      "statusFlag2: $statusFlag2";
}