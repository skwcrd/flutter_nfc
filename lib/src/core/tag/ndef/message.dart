part of core.tag;

/// The class represents the immutable NDEF message.
class NdefMessage {
  /// Constructs an instance with given records.
  const NdefMessage({ required this.records });

  factory NdefMessage.fromMap(Map<String, dynamic> arg) =>
      NdefMessage(
        records: (arg['records'] as Iterable<Map>)
          .map((record) => NdefRecord(
            typeNameFormat: NdefTypeNameFormat.values
                .firstWhere(
                  (e) => e.value == record['typeNameFormat'],
                  orElse: () => NdefTypeNameFormat.unknown,
                ),
            type: record['type'],
            identifier: record['identifier'],
            payload: record['payload'],
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