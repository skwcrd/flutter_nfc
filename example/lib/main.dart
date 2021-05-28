library main;

import 'dart:async'
  show runZonedGuarded;

import 'package:flutter/material.dart'
  show Colors;
import 'package:flutter/services.dart'
  show
    SystemChrome,
    SystemUiOverlayStyle;
import 'package:flutter/widgets.dart'
  show
    runApp,
    WidgetsFlutterBinding;
import 'package:flutter/foundation.dart'
  show
    FlutterError,
    ErrorDescription,
    FlutterErrorDetails;

import 'src/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runZonedGuarded(() async {
    /// mobile setup [SystemChrome] application
    /// orientation to portrait only.
    ///
    /// and set [OverlayStyle] for status bar
    /// on mobile, when used application.
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
      ),
    );

    runApp(const App());
  }, (error, stackTrace) {
    FlutterError.reportError(
      FlutterErrorDetails(
        exception: error,
        stack: stackTrace,
        library: "NFC Example Exception",
        context: ErrorDescription(
          "Error on runZonedGuarded in main()")));
  });
}