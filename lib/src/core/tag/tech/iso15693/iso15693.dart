part of core.tag;

/// The class provides access to `NFCISO15693Tag` API for iOS.
class Iso15693 extends NFCTag {
  /// Constructs an instance with the given values for testing.
  ///
  /// The instances constructs by this way are not valid in
  /// the production environment.
  Iso15693._({
    @required NFCTagPlatform delegate,
    this.identifier,
    this.icManufacturerCode,
    this.icSerialNumber,
  }) : super._(delegate);

  /// Get an instance of `Iso15693` for the given tag.
  ///
  /// Returns null if the tag is not compatible with `Iso15693`.
  factory Iso15693._from({
    @required NFCTagPlatform delegate,
  }) {
    if ( delegate.type.isNotIso15693 ) {
      return null;
    }

    final _data = Map<String, dynamic>.from(delegate.data);

    return Iso15693._(
      delegate: delegate,
      identifier: Uint8List.fromList(
        _data['identifier'] as List<int>),
      icManufacturerCode: _data['icManufacturerCode'] as int,
      icSerialNumber: Uint8List.fromList(
        _data['icSerialNumber'] as List<int>));
  }

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
    Set<Iso15693RequestFlag> requestFlags,
    int blockNumber,
  }) =>
      channel.invokeMethod(
        "Iso15693", {
          'handle': handle,
          'method': 'readSingleBlock',
          'requestFlags': requestFlags.map((e) => e.value).toList(),
          'blockNumber': blockNumber.toUnsigned(8),
        });

  /// Sends the `Write Single Block` command to the tag.
  ///
  /// This uses [NFCISO15693Tag#writeSingleBlock] API on iOS.
  Future<void> writeSingleBlock({
    Set<Iso15693RequestFlag> requestFlags,
    int blockNumber,
    Uint8List dataBlock,
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
    Set<Iso15693RequestFlag> requestFlags,
    int blockNumber,
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
    Set<Iso15693RequestFlag> requestFlags,
    int blockNumber,
    int numberOfBlocks,
  }) =>
      channel.invokeMethod(
        "Iso15693", {
          'handle': handle,
          'method': 'readMultipleBlocks',
          'requestFlags': requestFlags.map((e) => e.value).toList(),
          'blockNumber': blockNumber,
          'numberOfBlocks': numberOfBlocks,
        });

  /// Sends the `Write Multiple Blocks` command to the tag.
  ///
  /// This uses [NFCISO15693Tag#writeMultipleBlocks] API on iOS.
  Future<void> writeMultipleBlocks({
    Set<Iso15693RequestFlag> requestFlags,
    int blockNumber,
    int numberOfBlocks,
    List<Uint8List> dataBlocks,
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
    Set<Iso15693RequestFlag> requestFlags,
    int blockNumber,
    int numberOfBlocks,
  }) =>
      channel.invokeMethod(
        "Iso15693", {
          'handle': handle,
          'method': 'getMultipleBlockSecurityStatus',
          'requestFlags': requestFlags.map((e) => e.value).toList(),
          'blockNumber': blockNumber,
          'numberOfBlocks': numberOfBlocks,
        });

  /// Sends the `Write AFI` command to the tag.
  ///
  /// This uses [NFCISO15693Tag#writeAFI] API on iOS.
  Future<void> writeAfi({
    Set<Iso15693RequestFlag> requestFlags,
    int afi,
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
    Set<Iso15693RequestFlag> requestFlags,
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
    Set<Iso15693RequestFlag> requestFlags,
    int dsfId,
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
    Set<Iso15693RequestFlag> requestFlags,
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
    Set<Iso15693RequestFlag> requestFlags,
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
    Set<Iso15693RequestFlag> requestFlags,
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
  Future<Uint8List> extendedReadSingleBlock({
    Set<Iso15693RequestFlag> requestFlags,
    int blockNumber,
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
    Set<Iso15693RequestFlag> requestFlags,
    int blockNumber,
    Uint8List dataBlock,
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
    Set<Iso15693RequestFlag> requestFlags,
    int blockNumber,
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
    Set<Iso15693RequestFlag> requestFlags,
    int blockNumber,
    int numberOfBlocks,
  }) =>
      channel.invokeMethod(
        "Iso15693", {
          'handle': handle,
          'method': 'extendedReadMultipleBlocks',
          'requestFlags': requestFlags.map((e) => e.value).toList(),
          'blockNumber': blockNumber,
          'numberOfBlocks': numberOfBlocks,
        });

  /// Sends the `Get System Info` command to the tag.
  ///
  /// This uses [NFCISO15693Tag#getSystemInfo] API on iOS.
  Future<Iso15693SystemInfo> getSystemInfo({
    Set<Iso15693RequestFlag> requestFlags,
  }) =>
      channel.invokeMethod<Map>(
        "Iso15693", {
          'handle': handle,
          'method': 'getSystemInfo',
          'requestFlags': requestFlags.map((e) => e.value).toList(),
        })
        .then(
          (value) => Iso15693SystemInfo.fromMap(
            Map<String, dynamic>.from(value)));

  /// Sends the `Custom` command to the tag.
  ///
  /// This uses [NFCISO15693Tag#customCommand] API on iOS.
  Future<Uint8List> customCommand({
    Set<Iso15693RequestFlag> requestFlags,
    int customCommandCode,
    Uint8List customRequestParameters,
  }) =>
      channel.invokeMethod(
        "Iso15693", {
          'handle': handle,
          'method': 'customCommand',
          'requestFlags': requestFlags.map((e) => e.value).toList(),
          'customCommandCode': customCommandCode,
          'customRequestParameters': customRequestParameters,
        });

  @override
  String toString() =>
      "[Iso15693] "
      "identifier: ${identifier.toHexString()}, "
      "icManufacturerCode: $icManufacturerCode, "
      "icSerialNumber: ${icSerialNumber.toHexString()}";
}