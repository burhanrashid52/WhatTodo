import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_app/pages/home/home.dart';

void main() {
  testWidgets('completed task option is available in menu',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: HomeScreen(),
      ),
    );
    await tester.tap(find.byKey(ValueKey('key_home_option')));
    await tester.pumpAndSettle();
    expect(find.text('Completed Task'), findsOneWidget);
  });
}
