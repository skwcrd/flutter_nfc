part of core.tag;

/// The class provides access to `NdefFormatable` API for Android.
class NdefFormatable extends NFCTag {
  /// Constructs an instance with the given values for testing.
  ///
  /// The instances constructs by this way are not valid in
  /// the production environment.
  NdefFormatable._({
    required NFCTagPlatform delegate,
    required this.identifier,
  }) : super._(delegate);

  /// Get an instance of `NdefFormatable` for the given tag.
  ///
  /// Returns null if the tag is not `NDEF` formatable.
  static NdefFormatable? _from({
    required NFCTagPlatform delegate,
  }) {
    if ( delegate.type.isNotNdefFormatable ) {
      return null;
    }

    final _data = Map<String, dynamic>.from(delegate.data);

    return NdefFormatable._(
      delegate: delegate,
      identifier: _data['identifier']);
  }

  /// The value from [Tag#id] on Android.
  final Uint8List identifier;

  /// Format the tag as `NDEF`, and write the given `NDEF` message.
  ///
  /// This uses [NdefFormatable#format] API on Android.
  Future<void> format(NdefMessage firstMessage) =>
      channel.invokeMethod(
        "NdefFormatable", {
          'handle': handle,
          'method': 'format',
          'firstMessage': firstMessage.toMap(),
        });

  /// Format the tag as `NDEF`, write the given `NDEF` message,
  /// and make read-only.
  ///
  /// This uses [NdefFormatable#formatReadOnly] API on Android.
  Future<void> formatReadOnly(NdefMessage firstMessage) =>
      channel.invokeMethod(
        "NdefFormatable", {
          'handle': handle,
          'method': 'formatReadOnly',
          'firstMessage': firstMessage.toMap(),
        });

  @override
  String toString() =>
      "[Ndef Formatable] "
      "identifier: ${identifier.toHexString()}";
}