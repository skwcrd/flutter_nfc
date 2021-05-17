import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// import 'package:flutter_nfc/flutter_nfc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runZonedGuarded(() {
    runApp(const App());
  }, (error, stackTrace) {
    FlutterError.reportError(
      FlutterErrorDetails(
        exception: error,
        stack: stackTrace ?? StackTrace.current,
        library: "Example Exception",
        context: ErrorDescription(
          "Error on runZonedGuarded in main()")));
  });
}

class App extends StatefulWidget {
  /// start widget root app, run in main.
  const App({ Key key }) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    _initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> _initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      // platformVersion = await FlutterNfc.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return;
    }

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) =>
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Plugin example app',
          ),
        ),
        body: Center(
          child: Text(
            'Running on: $_platformVersion\n',
          ),
        ),
      ),
    );
}