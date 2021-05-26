part of core.tag;

/// Represents the `NDEF Type-Name-Format` as defined by the `NFC` specification.
enum NdefTypeNameFormat {
  /// The record contains no data.
  empty,

  /// The record contains well-known `NFC` record type data.
  nfcWellKnown,

  /// The record contains media data as defined by `RFC 2046`.
  media,

  /// The record contains uniform resource identifier.
  absoluteUri,

  /// The record contains `NFC` external type data.
  nfcExternal,

  /// The record type is unknown.
  unknown,

  /// The record is part of a series of records containing chunked data.
  unchanged,
}

extension _NdefTypeNameFormatValue on NdefTypeNameFormat {
  int get value {
    switch (this) {
      case NdefTypeNameFormat.empty:
        return 0x00;

      case NdefTypeNameFormat.nfcWellKnown:
        return 0x01;

      case NdefTypeNameFormat.media:
        return 0x02;

      case NdefTypeNameFormat.absoluteUri:
        return 0x03;

      case NdefTypeNameFormat.nfcExternal:
        return 0x04;

      case NdefTypeNameFormat.unknown:
        return 0x05;

      case NdefTypeNameFormat.unchanged:
        return 0x06;

      default:
        return 0x00;
    }
  }
}

extension NdefTypeNameFormatCompare on NdefTypeNameFormat {
  bool get isEmpty =>
      this == NdefTypeNameFormat.empty;
  bool get isNfcWellKnown =>
      this == NdefTypeNameFormat.nfcWellKnown;
  bool get isMedia =>
      this == NdefTypeNameFormat.media;
  bool get isAbsoluteUri =>
      this == NdefTypeNameFormat.absoluteUri;
  bool get isNfcExternal =>
      this == NdefTypeNameFormat.nfcExternal;
  bool get isUnknown =>
      this == NdefTypeNameFormat.unknown;
  bool get isUnchanged =>
      this == NdefTypeNameFormat.unchanged;

  bool get isNotEmpty =>
      this != NdefTypeNameFormat.empty;
  bool get isNotNfcWellKnown =>
      this != NdefTypeNameFormat.nfcWellKnown;
  bool get isNotMedia =>
      this != NdefTypeNameFormat.media;
  bool get isNotAbsoluteUri =>
      this != NdefTypeNameFormat.absoluteUri;
  bool get isNotNfcExternal =>
      this != NdefTypeNameFormat.nfcExternal;
  bool get isNotUnknown =>
      this != NdefTypeNameFormat.unknown;
  bool get isNotUnchanged =>
      this != NdefTypeNameFormat.unchanged;
}