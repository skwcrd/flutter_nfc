part of core.tag;

/// Represents the type of NFC tag technology.
///  * Ndef (Android, iOS)
///  * NdefFormatable (Android)
///  * NfcA (Android)
///  * NfcB (Android)
///  * NfcF (Android)
///  * NfcV (Android)
///  * IsoDep (Android)
///  * Mifare (iOS)
///  * MifareClassic (Android)
///  * MifareUltralight (Android)
///  * Felica (iOS)
///  * Iso7816 (iOS)
///  * Iso15693 (iOS)
enum NFCTagType {
  /// `NDEF` on Android,
  /// `NFCNDEFTag` on iOS.
  Ndef,

  /// `NDEF` formatable on Android.
  NdefFormatable,

  /// `NFC` (type `A`) on Android.
  NfcA,

  /// `NFC` (type `B`) on Android.
  NfcB,

  /// `NFC` (type `F`) on Android.
  NfcF,

  /// `NFC` (type `V`) on Android.
  NfcV,

  /// `IsoDep` on Android.
  IsoDep,

  /// `NFCMiFareTag` on iOS.
  Mifare,

  /// `MifareClassic` on Android.
  MifareClassic,

  /// `MifareUltralight` on Android.
  MifareUltralight,

  /// `NFCFeliCaTag` on iOS.
  Felica,

  /// `NFCISO7816Tag` on iOS.
  Iso7816,

  /// `NFCISO15693Tag` on iOS.
  Iso15693,

  /// The unexpected tag type has occurred.
  unknown,
}

extension _NFCTagTypeValue on NFCTagType {
  String get value {
    switch (this) {
      case NFCTagType.Ndef:
        return "Ndef";

      case NFCTagType.NdefFormatable:
        return "NdefFormatable";

      case NFCTagType.NfcA:
        return "NfcA";

      case NFCTagType.NfcB:
        return "NfcB";

      case NFCTagType.NfcF:
        return "NfcF";

      case NFCTagType.NfcV:
        return "NfcV";

      case NFCTagType.IsoDep:
        return "IsoDep";

      case NFCTagType.Mifare:
        return "Mifare";

      case NFCTagType.MifareClassic:
        return "MifareClassic";

      case NFCTagType.MifareUltralight:
        return "MifareUltralight";

      case NFCTagType.Felica:
        return "Felica";

      case NFCTagType.Iso7816:
        return "Iso7816";

      case NFCTagType.Iso15693:
        return "Iso15693";

      default:
        return "unknown";
    }
  }
}

extension NFCTagTypeCompare on NFCTagType {
  bool get isNdef =>
      this == NFCTagType.Ndef;
  bool get isNdefFormatable =>
      this == NFCTagType.NdefFormatable;
  bool get isNfcA =>
      this == NFCTagType.NfcA;
  bool get isNfcB =>
      this == NFCTagType.NfcB;
  bool get isNfcF =>
      this == NFCTagType.NfcF;
  bool get isNfcV =>
      this == NFCTagType.NfcV;
  bool get isIsoDep =>
      this == NFCTagType.IsoDep;
  bool get isMifare =>
      this == NFCTagType.Mifare;
  bool get isMifareClassic =>
      this == NFCTagType.MifareClassic;
  bool get isMifareUltralight =>
      this == NFCTagType.MifareUltralight;
  bool get isFelica =>
      this == NFCTagType.Felica;
  bool get isIso7816 =>
      this == NFCTagType.Iso7816;
  bool get isIso15693 =>
      this == NFCTagType.Iso15693;

  bool get isUnknown =>
      this == NFCTagType.unknown;

  bool get isNotNdef =>
      this != NFCTagType.Ndef;
  bool get isNotNdefFormatable =>
      this != NFCTagType.NdefFormatable;
  bool get isNotNfcA =>
      this != NFCTagType.NfcA;
  bool get isNotNfcB =>
      this != NFCTagType.NfcB;
  bool get isNotNfcF =>
      this != NFCTagType.NfcF;
  bool get isNotNfcV =>
      this != NFCTagType.NfcV;
  bool get isNotIsoDep =>
      this != NFCTagType.IsoDep;
  bool get isNotMifare =>
      this != NFCTagType.Mifare;
  bool get isNotMifareClassic =>
      this != NFCTagType.MifareClassic;
  bool get isNotMifareUltralight =>
      this != NFCTagType.MifareUltralight;
  bool get isNotFelica =>
      this != NFCTagType.Felica;
  bool get isNotIso7816 =>
      this != NFCTagType.Iso7816;
  bool get isNotIso15693 =>
      this != NFCTagType.Iso15693;

  bool get isNotUnknown =>
      this != NFCTagType.unknown;
}