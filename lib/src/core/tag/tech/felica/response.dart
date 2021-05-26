part of core.tag;

/// The class represents the response of the `Polling` command.
class FelicaPollingResponse {
  /// Constructs an instance with the given values.
  const FelicaPollingResponse({
    this.manufacturerParameter,
    this.requestData,
  });

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
    this.statusFlag1,
    this.statusFlag2,
    this.basicVersion,
    this.optionVersion,
  });

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
    this.statusFlag1,
    this.statusFlag2,
    this.encryptionIdentifier,
    this.nodeKeyVersionListAes,
    this.nodeKeyVersionListDes,
  });

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
    this.statusFlag1,
    this.statusFlag2,
    this.blockData,
  });

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
    this.statusFlag1,
    this.statusFlag2,
  });

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