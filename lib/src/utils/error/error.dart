part of util;

/// The class represents the error when the `NFC` feature has exception.
abstract class NfcError extends Error {
  /// Constructs an instance with the given values for testing.
  ///
  /// The instances constructs by this way are not valid in
  /// the production environment.
  NfcError({
    required Object type,
    this.message,
    this.details,
  }) :  _type = type;

  /// The error type.
  final Object _type;

  /// The error message.
  final String? message;

  /// The error details information.
  final dynamic details;

  Object get type => _type;

  @override
  String toString() =>
      "NfcError(type: $type, "
      "message: $message, details: $details)";
}