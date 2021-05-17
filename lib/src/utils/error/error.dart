part of util;

/// The class represents the error.
///
///     [@param] type     the error type.
///     [@param] message  the error message.
///     [@param] details  the error details information.
///
abstract class NfcError extends Error {
  /// Constructs an instance with the given values for testing.
  ///
  /// The instances constructs by this way are not valid in
  /// the production environment.
  ///
  NfcError({
    @required Object type,
    this.message,
    this.details,
  }) :  _type = type;

  /// The error type.
  final Object _type;

  /// The error message.
  final String message;

  /// The error details information.
  final dynamic details;
}