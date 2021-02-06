import 'package:flutter_app/main.dart' as app;
import 'package:flutter_app/utils/keys.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'test_helper.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group("Add Projects", () {
    testWidgets(
        'Test Add Project screen display on click of Add Project button',
        (WidgetTester tester) async {
      app.main();

      await tester.pumpAndSettle();
      await tester.tap(find.byValueKey(SideDrawerKeys.DRAWER));
      await tester.pumpAndSettle();

      await tester.tap(find.byValueKey(SideDrawerKeys.DRAWER_PROJECTS));
      await tester.pumpAndSettle();

      await tester.tap(find.byValueKey(SideDrawerKeys.ADD_PROJECT));
      await tester.pumpAndSettle();

      expect(find.text("Add Project"), findsOneWidget);
    }, skip: true);

    testWidgets('Enter Project Details and verify on Side drawer screen',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.tap(find.byValueKey(SideDrawerKeys.DRAWER));
      await tester.pumpAndSettle();

      await tester.tap(find.byValueKey(SideDrawerKeys.DRAWER_PROJECTS));
      await tester.pumpAndSettle();

      await tester.tap(find.byValueKey(SideDrawerKeys.ADD_PROJECT));
      await tester.pumpAndSettle();

      final addProjectName =
          find.byValueKey(AddProjectKeys.TEXT_FORM_PROJECT_NAME);
      await tester.enterText(addProjectName, "Personal");

      await tester.tap(find.byValueKey(AddProjectKeys.ADD_PROJECT_BUTTON));
      await tester.pumpAndSettle();

      await tester.tap(find.byValueKey(SideDrawerKeys.DRAWER));
      await tester.pumpAndSettle();

      await tester.tap(find.byValueKey(SideDrawerKeys.DRAWER_PROJECTS));
      await tester.pumpAndSettle();

      expect(find.text("Personal"), findsOneWidget);
      //TODO Match the project color as well
    });
  });
}
