library core.session;

import 'package:flutter/foundation.dart'
  show
    required,
    protected;
import 'package:flutter/services.dart'
  show
    MethodCall,
    MissingPluginException;

import '../../utils/utils.dart';
import '../interface.dart';
import '../tag/tag.dart'
  show
    NFCTag,
    NFCTagPlatform;

part 'method_channel.dart';
part 'platform.dart';
part 'polling.dart';

/// Signature for `NfcSession.startSession` onTagDiscovered callback.
/// Callback for handling on NFC tag detection.
typedef TagCallback = void Function(NFCTag uid);

/// Signature for `NfcSession.startSession` onSessionError callback.
/// Callback for handling on NFC error from the session.
typedef ErrorCallback = void Function(NfcError error);
