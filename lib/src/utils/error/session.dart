part of util;

/// The class represents the error when the session is stopped.
/// (Currently iOS only)
class SessionError extends NfcError {
  /// Constructs an instance with the given values for testing.
  ///
  /// The instances constructs by this way are not valid in
  /// the production environment.
  /// Only instances obtained from the onError callback of
  /// `NfcSession#startSession` are valid.
  SessionError({
    SessionErrorType type = SessionErrorType.unknown,
    String message,
    Object details,
  }) :  super(
          type: type,
          message: message,
          details: details);

  factory SessionError.fromMap(Map<String, dynamic> arg) =>
    SessionError(
      type: SessionErrorType.values.firstWhere(
        (type) => type.value == arg['type'].toString(),
        orElse: () => SessionErrorType.unknown),
      message: arg['message'].toString(),
      details: arg['details']);

  /// The session error type.
  SessionErrorType get type {
    if ( _type is SessionErrorType ) {
      return _type as SessionErrorType;
    }

    return SessionErrorType.unknown;
  }

  @override
  String toString() =>
      "SessionError(type: ${type.text}, "
      "message: $message, details: $details)";
}