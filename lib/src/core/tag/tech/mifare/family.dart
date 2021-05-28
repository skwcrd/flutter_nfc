part of core.tag;

/// Represents `NFCMifareFamily` on iOS.
enum MifareFamily {
  /// Indicates [NFCMifareFamily#unknown] on iOS.
  unknown,

  /// Indicates [NFCMifareFamily#ultralight] on iOS.
  ultralight,

  /// Indicates [NFCMifareFamily#plus] on iOS.
  plus,

  /// Indicates [NFCMifareFamily#desfire] on iOS.
  desfire,
}

extension _MifareFamilyValue on MifareFamily {
  int get value {
    switch (this) {
      case MifareFamily.unknown:
        return 1;

      case MifareFamily.ultralight:
        return 2;

      case MifareFamily.plus:
        return 3;

      case MifareFamily.desfire:
        return 4;

      default:
        return 1;
    }
  }
}