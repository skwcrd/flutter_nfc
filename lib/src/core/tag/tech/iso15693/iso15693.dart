part of core.tag;

/// The class provides access to `NFCISO15693Tag` API for iOS.
class Iso15693 extends NFCTag {
  /// Constructs an instance with the given values for testing.
  ///
  /// The instances constructs by this way are not valid in
  /// the production environment.
  Iso15693._({
    required NFCTagPlatform delegate,
    required this.identifier,
    required this.icManufacturerCode,
    required this.icSerialNumber,
  }) : super._(delegate);

  /// Get an instance of `Iso15693` for the given tag.
  ///
  /// Returns null if the tag is not compatible with `Iso15693`.
  factory Iso15693._from(
    Map<String, dynamic> _data, {
    required NFCTagPlatform delegate,
  }) => Iso15693._(
          delegate: delegate,
          identifier: _data['identifier'],
          icManufacturerCode: _data['icManufacturerCode'],
          icSerialNumber: _data['icSerialNumber']);

  /// The value from [NFCISO15693Tag#identifier] on iOS.
  final Uint8List identifier;

  /// The value from [NFCISO15693Tag#icManufacturerCode] on iOS.
  final int icManufacturerCode;

  /// The value from [NFCISO15693Tag#icSerialNumber] on iOS.
  final Uint8List icSerialNumber;

  /// Sends the `Read Single Block` command to the tag.
  ///
  /// This uses [NFCISO15693Tag#readSingleBlock] API on iOS.
  Future<Uint8List> readSingleBlock({
    required Set<Iso15693RequestFlag> requestFlags,
    required int blockNumber,
  }) =>
      channel.invokeMethod(
        "Iso15693", {
          'handle': handle,
          'method': 'readSingleBlock',
          'requestFlags': requestFlags.map((e) => e.value).toList(),
          'blockNumber': blockNumber.toUnsigned(8),
        })
        .then((value) => value!);

  /// Sends the `Write Single Block` command to the tag.
  ///
  /// This uses [NFCISO15693Tag#writeSingleBlock] API on iOS.
  Future<void> writeSingleBlock({
    required Set<Iso15693RequestFlag> requestFlags,
    required int blockNumber,
    required Uint8List dataBlock,
  }) =>
      channel.invokeMethod(
        "Iso15693", {
          'handle': handle,
          'method': 'writeSingleBlock',
          'requestFlags': requestFlags.map((e) => e.value).toList(),
          'blockNumber': blockNumber.toUnsigned(8),
          'dataBlock': dataBlock,
        });

  /// Sends the `Lock Block` command to the tag.
  ///
  /// This uses [NFCISO15693Tag#lockBlock] API on iOS.
  Future<void> lockBlock({
    required Set<Iso15693RequestFlag> requestFlags,
    required int blockNumber,
  }) =>
      channel.invokeMethod(
        "Iso15693", {
          'handle': handle,
          'method': 'lockBlock',
          'requestFlags': requestFlags.map((e) => e.value).toList(),
          'blockNumber': blockNumber.toUnsigned(8),
        });

  /// Sends the `Read Multiple Blocks` command to the tag.
  ///
  /// This uses [NFCISO15693Tag#readMultipleBlocks] API on iOS.
  Future<List<Uint8List>> readMultipleBlocks({
    required Set<Iso15693RequestFlag> requestFlags,
    required int blockNumber,
    required int numberOfBlocks,
  }) =>
      channel.invokeMethod(
        "Iso15693", {
          'handle': handle,
          'method': 'readMultipleBlocks',
          'requestFlags': requestFlags.map((e) => e.value).toList(),
          'blockNumber': blockNumber,
          'numberOfBlocks': numberOfBlocks,
        })
        .then(
          (value) => List<Uint8List>.from(value!));

