part of core.tag;

/// The class represents the immutable `NDEF` record.
class NdefRecord {
  /// Constructs an instance with the given values.
  ///
  /// Recommend to use other factory constructors such
  /// as `createText` or `createUri` where possible,
  /// since they will ensure that the records are formatted
  /// correctly according to the NDEF specification.
  factory NdefRecord({
    required NdefTypeNameFormat typeNameFormat,
    required Uint8List type,
    required Uint8List identifier,
    required Uint8List payload,
  }) {
    _validateFormat(
      format: typeNameFormat,
      type: type,
      identifier: identifier,
      payload: payload);

    return NdefRecord._(
      typeNameFormat: typeNameFormat,
      type: type,
      identifier: identifier,
      payload: payload);
  }

  // NdefRecord
  const NdefRecord._({
    required this.typeNameFormat,
    required this.type,
    required this.identifier,
    required this.payload,
  });

  /// Constructs an instance containing `UTF-8` text.
  ///
  /// Can specify the `languageCode` for the given text,
  /// `en` by default.
  factory NdefRecord.createText(
    String text, {
    String languageCode = 'en',
  }) {
    final _languageCodeBytes = ascii.encode(languageCode);

    if ( _languageCodeBytes.length >= 64 ) {
      throw ArgumentError('languageCode is too long');
    }

    return NdefRecord(
      typeNameFormat: NdefTypeNameFormat.nfcWellKnown,
      type: Uint8List.fromList([ 0x54 ]),
      identifier: Uint8List.fromList([]),
      payload: Uint8List.fromList([
        _languageCodeBytes.length,
        ..._languageCodeBytes,
        ...utf8.encode(text),
      ]));
  }

  /// Constructs an instance containing `URI`.
  factory NdefRecord.createUri(Uri uri) {
    final _uriString = uri.normalizePath().toString();

    if ( _uriString.isEmpty ) {
      throw ArgumentError('uri is empty');
    }

    var _prefixIndex = URI_PREFIX_LIST.indexWhere(
      _uriString.startsWith, 1);

    if ( _prefixIndex < 0 ) {
      _prefixIndex = 0;
    }

    return NdefRecord(
      typeNameFormat: NdefTypeNameFormat.nfcWellKnown,
      type: Uint8List.fromList([0x55]),
      identifier: Uint8List.fromList([]),
      payload: Uint8List.fromList([
        _prefixIndex,
        ...utf8.encode(
          _uriString.substring(
            URI_PREFIX_LIST[_prefixIndex].length)),
      ]));
  }

  /// Constructs an instance containing media data as defined by `RFC 2046`.
  factory NdefRecord.createMime(String type, Uint8List data) {
    type = type.toLowerCase().trim().split(';').first;

    if ( type.isEmpty ) {
      throw ArgumentError('type is empty');
    }

    final _slashIndex = type.indexOf('/');

    if ( _slashIndex == 0 ) {
      throw ArgumentError('type must have mojor type');
    }
    if ( _slashIndex == (type.length - 1) ) {
      throw ArgumentError('type must have minor type');
    }

    return NdefRecord(
      typeNameFormat: NdefTypeNameFormat.media,
      type: ascii.encode(type),
      identifier: Uint8List.fromList([]),
      payload: data);
  }

  /// Constructs an instance containing external `(application-specific)` data.
  factory NdefRecord.createExternal(
      String domain, String type, Uint8List data) {
    domain = domain.trim().toLowerCase();
    type = type.trim().toLowerCase();

    if ( domain.isEmpty ) {
      throw ArgumentError('domain is empty');
    }

    if ( type.isEmpty ) {
      throw ArgumentError('type is empty');
    }

    return NdefRecord(
      typeNameFormat: NdefTypeNameFormat.nfcExternal,
      type: Uint8List.fromList([
        ...utf8.encode(domain),
        ...':'.codeUnits,
        ...utf8.encode(type),
      ]),
      identifier: Uint8List.fromList([]),
      payload: data);
  }

  /// URI_PREFIX_LIST
  static const URI_PREFIX_LIST = <String>[
    '',
    'http://www.',
    'https://www.',
    'http://',
    'https://',
    'tel:',
    'mailto:',
    'ftp://anonymous:anonymous@',
    'ftp://ftp.',
    'ftps://',
    'sftp://',
    'smb://',
    'nfs://',
    'ftp://',
    'dav://',
    'news:',
    'telnet://',
    'imap:',
    'rtsp://',
    'urn:',
    'pop:',
    'sip:',
    'sips:',
    'tftp:',
    'btspp://',
    'btl2cap://',
    'btgoep://',
    'tcpobex://',
    'irdaobex://',
    'file://',
    'urn:epc:id:',
    'urn:epc:tag:',
    'urn:epc:pat:',
    'urn:epc:raw:',
    'urn:epc:',
    'urn:nfc:',
  ];

  /// Type Name Format.
  final NdefTypeNameFormat typeNameFormat;

  /// Type.
  final Uint8List type;

  /// Identifier.
  final Uint8List identifier;

  /// Payload.
  final Uint8List payload;

  /// The length in bytes of the `NDEF` record when stored on the tag.
  int get byteLength {
    var _length = 3 + type.length + identifier.length + payload.length;

    // not short record
    if (payload.length > 255) {
      _length += 3;
    }

    // id length
    if ( typeNameFormat.isEmpty || (identifier.isNotEmpty) ) {
      _length += 1;
    }

    return _length;
  }

  // _validateFormat
  static void _validateFormat({
    required NdefTypeNameFormat format,
    required Uint8List type,
    required Uint8List identifier,
    required Uint8List payload,
  }) {
    switch (format) {
      case NdefTypeNameFormat.empty:
        if ( type.isNotEmpty || identifier.isNotEmpty || payload.isNotEmpty ) {
          throw UnimplementedError(
            'unexpected data in EMPTY record');
        }
        break;

      case NdefTypeNameFormat.nfcWellKnown:
      case NdefTypeNameFormat.media:
      case NdefTypeNameFormat.absoluteUri:
      case NdefTypeNameFormat.nfcExternal:
        break;

      case NdefTypeNameFormat.unknown:
        if ( type.isNotEmpty ) {
          throw UnimplementedError(
            'unexpected type field in UNKNOWN record');
        }
        break;

      case NdefTypeNameFormat.unchanged:
        throw UnimplementedError(
          'unexpected UNCHANGED in first chunk or logical record');

      default:
        throw UnimplementedError(
          "unexpected format: $format");
    }
  }

  Map<String, dynamic> toMap() =>
      <String, dynamic>{
        'typeNameFormat': typeNameFormat.value,
        'type': type,
        'identifier': identifier,
        'payload': payload,
      };

  @override
  String toString() =>
      "[Ndef Record] "
      "typeNameFormat: $typeNameFormat, "
      "identifier: ${identifier.toHexString()}, "
      "payload: ${payload.toHexString()}, "
      "type: ${type.toHexString()}, "
      "byteLength: $byteLength";
}