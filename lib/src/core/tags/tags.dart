library core.tag;

import 'dart:async'
  show StreamController;
import 'dart:typed_data'
  show
    Int8List,
    Uint8List;

import 'package:flutter/foundation.dart'
  show
    required,
    protected;
import 'package:flutter/services.dart'
  show PlatformException;

import '../interface.dart';

part 'platform.dart';
part 'method_channal.dart';

abstract class NFCTag {
  NFCTag._(this._delegate) {
    NFCTagPlatform.verifyExtends(_delegate);
  }

  NFCTagPlatform _delegate;

  Future<void> _handleDataListener(Map<dynamic, dynamic> arg) async {
  }
}