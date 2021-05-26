part of core.tag;

/// The class provides access to `MifareClassic` API for Android.
class MifareClassic extends NFCTag {
  /// Constructs an instance with the given values for testing.
  ///
  /// The instances constructs by this way are not valid in
  /// the production environment.
  MifareClassic._({
    @required NFCTagPlatform delegate,
    this.identifier,
    this.type,
    this.blockCount,
    this.sectorCount,
    this.size,
    this.maxTransceiveLength,
    int timeout,
  }) :  _timeout = timeout,
        super._(delegate);

  /// Get an instance of `MifareClassic` for the given tag.
  ///
  /// Returns null if the tag is not compatible with `MifareClassic`.
  factory MifareClassic._from({
    @required NFCTagPlatform delegate,
  }) {
    if ( delegate.type.isNotMifareClassic ) {
      return null;
    }

    final _data = Map<String, dynamic>.from(delegate.data);

    return MifareClassic._(
      delegate: delegate,
      identifier: Uint8List.fromList(
        _data['identifier'] as List<int>),
      type: _data['type'] as int,
      blockCount: _data['blockCount'] as int,
      sectorCount: _data['sectorCount'] as int,
      size: _data['size'] as int,
      maxTransceiveLength: _data['maxTransceiveLength'] as int,
      timeout: _data['timeout'] as int);
  }

  /// The value from [Tag#id] on Android.
  final Uint8List identifier;

  /// The value from [MifareClassic#type] on Android.
  final int type;

  /// The value from [MifareClassic#blockCount] on Android.
  final int blockCount;

  /// The value from [MifareClassic#sectorCount] on Android.
  final int sectorCount;

  /// The value from [MifareClassic#size] on Android.
  final int size;

  /// The value from [MifareClassic#maxTransceiveLength] on Android.
  final int maxTransceiveLength;

  int _timeout;

  /// The value from [MifareClassic#timeout] on Android.
  int get timeout => _timeout;

  /// Sends the `Authenticate Sector With Key A` command to the tag.
  ///
  /// This uses [MifareClassic#authenticateSectorWithKeyA] API on Android.
  Future<bool> authenticateSectorWithKeyA({
    int sectorIndex,
    Uint8List key,
  }) =>
      channel.invokeMethod(
        "MifareClassic", {
          'handle': handle,
          'method': 'authenticateSectorWithKeyA',
          'sectorIndex': sectorIndex,
          'key': key,
        });

  /// Sends the `Authenticate Sector With Key B` command to the tag.
  ///
  /// This uses [MifareClassic#authenticateSectorWithKeyB] API on Android.
  Future<bool> authenticateSectorWithKeyB({
    int sectorIndex,
    Uint8List key,
  }) =>
      channel.invokeMethod(
        "MifareClassic", {
          'handle': handle,
          'method': 'authenticateSectorWithKeyB',
          'sectorIndex': sectorIndex,
          'key': key,
        });

  /// Sends the `Increment` command to the tag.
  ///
  /// This uses [MifareClassic#increment] API on Android.
  Future<void> increment({
    int blockIndex,
    int value,
  }) =>
      channel.invokeMethod(
        "MifareClassic", {
          'handle': handle,
          'method': 'increment',
          'blockIndex': blockIndex,
          'value': value,
        });

  /// Sends the `Decrement` command to the tag.
  ///
  /// This uses [MifareClassic#decrement] API on Android.
  Future<void> decrement({
    int blockIndex,
    int value,
  }) =>
      channel.invokeMethod(
        "MifareClassic", {
          'handle': handle,
          'method': 'decrement',
          'blockIndex': blockIndex,
          'value': value,
        });

  /// Sends the `Read Block` command to the tag.
  ///
  /// This uses [MifareClassic#readBlock] API on Android.
  Future<Uint8List> readBlock({
    int blockIndex,
  }) =>
      channel.invokeMethod(
        "MifareClassic", {
          'handle': handle,
          'method': 'readBlock',
          'blockIndex': blockIndex,
        });

  /// Sends the `Write Block` command to the tag.
  ///
  /// This uses [MifareClassic#writeBlock] API on Android.
  Future<void> writeBlock({
    int blockIndex,
    Uint8List data,
  }) =>
      channel.invokeMethod(
        "MifareClassic", {
          'handle': handle,
          'method': 'writeBlock',
          'blockIndex': blockIndex,
          'data': data,
        });

  /// Sends the `Restore` command to the tag.
  ///
  /// This uses [MifareClassic#restore] API on Android.
  Future<void> restore({
    int blockIndex,
  }) =>
      channel.invokeMethod(
        "MifareClassic", {
          'handle': handle,
          'method': 'restore',
          'blockIndex': blockIndex,
        });

  /// Sends the `Transfer` command to the tag.
  ///
  /// This uses [MifareClassic#transfer] API on Android.
  Future<void> transfer({
    int blockIndex,
  }) =>
      channel.invokeMethod(
        "MifareClassic", {
          'handle': handle,
          'method': 'transfer',
          'blockIndex': blockIndex,
        });

  /// Sends the `MifareClassic` command to the tag.
  ///
  /// This uses [MifareClassic#transceive] API on Android.
  /// This is equivalent to obtaining via `NfcA` this tag
  /// and calling `NfcA#transceive`.
  Future<List<int>> transceive({
    @required int data,
    int timeout,
  }) async {
    assert(
      data != null,
      'data cannot be null');

    timeout ??= _timeout;
    _timeout = timeout;

    return Int8List.fromList(
      await channel.invokeMethod(
        "MifareClassic", {
          'handle': handle,
          'method': 'transceive',
          'data': data,
          'timeout': timeout,
        }))
        .toList();
  }

  @override
  String toString() =>
      "[Mifare Classic] "
      "identifier: ${identifier.toHexString()}, "
      "type: $type, "
      "blockCount: $blockCount, "
      "sectorCount: $sectorCount, "
      "size: $size, "
      "maxTransceiveLength: $maxTransceiveLength, "
      "timeout: $timeout";
}