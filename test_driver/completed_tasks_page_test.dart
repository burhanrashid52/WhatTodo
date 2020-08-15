import 'package:flutter_app/utils/keys.dart';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Completed Tasks Page', () {
    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
      await driver.requestData("addData");
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        await driver.requestData("cleanData");
        driver.close();
      }
    });

    test('Show Today Tasks', () async {
      /*This delayed allows to load the database for the first time.
        It's hacky solution to avoid flakiness
      */
      await Future.delayed(const Duration(seconds: 1), () {});

      var drawer = find.byValueKey(SideDrawerKeys.DRAWER);
      await driver.tap(drawer);

      var today = find.byValueKey(SideDrawerKeys.TODAY);
      await driver.tap(today);

      var firstTaskListItem = find.byValueKey('swipe_1_0');

      //swipe left to mark as complete
      await driver.scroll(
          firstTaskListItem, -300, 0, Duration(milliseconds: 500));
      await Future.delayed(const Duration(seconds: 1), () {});

      await driver.tap(find.byValueKey(CompletedTaskPageKeys.POPUP_ACTION));
      await driver.tap(find.byValueKey(CompletedTaskPageKeys.COMPLETED_TASKS));

      var firstCompletedTaskListItem = find.byValueKey('task_completed_1');
      expect(await driver.getText(firstCompletedTaskListItem), "Task One");

      //swipe left to mark to undo
      await driver.scroll(
          firstCompletedTaskListItem, -300, 0, Duration(milliseconds: 500));

      await driver.tap(find.pageBack());

      var firstUndoTaskListItem = find.byValueKey('taskTitle_1');
      expect(await driver.getText(firstUndoTaskListItem), "Task One");
    });
  });
}
