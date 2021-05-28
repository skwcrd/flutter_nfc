library app;

import 'package:flutter/material.dart';

import 'views/views.dart';

class App extends StatelessWidget {
  /// start widget root app, run in main.
  const App({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NFC Example',
      home: IndexView(),
    );
}