  /// Sends the `Write Multiple Blocks` command to the tag.
  ///
  /// This uses [NFCISO15693Tag#writeMultipleBlocks] API on iOS.
  Future<void> writeMultipleBlocks({
    required Set<Iso15693RequestFlag> requestFlags,
    required int blockNumber,
    required int numberOfBlocks,
    required List<Uint8List> dataBlocks,
  }) =>
      channel.invokeMethod(
        "Iso15693", {
          'handle': handle,
          'method': 'writeMultipleBlocks',
          'requestFlags': requestFlags.map((e) => e.value).toList(),
          'blockNumber': blockNumber,
          'numberOfBlocks': numberOfBlocks,
          'dataBlocks': dataBlocks,
        });

  /// Sends the `Get Multiple Block Security Status` command to the tag.
  ///
  /// This uses [NFCISO15693Tag#getMultipleBlockSecurityStatus] API on iOS.
  Future<List<int>> getMultipleBlockSecurityStatus({
    required Set<Iso15693RequestFlag> requestFlags,
    required int blockNumber,
    required int numberOfBlocks,
  }) =>
      channel.invokeMethod(
        "Iso15693", {
          'handle': handle,
          'method': 'getMultipleBlockSecurityStatus',
          'requestFlags': requestFlags.map((e) => e.value).toList(),
          'blockNumber': blockNumber,
          'numberOfBlocks': numberOfBlocks,
        })
        .then(
          (value) => List<int>.from(value!));

  /// Sends the `Write AFI` command to the tag.
  ///
  /// This uses [NFCISO15693Tag#writeAFI] API on iOS.
  Future<void> writeAfi({
    required Set<Iso15693RequestFlag> requestFlags,
    required int afi,
  }) =>
      channel.invokeMethod(
        "Iso15693", {
          'handle': handle,
          'method': 'writeAfi',
          'requestFlags': requestFlags.map((e) => e.value).toList(),
          'afi': afi.toUnsigned(8),
        });

  /// Sends the `Lock AFI` command to the tag.
  ///
  /// This uses [NFCISO15693Tag#lockAFI] API on iOS.
  Future<void> lockAfi({
    required Set<Iso15693RequestFlag> requestFlags,
  }) =>
      channel.invokeMethod(
        "Iso15693", {
          'handle': handle,
          'method': 'lockAfi',
          'requestFlags': requestFlags.map((e) => e.value).toList(),
        });

  /// Sends the `Write DSFID` command to the tag.
  ///
  /// This uses [NFCISO15693Tag#writeDSFID] API on iOS.
  Future<void> writeDsfId({
    required Set<Iso15693RequestFlag> requestFlags,
    required int dsfId,
  }) =>
      channel.invokeMethod(
        "Iso15693", {
          'handle': handle,
          'method': 'writeDsfId',
          'requestFlags': requestFlags.map((e) => e.value).toList(),
          'dsfId': dsfId.toUnsigned(8),
        });

  /// Sends the `Lock DSFID` command to the tag.
  ///
  /// This uses [NFCISO15693Tag#lockDSFID] API on iOS.
  Future<void> lockDsfId({
    required Set<Iso15693RequestFlag> requestFlags,
  }) =>
      channel.invokeMethod(
        "Iso15693", {
          'handle': handle,
          'method': 'lockDsfId',
          'requestFlags': requestFlags.map((e) => e.value).toList(),
        });

  /// Sends the `Reset To Ready` command to the tag.
  ///
  /// This uses [NFCISO15693Tag#resetToReady] API on iOS.
  Future<void> resetToReady({
    required Set<Iso15693RequestFlag> requestFlags,
  }) =>
      channel.invokeMethod(
        "Iso15693", {
          'handle': handle,
          'method': 'resetToReady',
          'requestFlags': requestFlags.map((e) => e.value).toList(),
        });

  /// Sends the `Select` command to the tag.
  ///
  /// This uses [NFCISO15693Tag#select] API on iOS.
  Future<void> select({
    required Set<Iso15693RequestFlag> requestFlags,
  }) =>
      channel.invokeMethod(
        "Iso15693", {
          'handle': handle,
          'method': 'select',
          'requestFlags': requestFlags.map((e) => e.value).toList(),
        });

  /// Sends the `Stay Quiet` command to the tag.
  ///
  /// This uses [NFCISO15693Tag#stayQuiet] API on iOS.
  Future<void> stayQuiet() =>
      channel.invokeMethod(
        "Iso15693", {
          'handle': handle,
          'method': 'stayQuiet',
        });

