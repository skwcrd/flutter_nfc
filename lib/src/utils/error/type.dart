part of util;

/// Represents the type of error that occurs when the session has stopped.
/// (Currently iOS only)
///  * user canceled
///  * session timeout
///  * session terminated unexpectedly
///  * system is busy
///  * first NDEF tag read
///  * unknown
enum SessionErrorType {
  /// The user canceled the session.
  userCanceled,

  /// The session timed out.
  sessionTimeout,

  /// The session terminated unexpectedly.
  sessionTerminatedUnexpectedly,

  /// The session failed because the system is busy.
  systemIsBusy,

  /// The session invalidation error first NDEF tag read.
  firstNDEFTagRead,

  /// The session failed because the unexpected error has occurred.
  unknown,
}

extension SessionErrorTypeDescription on SessionErrorType {
  String get value {
    switch (this) {
      case SessionErrorType.userCanceled:
        return "userCanceled";

      case SessionErrorType.sessionTimeout:
        return "sessionTimeout";

      case SessionErrorType.sessionTerminatedUnexpectedly:
        return "sessionTerminatedUnexpectedly";

      case SessionErrorType.systemIsBusy:
        return "systemIsBusy";

      case SessionErrorType.firstNDEFTagRead:
        return "firstNDEFTagRead";

      case SessionErrorType.unknown:
      default:
        return "unknown";
    }
  }

  String get text {
    switch (this) {
      case SessionErrorType.userCanceled:
        return "user canceled";

      case SessionErrorType.sessionTimeout:
        return "session timeout";

      case SessionErrorType.sessionTerminatedUnexpectedly:
        return "session terminated unexpectedly";

      case SessionErrorType.systemIsBusy:
        return "system is busy";

      case SessionErrorType.firstNDEFTagRead:
        return "first NDEF tag read";

      case SessionErrorType.unknown:
      default:
        return "unknown";
    }
  }
}

extension SessionErrorTypeCompare on SessionErrorType {
  bool get isUserCanceled =>
      this == SessionErrorType.userCanceled;
  bool get isSessionTimeout =>
      this == SessionErrorType.sessionTimeout;
  bool get isSessionTerminatedUnexpectedly =>
      this == SessionErrorType.sessionTerminatedUnexpectedly;
  bool get isSystemIsBusy =>
      this == SessionErrorType.systemIsBusy;
  bool get isFirstNDEFTagRead =>
      this == SessionErrorType.firstNDEFTagRead;
  bool get isUnknown =>
      this == SessionErrorType.unknown;

  bool get isNotUserCanceled =>
      this != SessionErrorType.userCanceled;
  bool get isNotSessionTimeout =>
      this != SessionErrorType.sessionTimeout;
  bool get isNotSessionTerminatedUnexpectedly =>
      this != SessionErrorType.sessionTerminatedUnexpectedly;
  bool get isNotSystemIsBusy =>
      this != SessionErrorType.systemIsBusy;
  bool get isNotFirstNDEFTagRead =>
      this != SessionErrorType.firstNDEFTagRead;
  bool get isNotUnknown =>
      this != SessionErrorType.unknown;
}

// enum ReaderErrorType {
//   unsupportedFeature,

//   securityViolation,

//   invalidParameter,

//   invalidParameterLength,

//   parameterOutOfBound,

//   radioDisabled,

//   /// The unexpected error has occurred.
//   unknown,
// }

// enum ReaderTransceiveErrorType {
//   tagConnectionLost,

//   retryExceeded,

//   tagResponseError,

//   sessionInvalidated,

//   tagNotConnected,

//   packetTooLong,

//   /// The unexpected error has occurred.
//   unknown,
// }

// enum NdefReaderSessionErrorType {
//   tagNotWritable,

//   tagUpdateFailure,

//   tagSizeTooSmall,

//   zeroLengthMessage,

//   /// The unexpected error has occurred.
//   unknown,
// }