library flutter_nfc;

import 'dart:async';

import 'package:flutter/services.dart';

class FlutterNfc {
  static const MethodChannel _channel =
      const MethodChannel('flutter_nfc');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}