  /// Sends the `Extended Read Single Block` command to the tag.
  ///
  /// This uses [NFCISO15693Tag#extendedReadSingleBlock] API on iOS.
  Future<Uint8List?> extendedReadSingleBlock({
    required Set<Iso15693RequestFlag> requestFlags,
    required int blockNumber,
  }) =>
      channel.invokeMethod(
        "Iso15693", {
          'handle': handle,
          'method': 'extendedReadSingleBlock',
          'requestFlags': requestFlags.map((e) => e.value).toList(),
          'blockNumber': blockNumber,
        });

  /// Sends the `Extended Write Single Block` command to the tag.
  ///
  /// This uses [NFCISO15693Tag#extendedWriteSingleBlock] API on iOS.
  Future<void> extendedWriteSingleBlock({
    required Set<Iso15693RequestFlag> requestFlags,
    required int blockNumber,
    required Uint8List dataBlock,
  }) =>
      channel.invokeMethod(
        "Iso15693", {
          'handle': handle,
          'method': 'extendedWriteSingleBlock',
          'requestFlags': requestFlags.map((e) => e.value).toList(),
          'blockNumber': blockNumber,
          'dataBlock': dataBlock,
        });

  /// Sends the `Extended Lock Block` command to the tag.
  ///
  /// This uses [NFCISO15693Tag#extendedLockBlock] API on iOS.
  Future<void> extendedLockBlock({
    required Set<Iso15693RequestFlag> requestFlags,
    required int blockNumber,
  }) =>
      channel.invokeMethod(
        "Iso15693", {
          'handle': handle,
          'method': 'extendedLockBlock',
          'requestFlags': requestFlags.map((e) => e.value).toList(),
          'blockNumber': blockNumber,
        });

  /// Sends the `Extended Read Multiple Blocks` command to the tag.
  ///
  /// This uses [NFCISO15693Tag#extendedReadMultipleBlocks] API on iOS.
  Future<List<Uint8List>> extendedReadMultipleBlocks({
    required Set<Iso15693RequestFlag> requestFlags,
    required int blockNumber,
    required int numberOfBlocks,
  }) =>
      channel.invokeMethod(
        "Iso15693", {
          'handle': handle,
          'method': 'extendedReadMultipleBlocks',
          'requestFlags': requestFlags.map((e) => e.value).toList(),
          'blockNumber': blockNumber,
          'numberOfBlocks': numberOfBlocks,
        })
        .then(
          (value) => List<Uint8List>.from(value!));

  /// Sends the `Get System Info` command to the tag.
  ///
  /// This uses [NFCISO15693Tag#getSystemInfo] API on iOS.
  Future<Iso15693SystemInfo> getSystemInfo({
    required Set<Iso15693RequestFlag> requestFlags,
  }) =>
      channel.invokeMethod(
        "Iso15693", {
          'handle': handle,
          'method': 'getSystemInfo',
          'requestFlags': requestFlags.map((e) => e.value).toList(),
        })
        .then(
          (value) => Iso15693SystemInfo.fromMap(
            Map<String, dynamic>.from(value!)));

  /// Sends the `Custom` command to the tag.
  ///
  /// This uses [NFCISO15693Tag#customCommand] API on iOS.
  Future<Uint8List> customCommand({
    required Set<Iso15693RequestFlag> requestFlags,
    required int customCommandCode,
    required Uint8List customRequestParameters,
  }) =>
      channel.invokeMethod(
        "Iso15693", {
          'handle': handle,
          'method': 'customCommand',
          'requestFlags': requestFlags.map((e) => e.value).toList(),
          'customCommandCode': customCommandCode,
          'customRequestParameters': customRequestParameters,
        })
        .then((value) => value!);

  @override
  String toString() =>
      "[Iso15693] "
      "identifier: ${identifier.toHexString()}, "
      "icManufacturerCode: $icManufacturerCode, "
      "icSerialNumber: ${icSerialNumber.toHexString()}";
}