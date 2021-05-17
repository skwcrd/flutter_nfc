library core.session;

import 'dart:async'
  show StreamSubscription;

import 'package:flutter/foundation.dart'
  show
    required,
    protected;
import 'package:flutter/services.dart'
  show
    MethodCall,
    PlatformException,
    MissingPluginException;

import '../../utils/utils.dart';
import '../interface.dart';
import '../tags/tags.dart'
  show NFCTag;

part 'platform.dart';
part 'method_channel.dart';

/// Signature for `NfcSession.startSession` onTagDiscovered callback.
/// Callback for handling on NFC tag detection.
typedef TagCallback = void Function(NFCTag uid);

/// Signature for `NfcSession.startSession` onSessionError callback.
/// Callback for handling on NFC error from the session.
typedef ErrorCallback = void Function(NfcError error);
