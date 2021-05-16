import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_nfc_example/main.dart';

void main() {
  testWidgets('Verify Platform version', (tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const App());

    // Verify that platform version is retrieved.
    expect(
      find.byWidgetPredicate(
        (widget) => widget is Text &&
                    widget.data.startsWith('Running on:'),
      ),
      findsOneWidget,
    );
  });
}