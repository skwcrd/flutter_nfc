part of core.tag;

class _MethodChannelNFCTag extends NFCTagPlatform {
  _MethodChannelNFCTag._({
    required Map<String, dynamic> data,
    required String handle,
    required NFCTagType type,
  }) :  _handle = handle,
        _type = type,
        super(data: data);

  final String _handle;
  final NFCTagType _type;

  /// Returns a stub instance to allow the platform interface
  /// to access the class instance statically.
  // ignore: prefer_constructors_over_static_methods
  static _MethodChannelNFCTag get instance =>
      _MethodChannelNFCTag._(
        data: <String, dynamic>{},
        handle: '',
        type: NFCTagType.unknown);

  @override
  String get handle => _handle;

  @override
  NFCTagType get type => _type;

  @override
  NFCTagPlatform delegateFor({
    required Map<String, dynamic> data,
  }) {
    final _handle = data['handle'].toString();
    final _type = data['type'].toString();

    return _MethodChannelNFCTag._(
      data: Map<String, dynamic>.from(data['data'] as Map),
      handle: _handle,
      type: NFCTagType.values.firstWhere(
        (t) => t.value == _type,
        orElse: () => NFCTagType.unknown,
      ));
  }

  @override
  Future<void> disposeTag() =>
    channel.invokeMethod(
      "disposeTag", {
        'handle': handle,
      });
}