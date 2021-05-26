part of core.tag;

/// Represents `PollingTimeSlot` on iOS.
enum FelicaPollingTimeSlot {
  /// Indicates [PollingTimeSlot#max1] on iOS.
  max1,

  /// Indicates [PollingTimeSlot#max2] on iOS.
  max2,

  /// Indicates [PollingTimeSlot#max4] on iOS.
  max4,

  /// Indicates [PollingTimeSlot#max8] on iOS.
  max8,

  /// Indicates [PollingTimeSlot#max16] on iOS.
  max16,
}

extension _FelicaPollingTimeSlotValue on FelicaPollingTimeSlot {
  int get value {
    switch (this) {
      case FelicaPollingTimeSlot.max1:
        return 0x00;

      case FelicaPollingTimeSlot.max2:
        return 0x01;

      case FelicaPollingTimeSlot.max4:
        return 0x03;

      case FelicaPollingTimeSlot.max8:
        return 0x07;

      case FelicaPollingTimeSlot.max16:
        return 0x0F;

      default:
        return 0x00;
    }
  }
}