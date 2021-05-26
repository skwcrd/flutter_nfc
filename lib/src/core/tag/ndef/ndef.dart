part of core.tag;

/// The class provides access to `NDEF` operations on the tag.
class Ndef extends NFCTag {
  /// Constructs an instance with the given values for testing.
  ///
  /// The instances constructs by this way are not valid in
  /// the production environment.
  Ndef._({
    NFCTagPlatform delegate,
    this.isWritable,
    this.maxSize,
    this.cachedMessage,
    this.additionalData,
  }) : super._(delegate);

  /// Get an instance of `Ndef` for the given tag.
  ///
  /// Returns null if the tag is not compatible with `NDEF`.
  factory Ndef._from({
    @required NFCTagPlatform delegate,
  }) {
    if ( delegate.type.isNotNdef ) {
      return null;
    }

    final _data = Map<String, dynamic>.from(delegate.data);

    return Ndef._(
      delegate: delegate,
      isWritable: _data.remove('isWritable') as bool,
      maxSize: _data.remove('maxSize') as int,
      cachedMessage: _data['cachedMessage'] == null
          ? null
          : NdefMessage.fromMap(
              Map<String, dynamic>.from(
                _data.remove('cachedMessage') as Map)),
      additionalData: _data);
  }

  /// The value from [Ndef#isWritable] on Android,
  /// [NFCNDEFTag#queryStatus] on iOS.
  final bool isWritable;

  /// The value from [Ndef#maxSize] on Android,
  /// [NFCNDEFTag#queryStatus] on iOS.
  final int maxSize;

  /// The value from [Ndef#cachedNdefMessage] on Android,
  /// [NFCNDEFTag#read] on iOS.
  ///
  /// This value is cached at tag discovery.
  final NdefMessage cachedMessage;

  /// The value represents some additional data.
  final Map<String, dynamic> additionalData;

  /// Read the current `NDEF` message on this tag.
  Future<NdefMessage> read() =>
      channel.invokeMethod<Map>(
        "Ndef", {
          'handle': handle,
          'method': 'read',
        })
        .then(
          (value) => NdefMessage.fromMap(
            Map<String, dynamic>.from(value)));

  /// Write the `NDEF` message on this tag.
  Future<void> write(NdefMessage message) =>
      channel.invokeMethod(
        "Ndef", {
          'handle': handle,
          'method': 'write',
          'message': {
            'records': message.records
              .map((e) => {
                'typeNameFormat': e.typeNameFormat.value,
                'type': e.type,
                'identifier': e.identifier,
                'payload': e.payload,
              })
              .toList(),
          },
        });

  /// Change the `NDEF` status to read-only.
  ///
  /// This is a permanent action that you cannot undo.
  /// After locking the tag, you can no longer write
  /// data to it.
  Future<void> writeLock() =>
      channel.invokeMethod(
        "Ndef", {
          'handle': handle,
          'method': 'writeLock',
        });

  @override
  String toString() =>
      "[Ndef] "
      "isWritable: $isWritable, "
      "maxSize: $maxSize, "
      "cachedMessage: $cachedMessage, "
      "additionalData: $additionalData";
}