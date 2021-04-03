// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_app/pages/about/about_us.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group("About Screen", () {
    testWidgets('Profile Details', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AboutUsScreen(),
        ),
      );
      expect(find.text("About"), findsOneWidget);
      expect(find.text("Report an Issue"), findsOneWidget);
      expect(find.text("Having an issue ? Report it here"), findsOneWidget);
      expect(find.text("Burhanuddin Rashid"), findsOneWidget);
      expect(find.text("burhanrashid52"), findsOneWidget);
      expect(find.text("burhanrashid5253@gmail.com"), findsOneWidget);
      expect(find.text("1.0.0"), findsOneWidget);
    });
  });
}
