part of core.tag;

/// The class provides access to `MifareClassic` API for Android.
class MifareClassic extends NFCTag {
  /// Constructs an instance with the given values for testing.
  ///
  /// The instances constructs by this way are not valid in
  /// the production environment.
  MifareClassic._({
    required NFCTagPlatform delegate,
    required this.identifier,
    required this.type,
    required this.blockCount,
    required this.sectorCount,
    required this.size,
    required this.maxTransceiveLength,
    required int timeout,
  }) :  _timeout = timeout,
        super._(delegate);

  /// Get an instance of `MifareClassic` for the given tag.
  ///
  /// Returns null if the tag is not compatible with `MifareClassic`.
  static MifareClassic? _from({
    required NFCTagPlatform delegate,
  }) {
    if ( delegate.type.isNotMifareClassic ) {
      return null;
    }

    final _data = Map<String, dynamic>.from(delegate.data);

    return MifareClassic._(
      delegate: delegate,
      identifier: _data['identifier'],
      type: _data['type'],
      blockCount: _data['blockCount'],
      sectorCount: _data['sectorCount'],
      size: _data['size'],
      maxTransceiveLength: _data['maxTransceiveLength'],
      timeout: _data['timeout']);
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
    required int sectorIndex,
    required Uint8List key,
  }) =>
      channel.invokeMethod(
        "MifareClassic", {
          'handle': handle,
          'method': 'authenticateSectorWithKeyA',
          'sectorIndex': sectorIndex,
          'key': key,
        })
        .then((value) => value!);

  /// Sends the `Authenticate Sector With Key B` command to the tag.
  ///
  /// This uses [MifareClassic#authenticateSectorWithKeyB] API on Android.
  Future<bool> authenticateSectorWithKeyB({
    required int sectorIndex,
    required Uint8List key,
  }) =>
      channel.invokeMethod(
        "MifareClassic", {
          'handle': handle,
          'method': 'authenticateSectorWithKeyB',
          'sectorIndex': sectorIndex,
          'key': key,
        })
        .then((value) => value!);

  /// Sends the `Increment` command to the tag.
  ///
  /// This uses [MifareClassic#increment] API on Android.
  Future<void> increment({
    required int blockIndex,
    required int value,
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
    required int blockIndex,
    required int value,
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
    required int blockIndex,
  }) =>
      channel.invokeMethod(
        "MifareClassic", {
          'handle': handle,
          'method': 'readBlock',
          'blockIndex': blockIndex,
        })
        .then((value) => value!);

  /// Sends the `Write Block` command to the tag.
  ///
  /// This uses [MifareClassic#writeBlock] API on Android.
  Future<void> writeBlock({
    required int blockIndex,
    required Uint8List data,
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
    required int blockIndex,
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
    required int blockIndex,
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
    required int data,
    int? timeout,
  }) {
    timeout ??= _timeout;
    _timeout = timeout;

    return channel.invokeMethod(
      "MifareClassic", {
        'handle': handle,
        'method': 'transceive',
        'data': data,
        'timeout': timeout,
      })
      .then(
        (value) => List<int>.from(value!));
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