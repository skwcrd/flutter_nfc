part of core.tag;

abstract class NFCTagPlatform extends NFCInterface {
  NFCTagPlatform({
    @required this.data,
  }) : super(token: _token);

  /// Create an instance using [data] using the existing implementation
  factory NFCTagPlatform.instanceFor({
    @required Map<String, dynamic> data,
  }) => NFCTagPlatform.instance.delegateFor(data: data);

  static final Object _token = Object();

  /// Ensures that any delegate class has extended a [NFCTagPlatform].
  static void verifyExtends(NFCTagPlatform instance) {
    NFCInterface.verifyToken(instance, _token);
  }

  final Map<String, dynamic> data;

  /// The current default [NFCTagPlatform] instance.
  ///
  /// It will always default to [_MethodChannelNFCTag]
  /// if no other implementation was provided.
  static NFCTagPlatform get instance =>
      _instance ??= _MethodChannelNFCTag.instance;

  static NFCTagPlatform _instance;

  /// Sets the [NFCTagPlatform.instance]
  static set instance(NFCTagPlatform instance) {
    NFCInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Enables delegates to create new instances of themselves.
  @protected
  NFCTagPlatform delegateFor({ @required Map<String, dynamic> data }) {
    throw UnimplementedError('delegateFor() is not implemented');
  }

  /// The value used by this plugin internally.
  String get handle {
    throw UnimplementedError('handle is not implemented');
  }

  /// The raw values about this tag obtained from the native platform.
  NFCTagType get type {
    throw UnimplementedError('type is not implemented');
  }

  Future<void> disposeTag() {
    throw UnimplementedError('disposeTag() is not implemented');
  }
}