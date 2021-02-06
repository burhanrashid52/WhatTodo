import 'package:flutter_app/main.dart' as app;
import 'package:flutter_app/utils/keys.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'test_helper.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group("Add Labels", () {
    testWidgets('Test Add Label screen display on click of Add Label button',
        (WidgetTester tester) async {
      app.main();

      await tester.pumpAndSettle();
      var sideDrawer = find.byValueKey(SideDrawerKeys.DRAWER);
      var drawerLabels = find.byValueKey(SideDrawerKeys.DRAWER_LABELS);
      var addLabel = find.byValueKey(SideDrawerKeys.ADD_LABEL);
      await tester.tap(sideDrawer);
      await tester.pumpAndSettle();

      await tester.tap(drawerLabels);
      await tester.pumpAndSettle();

      await tester.tap(addLabel);
      await tester.pumpAndSettle();

      expect(find.text("Add Label"), findsOneWidget);
    });

    testWidgets('Enter Label Details and verify on Side drawer screen',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      var sideDrawer = find.byValueKey(SideDrawerKeys.DRAWER);
      var drawerLabels = find.byValueKey(SideDrawerKeys.DRAWER_LABELS);
      var addLabel = find.byValueKey(SideDrawerKeys.ADD_LABEL);
      await tester.tap(sideDrawer);
      await tester.pumpAndSettle();

      await tester.tap(drawerLabels);
      await tester.pumpAndSettle();

      await tester.tap(addLabel);
      await tester.pumpAndSettle();

      var addLabelNameField =
          find.byValueKey(AddLabelKeys.TEXT_FORM_LABEL_NAME);

      await tester.enterText(addLabelNameField, "Android");
      await tester.pumpAndSettle();

      var addLabelButton = find.byValueKey(AddLabelKeys.ADD_LABEL_BUTTON);
      await tester.tap(addLabelButton);
      await tester.pumpAndSettle();

      await tester.tap(sideDrawer);
      await tester.pumpAndSettle();

      await tester.tap(drawerLabels);
      await tester.pumpAndSettle();

      expect(find.text("@ Android"), findsOneWidget);
      //TODO Match the Label color as well
    });
  });
}
