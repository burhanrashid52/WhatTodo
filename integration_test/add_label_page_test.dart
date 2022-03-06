// @dart=2.9
import 'package:flutter_app/main.dart' as app;
import 'package:flutter_app/utils/keys.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'test_helper.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group("Add Labels", () {
    setUp(() async {
      await cleanDb();
    });

    testWidgets('Enter Label Details and verify on Side drawer screen',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.tapAndSettle(SideDrawerKeys.DRAWER);

      await tester.tapAndSettle(SideDrawerKeys.DRAWER_LABELS);

      await tester.tapAndSettle(SideDrawerKeys.ADD_LABEL);

      var addLabelNameField =
          find.byValueKey(AddLabelKeys.TEXT_FORM_LABEL_NAME);

      await tester.enterText(addLabelNameField, "Android");
      await tester.pumpAndSettle();

      await tester.tapAndSettle(AddLabelKeys.ADD_LABEL_BUTTON);

      await tester.tapAndSettle(SideDrawerKeys.DRAWER);

      await tester.tapAndSettle(SideDrawerKeys.DRAWER_LABELS);

      expect(find.text("@ Android"), findsOneWidget);
      //TODO Match the Label color as well
    },skip: true);//Flaky on CI
  });
}
