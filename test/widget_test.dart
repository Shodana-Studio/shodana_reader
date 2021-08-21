// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shodana_reader/app.dart';
import 'package:shodana_reader/ui/home/home_screen.dart';
// Temp test file, will be updated once the library is functional
void main() {
  testWidgets('test name', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: HomeScreen(),
        )
      )
    );

    final button = find.byType(FloatingActionButton);

    // ACT
    await tester.tap(button);
    await tester.pump();

    // ASSERT
    final text = find.text('book details here');
    expect(text, findsOneWidget);
  });
}
