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
    required NFCTagPlatform delegate,
  }) {
    final _handle = delegate.handle;
    final _techList = delegate.techList;

    _nfcTagInstance.putIfAbsent(
      _handle, () => {});

    for ( final _tech in _techList ) {
      final _tag = NFCTag._from(delegate: delegate, type: _tech);

      _nfcTagInstance[_handle]!.update(
        _tech, (t) => _tag, ifAbsent: () => _tag);
    }

    return _nfcTagInstance[_handle]!
        .values
        .firstWhere(
          (e) => e != null)!;
  }

  static NFCTag? _from({
    required NFCTagPlatform delegate,
    required NFCTagType type,
  }) {
    if ( delegate.data[type.value] == null ) {
      return null;
    }

    switch (type) {
      case NFCTagType.Ndef:
        return Ndef._from(
          Map<String, dynamic>.from(delegate.data[type.value]),
          delegate: delegate);

      case NFCTagType.NdefFormatable:
        return NdefFormatable._from(
          Map<String, dynamic>.from(delegate.data[type.value]),
          delegate: delegate);

      case NFCTagType.NfcA:
        return NfcA._from(
          Map<String, dynamic>.from(delegate.data[type.value]),
          delegate: delegate);

      case NFCTagType.NfcB:
        return NfcB._from(
          Map<String, dynamic>.from(delegate.data[type.value]),
          delegate: delegate);

      case NFCTagType.NfcF:
        return NfcF._from(
          Map<String, dynamic>.from(delegate.data[type.value]),
          delegate: delegate);

      case NFCTagType.NfcV:
        return NfcV._from(
          Map<String, dynamic>.from(delegate.data[type.value]),
          delegate: delegate);

      case NFCTagType.IsoDep:
        return IsoDep._from(
          Map<String, dynamic>.from(delegate.data[type.value]),
          delegate: delegate);

      case NFCTagType.Mifare:
        return Mifare._from(
          Map<String, dynamic>.from(delegate.data[type.value]),
          delegate: delegate);

      case NFCTagType.MifareClassic:
        return MifareClassic._from(
          Map<String, dynamic>.from(delegate.data[type.value]),
          delegate: delegate);

      case NFCTagType.MifareUltralight:
        return MifareUltralight._from(
          Map<String, dynamic>.from(delegate.data[type.value]),
          delegate: delegate);

      case NFCTagType.Felica:
        return Felica._from(
          Map<String, dynamic>.from(delegate.data[type.value]),
          delegate: delegate);

      case NFCTagType.Iso7816:
        return Iso7816._from(
          Map<String, dynamic>.from(delegate.data[type.value]),
          delegate: delegate);

      case NFCTagType.Iso15693:
        return Iso15693._from(
          Map<String, dynamic>.from(delegate.data[type.value]),
          delegate: delegate);

      default:
    }

    return null;
  }

  static final Map<String, Map<NFCTagType, NFCTag?>> _nfcTagInstance = {};

  final NFCTagPlatform _delegate;

  @protected
  @visibleForTesting
  MethodChannel get channel => _delegate.channel;

  @visibleForTesting
  static Map<String, Map<NFCTagType, NFCTag?>> get tagInstance => _nfcTagInstance;

  Ndef? get ndef =>
      _nfcTagInstance[handle]![NFCTagType.Ndef] as Ndef?;

  NdefFormatable? get ndefFormatable =>
      _nfcTagInstance[handle]![NFCTagType.NdefFormatable] as NdefFormatable?;

  NfcA? get nfcA =>
      _nfcTagInstance[handle]![NFCTagType.NfcA] as NfcA?;

  NfcB? get nfcB =>
      _nfcTagInstance[handle]![NFCTagType.NfcB] as NfcB?;

  NfcF? get nfcF =>
      _nfcTagInstance[handle]![NFCTagType.NfcF] as NfcF?;

  NfcV? get nfcV =>
      _nfcTagInstance[handle]![NFCTagType.NfcV] as NfcV?;

  IsoDep? get isoDep =>
      _nfcTagInstance[handle]![NFCTagType.IsoDep] as IsoDep?;

  Mifare? get mifare =>
      _nfcTagInstance[handle]![NFCTagType.Mifare] as Mifare?;

  MifareClassic? get mifareClassic =>
      _nfcTagInstance[handle]![NFCTagType.MifareClassic] as MifareClassic?;

  MifareUltralight? get mifareUltralight =>
      _nfcTagInstance[handle]![NFCTagType.MifareUltralight] as MifareUltralight?;

  Felica? get felica =>
      _nfcTagInstance[handle]![NFCTagType.Felica] as Felica?;

  Iso7816? get iso7816 =>
      _nfcTagInstance[handle]![NFCTagType.Iso7816] as Iso7816?;

  Iso15693? get iso15693 =>
      _nfcTagInstance[handle]![NFCTagType.Iso15693] as Iso15693?;

  /// The value used by this plugin internally.
  @protected
  @visibleForTesting
  String get handle => _delegate.handle;

  List<NFCTagType> get techList => _delegate.techList;

  Future<void> disposeTag() async {
    try {
      await _delegate.disposeTag();

      _nfcTagInstance.remove(handle);
    } on PlatformException catch (error, stackTrace) {
      throw PlatformException(
        code: "disposeTag",
        message: "NFC features cannot dispose NFC tag, "
          "fail code: ${error.code}, message error: ${error.message}",
        details: error.details,
        stacktrace: error.stacktrace ?? stackTrace.toString());
    } catch (error, stackTrace) {
      throw PlatformException(
        code: "disposeTag",
        message: "NFC features cannot dispose NFC tag",
        details: error,
        stacktrace: stackTrace.toString());
    }
  }
}