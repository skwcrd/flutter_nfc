import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_nfc/flutter_nfc.dart';

void main() {
  runApp(ExampleApp());
}

class ExampleApp extends StatefulWidget {
  @override
  _ExampleAppState createState() => _ExampleAppState();
}

class _ExampleAppState extends State<ExampleApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    _initPlatformState();
  }

  Future<void> _initPlatformState() async {
    String platformVersion;

    try {
      platformVersion = await FlutterNfc.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    if ( mounted ) {
      setState(() {
        _platformVersion = platformVersion;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Plugin example app',
          ),
        ),
        body: Center(
          child: Text(
            'Running on: $_platformVersion',
          ),
        ),
      ),
    );
  }
}