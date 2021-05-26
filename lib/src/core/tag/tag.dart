library core.tag;

import 'dart:convert'
  show
    utf8,
    ascii;
import 'dart:typed_data'
  show
    Int8List,
    Uint8List;

import 'package:flutter/foundation.dart'
  show
    required,
    protected,
    visibleForTesting;
import 'package:flutter/services.dart'
  show
    MethodChannel,
    PlatformException;

import '../../utils/utils.dart';
import '../interface.dart';

part 'method_channal.dart';
part 'platform.dart';
part 'type.dart';

part 'ndef/ndef.dart';
part 'ndef/formatable.dart';
part 'ndef/message.dart';
part 'ndef/record.dart';
part 'ndef/type.dart';

part 'tech/nfc_a.dart';
part 'tech/nfc_b.dart';
part 'tech/nfc_f.dart';
part 'tech/nfc_v.dart';
part 'tech/iso_dep.dart';

part 'tech/mifare/mifare.dart';
part 'tech/mifare/mifare_classic.dart';
part 'tech/mifare/mifare_ultralight.dart';
part 'tech/mifare/family.dart';

part 'tech/felica/felica.dart';
part 'tech/felica/polling_request_code.dart';
part 'tech/felica/polling_time_slot.dart';
part 'tech/felica/response.dart';

part 'tech/iso7816/iso7816.dart';
part 'tech/iso7816/response.dart';

part 'tech/iso15693/iso15693.dart';
part 'tech/iso15693/flag.dart';
part 'tech/iso15693/system_info.dart';

/// The class represents the tag discovered by the session.
abstract class NFCTag {
  /// Constructs an instance with the given values for testing.
  ///
  /// The instances constructs by this way are not valid in
  /// the production environment.
  /// Only instances obtained from the onTagDiscovered callback
  /// of `NfcSession#startSession` are valid.
  NFCTag._(this._delegate) {
    NFCTagPlatform.verifyExtends(_delegate);
  }

  factory NFCTag.instanceFor({
    @required NFCTagPlatform delegate,
  }) {
    final _type = delegate.type;
    final _handle = delegate.handle;

    _nfcTagInstance[_type][_handle] =
        NFCTag._from(delegate: delegate);

    return _nfcTagInstance[_type][_handle];
  }

  factory NFCTag._from({
    @required NFCTagPlatform delegate,
  }) {
    switch (delegate.type) {
      case NFCTagType.Ndef:
        return Ndef._from(delegate: delegate);

      case NFCTagType.NdefFormatable:
        return NdefFormatable._from(delegate: delegate);

      case NFCTagType.NfcA:
        return NfcA._from(delegate: delegate);

      case NFCTagType.NfcB:
        return NfcB._from(delegate: delegate);

      case NFCTagType.NfcF:
        return NfcF._from(delegate: delegate);

      case NFCTagType.NfcV:
        return NfcV._from(delegate: delegate);

      case NFCTagType.IsoDep:
        return IsoDep._from(delegate: delegate);

      case NFCTagType.Mifare:
        return Mifare._from(delegate: delegate);

      case NFCTagType.MifareClassic:
        return MifareClassic._from(delegate: delegate);

      case NFCTagType.MifareUltralight:
        return MifareUltralight._from(delegate: delegate);

      case NFCTagType.Felica:
        return Felica._from(delegate: delegate);

      case NFCTagType.Iso7816:
        return Iso7816._from(delegate: delegate);

      case NFCTagType.Iso15693:
        return Iso15693._from(delegate: delegate);
    }

    return null;
  }

  static const Map<NFCTagType, Map<String, NFCTag>> _nfcTagInstance = {};

  final NFCTagPlatform _delegate;

  @protected
  @visibleForTesting
  MethodChannel get channel => _delegate.channel;

  /// The value used by this plugin internally.
  @protected
  String get handle => _delegate.handle;

  NFCTagType get tagType => _delegate.type;

  Ndef get ndef =>
      _nfcTagInstance[NFCTagType.Ndef][handle] as Ndef;

  NdefFormatable get ndefFormatable =>
      _nfcTagInstance[NFCTagType.NdefFormatable][handle] as NdefFormatable;

  NfcA get nfcA =>
      _nfcTagInstance[NFCTagType.NfcA][handle] as NfcA;

  NfcB get nfcB =>
      _nfcTagInstance[NFCTagType.NfcB][handle] as NfcB;

  NfcF get nfcF =>
      _nfcTagInstance[NFCTagType.NfcF][handle] as NfcF;

  NfcV get nfcV =>
      _nfcTagInstance[NFCTagType.NfcV][handle] as NfcV;

  IsoDep get isoDep =>
      _nfcTagInstance[NFCTagType.IsoDep][handle] as IsoDep;

  Mifare get mifare =>
      _nfcTagInstance[NFCTagType.Mifare][handle] as Mifare;

  MifareClassic get mifareClassic =>
      _nfcTagInstance[NFCTagType.MifareClassic][handle] as MifareClassic;

  MifareUltralight get mifareUltralight =>
      _nfcTagInstance[NFCTagType.MifareUltralight][handle] as MifareUltralight;

  Felica get felica =>
      _nfcTagInstance[NFCTagType.Felica][handle] as Felica;

  Iso7816 get iso7816 =>
      _nfcTagInstance[NFCTagType.Iso7816][handle] as Iso7816;

  Iso15693 get iso15693 =>
      _nfcTagInstance[NFCTagType.Iso15693][handle] as Iso15693;

  Future<void> disposeTag() async {
    try {
      await _delegate.disposeTag();

      _nfcTagInstance[tagType].remove(handle);
    } on PlatformException catch (error, stackTrace) {
      throw PlatformException(
        code: "disposeTag",
        message: "NFC features cannot dispose NFC tag, "
          "fail code: ${error.code}, message error: ${error.message}",
        details: error.details,
        stacktrace: error.stacktrace ?? stackTrace?.toString());
    } catch (error, stackTrace) {
      throw PlatformException(
        code: "disposeTag",
        message: "NFC features cannot dispose NFC tag",
        details: error,
        stacktrace: stackTrace?.toString()
          ?? StackTrace.current.toString());
    }
  }
}