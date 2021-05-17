part of core.tag;

abstract class NFCTagPlatform extends NFCInterface {
  NFCTagPlatform({
    @required this.data,
  }) : super(token: _token);

  static final Object _token = Object();

  /// Ensures that any delegate class has extended a [NFCTagPlatform].
  static void verifyExtends(NFCTagPlatform instance) {
    NFCInterface.verifyToken(instance, _token);
  }

  final Map<String, dynamic> data;

  @override
  // ignore: unnecessary_overrides
  StreamController<NFCTag> get tagController => super.tagController;

  /// Enables delegates to create new instances of themselves.
  @protected
  NFCTagPlatform delegate() {
    throw UnimplementedError('delegate() is not implemented');
  }

  Future<void> disposeTag() {
    throw UnimplementedError('disposeTag() is not implemented');
  }

  /// Sends the command to the tag.
  ///
  /// This uses transceive API on Android.
  Future<List<int>> transceive({
    @required Uint8List data,
  }) {
    throw UnimplementedError('disposeTag() is not implemented');
  }
}