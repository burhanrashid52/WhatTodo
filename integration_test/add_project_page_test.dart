// @dart=2.9
import 'package:flutter_app/main.dart' as app;
import 'package:flutter_app/utils/keys.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'test_helper.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group("Add Projects", () {

    setUp(() async {
      await cleanDb();
    });

    testWidgets('Enter Project Details and verify on Side drawer screen',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.tapAndSettle(SideDrawerKeys.DRAWER);

      await tester.tapAndSettle(SideDrawerKeys.DRAWER_PROJECTS);

      await tester.tapAndSettle(SideDrawerKeys.ADD_PROJECT);

      final addProjectName =
          find.byValueKey(AddProjectKeys.TEXT_FORM_PROJECT_NAME);
      await tester.enterText(addProjectName, "Personal");

      await tester.tapAndSettle(AddProjectKeys.ADD_PROJECT_BUTTON);

      await tester.tapAndSettle(SideDrawerKeys.DRAWER);

      await tester.tapAndSettle(SideDrawerKeys.DRAWER_PROJECTS);

      expect(find.text("Personal"), findsOneWidget);
      //TODO Match the project color as well
    });
  });
}
