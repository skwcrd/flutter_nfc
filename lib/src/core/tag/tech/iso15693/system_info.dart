part of core.tag;

/// The class represents the response of the `Get System Info` command.
class Iso15693SystemInfo {
  /// Constructs an instance with the given values.
  const Iso15693SystemInfo({
    this.applicationFamilyIdentifier,
    this.blockSize,
    this.dataStorageFormatIdentifier,
    this.icReference,
    this.totalBlocks,
  });

  factory Iso15693SystemInfo.fromMap(Map<String, dynamic> arg) =>
      Iso15693SystemInfo(
        dataStorageFormatIdentifier:
            arg['dataStorageFormatIdentifier'] as int,
        applicationFamilyIdentifier:
            arg['applicationFamilyIdentifier'] as int,
        blockSize: arg['blockSize'] as int,
        totalBlocks: arg['totalBlocks'] as int,
        icReference: arg['icReference'] as int);

  /// Application Family Identifier.
  final int applicationFamilyIdentifier;

  /// Block Size.
  final int blockSize;

  /// Data Storage Format Identifier.
  final int dataStorageFormatIdentifier;

  // IC Reference.
  final int icReference;

  /// Total Blocks.
  final int totalBlocks;

  @override
  String toString() =>
      "[Iso15693 System Info] "
      "applicationFamilyIdentifier: $applicationFamilyIdentifier, "
      "dataStorageFormatIdentifier: $dataStorageFormatIdentifier, "
      "blockSize: $blockSize, "
      "icReference: $icReference, "
      "totalBlocks: $totalBlocks";
}