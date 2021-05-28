part of core.tag;

class _MethodChannelNFCTag extends NFCTagPlatform {
  _MethodChannelNFCTag._({
    required Map<String, dynamic> data,
    required String handle,
    required List<NFCTagType> techList,
  }) :  _handle = handle,
        _techList = techList,
        super(data: data);

  final String _handle;
  final List<NFCTagType> _techList;

  /// Returns a stub instance to allow the platform interface
  /// to access the class instance statically.
  // ignore: prefer_constructors_over_static_methods
  static _MethodChannelNFCTag get instance =>
      _MethodChannelNFCTag._(
        data: {}, handle: '', techList: []);

  @override
  String get handle => _handle;

  @override
  List<NFCTagType> get techList => _techList;

  @override
  NFCTagPlatform delegateFor({
    required Map<String, dynamic> data,
  }) {
    final _handle = data.remove('handle').toString();
    final _tech = List<String>.from(
      data.remove('techList'));

    return _MethodChannelNFCTag._(
      techList: _tech.map(
        (tech) => NFCTagType.values.firstWhere(
          (t) => t.value == tech,
          orElse: () => NFCTagType.unknown,
        )).toList(),
      data: data,
      handle: _handle);
  }

  @override
  Future<void> disposeTag() =>
    channel.invokeMethod(
      "disposeTag", {
        'handle': handle,
      });
}