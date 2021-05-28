part of core.tag;

/// The class represents the response of the `Get System Info` command.
class Iso15693SystemInfo {
  /// Constructs an instance with the given values.
  const Iso15693SystemInfo({
    required this.applicationFamilyIdentifier,
    required this.blockSize,
    required this.dataStorageFormatIdentifier,
    required this.icReference,
    required this.totalBlocks,
  });

  factory Iso15693SystemInfo.fromMap(Map<String, dynamic> arg) =>
      Iso15693SystemInfo(
        dataStorageFormatIdentifier:
            arg['dataStorageFormatIdentifier'],
        applicationFamilyIdentifier:
            arg['applicationFamilyIdentifier'],
        blockSize: arg['blockSize'],
        totalBlocks: arg['totalBlocks'],
        icReference: arg['icReference']);

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