part of util;

extension HexExtension on Uint8List {
  String toHexString() =>
      "0x${hex.encode(toList()).toUpperCase()}";
}