part of core.tag;

/// The class represents the response `APDU`.
class Iso7816ResponseApdu {
  /// Constructs an instance with the given values.
  const Iso7816ResponseApdu({
    this.payload,
    this.statusWord1,
    this.statusWord2,
  });

  factory Iso7816ResponseApdu.fromMap(Map<String, dynamic> arg) =>
      Iso7816ResponseApdu(
        payload: Uint8List.fromList(
          arg['payload'] as List<int>),
        statusWord1: arg['statusWord1'] as int,
        statusWord2: arg['statusWord2'] as int);

  /// Payload.
  final Uint8List payload;

  /// Status Word 1.
  final int statusWord1;

  /// Status Word 2.
  final int statusWord2;

  @override
  String toString() =>
      "[Iso7816 Response Apdu] "
      "payload: ${payload.toHexString()}, "
      "statusWord1: $statusWord1, "
      "statusWord2: $statusWord2";
}