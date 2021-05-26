part of core.tag;

/// Represents `PollingRequestCode` on iOS.
enum FelicaPollingRequestCode {
  /// Indicates [PollingRequestCode#noRequest] on iOS.
  noRequest,

  /// Indicates [PollingRequestCode#systemCode] on iOS.
  systemCode,

  /// Indicates [PollingRequestCode#communicationPerformamce] on iOS.
  communicationPerformance,
}

extension _FelicaPollingRequestCodeValue on FelicaPollingRequestCode {
  int get value {
    switch (this) {
      case FelicaPollingRequestCode.noRequest:
        return 0x00;

      case FelicaPollingRequestCode.systemCode:
        return 0x01;

      case FelicaPollingRequestCode.communicationPerformance:
        return 0x02;

      default:
        return 0x00;
    }
  }
}