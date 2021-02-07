import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart' as app;
import 'package:flutter_app/utils/keys.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'test_helper.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Completed Tasks Page', () {

    testWidgets('Show Today Tasks', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      await seedDataInDb();

      await tester.tap(find.byValueKey(SideDrawerKeys.DRAWER));
      await tester.pumpAndSettle();

      await tester.tap(find.byValueKey(SideDrawerKeys.TODAY));
      await tester.pumpAndSettle();


      //swipe left to mark as complete
      var firstTaskListItem = find.byValueKey('swipe_1_0');
      await tester.drag(firstTaskListItem, const Offset(-300.0, 0.0));
      await tester.pumpAndSettle();

      await tester.tap(find.byValueKey(CompletedTaskPageKeys.POPUP_ACTION));
      await tester.pumpAndSettle();

      await tester.tap(find.byValueKey(CompletedTaskPageKeys.COMPLETED_TASKS));
      await tester.pumpAndSettle();

      expect(find.text("Task One"), findsOneWidget);

      //swipe left to mark to undo
      var firstCompletedTaskListItem = find.byValueKey('task_completed_1');
      await tester.drag(firstCompletedTaskListItem, const Offset(-300.0, 0.0));
      await tester.pumpAndSettle();

      await tester.pageBack();
      await tester.pumpAndSettle();

      expect(find.text("Task One"), findsOneWidget);
    });
  });
}
