library core.interface;

import 'package:flutter/services.dart'
  show MethodChannel;

abstract class NFCInterface {
  /// Pass a private, class-specific `const Object()` as the `token`.
  NFCInterface({
    required Object token,
  }) : _instanceToken = token;

  static const MethodChannel _channel =
      MethodChannel('plugin.skwcrd.com/flutter_nfc');

  final Object _instanceToken;

  MethodChannel get channel => _channel;

  /// Ensures that the platform instance has a token that matches the
  /// provided token and throws [AssertionError] if not.
  ///
  /// This is used to ensure that implementers are using `extends` rather
  /// than `implements`.
  ///
  /// This is implemented as a static method so that it cannot be overridden
  /// with `noSuchMethod`.
  static void verifyToken(NFCInterface instance, Object token) {
    if ( !identical(token, instance._instanceToken) ) {
      throw AssertionError(
        'Platform interfaces must not be implemented with `implements`');
    }
  }
}