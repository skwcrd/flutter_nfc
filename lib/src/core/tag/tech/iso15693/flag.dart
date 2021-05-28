part of core.tag;

/// Represents `RequestFlag` on iOS.
enum Iso15693RequestFlag {
  /// Indicates [RequestFlag#address] on iOS.
  address,

  /// Indicates [RequestFlag#dualSubCarriers] on iOS.
  dualSubCarriers,

  /// Indicates [RequestFlag#highDataRate] on iOS.
  highDataRate,

  /// Indicates [RequestFlag#option] on iOS.
  option,

  /// Indicates [RequestFlag#protocolExtension] on iOS.
  protocolExtension,

  /// Indicates [RequestFlag#select] on iOS.
  select,
}

extension _Iso15693RequestFlagValue on Iso15693RequestFlag {
  String get value {
    switch (this) {
      case Iso15693RequestFlag.address:
        return 'address';

      case Iso15693RequestFlag.dualSubCarriers:
        return 'dualSubCarriers';

      case Iso15693RequestFlag.highDataRate:
        return 'highDataRate';

      case Iso15693RequestFlag.option:
        return 'option';

      case Iso15693RequestFlag.protocolExtension:
        return 'protocolExtension';

      case Iso15693RequestFlag.select:
        return 'select';

      default:
        throw UnimplementedError(
          "Unexpected Iso15693 request flag value");
    }
  }
}