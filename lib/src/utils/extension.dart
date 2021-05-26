part of util;

extension Uint8ListExtension on Uint8List {
  String toHexString() =>
      "0x${hex.encode(toList()).toUpperCase()}";
}