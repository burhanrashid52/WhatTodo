// @dart=2.9
import 'package:flutter_app/main.dart' as app;
import 'package:flutter_app/utils/keys.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'test_helper.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Home Page', () {
    testWidgets('Today in Title', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      expect(find.text("Today"), findsOneWidget);
      expect(find.text("No Task Added"), findsOneWidget);
    });

    testWidgets('Show Today Tasks', (WidgetTester tester) async {
      await seedAndStartApp(tester);

      await tester.tapAndSettle(SideDrawerKeys.DRAWER);

      await tester.tapAndSettle(SideDrawerKeys.TODAY);

      expect(find.text("Today"), findsOneWidget);

      expect(find.text("Task One"), findsOneWidget);
      expect(find.text("Inbox"), findsOneWidget);

      expect(find.text("Task Two"), findsOneWidget);
      expect(find.text("Personal"), findsOneWidget);
    });

    testWidgets('Show Inbox Tasks', (WidgetTester tester) async {
      await seedAndStartApp(tester);

      await tester.tapAndSettle(SideDrawerKeys.DRAWER);

      await tester.tapAndSettle(SideDrawerKeys.INBOX);

      expect(find.text("Task One"), findsOneWidget);
      expect(find.text("Inbox"), findsNWidgets(2));
    });

    testWidgets('Show Next 7 days Tasks', (WidgetTester tester) async {
      await seedAndStartApp(tester);

      await tester.tapAndSettle(SideDrawerKeys.DRAWER);

      await tester.tapAndSettle(SideDrawerKeys.NEXT_7_DAYS);

      expect(find.text("Next 7 Days"), findsOneWidget);

      expect(find.text("Task One"), findsOneWidget);
      expect(find.text("Inbox"), findsOneWidget);

      expect(find.text("Task Two"), findsOneWidget);
      expect(find.text("Personal"), findsOneWidget);

      expect(find.text("Task Three"), findsOneWidget);
      expect(find.text("Work"), findsOneWidget);
    });

    testWidgets('Show Personal project Tasks', (WidgetTester tester) async {
      await seedAndStartApp(tester);

      await tester.tapAndSettle(SideDrawerKeys.DRAWER);

      await tester.tapAndSettle(SideDrawerKeys.DRAWER_PROJECTS);

      await tester.tapAndSettle('Personal_2');

      expect(find.text("Task Two"), findsOneWidget);
      expect(find.text("Personal"), findsNWidgets(2));
    });

    testWidgets('Show No Travel project Tasks Found',
        (WidgetTester tester) async {
      await seedAndStartApp(tester);

      await tester.tapAndSettle(SideDrawerKeys.DRAWER);

      await tester.tapAndSettle(SideDrawerKeys.DRAWER_PROJECTS);

      await tester.tapAndSettle('Travel_4');

      expect(find.text("No Task Added"), findsOneWidget);
    });

    //TODO: Add test for tasks Label Filter
  });

  tearDown(() async {
    await cleanDb();
  });
}

Future seedAndStartApp(WidgetTester tester) async {
  app.main();
  await seedDataInDb();
  await tester.pumpAndSettle();
}
