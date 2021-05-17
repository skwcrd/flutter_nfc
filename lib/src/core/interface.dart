library core.interface;

import 'dart:async'
  show StreamController;

import 'package:flutter/foundation.dart'
  show
    required,
    protected;
import 'package:flutter/services.dart';

import 'tags/tags.dart';

abstract class NFCInterface {
  /// Pass a private, class-specific `const Object()` as the `token`.
  NFCInterface({ @required Object token })
      : _instanceToken = token;

  static const MethodChannel _channel =
      MethodChannel('plugin.skwcrd.com/flutter_nfc');

  // ignore: close_sinks
  static final _tagController =
      StreamController<NFCTag>.broadcast();
  // ignore: close_sinks
  static final _dataController =
      StreamController<Map<String, dynamic>>.broadcast();

  final Object _instanceToken;

  @protected
  MethodChannel get channel => _channel;

  @protected
  StreamController<NFCTag> get tagController => _tagController;

  @protected
  StreamController<Map<String, dynamic>> get dataController => _dataController;

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