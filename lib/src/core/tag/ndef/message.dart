part of core.tag;

/// The class represents the immutable NDEF message.
class NdefMessage {
  /// Constructs an instance with given records.
  const NdefMessage({ this.records });

  factory NdefMessage.fromMap(Map<String, dynamic> arg) =>
      NdefMessage(
        records: (arg['records'] as Iterable<Map>)
          .map((record) => NdefRecord(
            typeNameFormat: NdefTypeNameFormat.values
                .firstWhere(
                  (e) => e.value == record['typeNameFormat']),
            type: Uint8List.fromList(
              record['type'] as List<int>),
            identifier: Uint8List.fromList(
              record['identifier'] as List<int>),
            payload: Uint8List.fromList(
              record['payload'] as List<int>),
          ))
          .toList());

  /// Records.
  final List<NdefRecord> records;

  /// The length in bytes of the NDEF message when stored on the tag.
  int get byteLength => records.isEmpty
      ? 0
      : records
          .map(
            (e) => e.byteLength)
          .reduce(
            (a, b) => a + b);

  Map<String, dynamic> toMap() =>
      <String, dynamic>{
        'records': records
          .map(
            (r) => r.toMap())
          .toList()
      };

  @override
  String toString() =>
      "[Ndef Message] "
      "byteLength: $byteLength, "
      "records: [ ${records.map((e) => e.toString()).join(', ')} ]";
}