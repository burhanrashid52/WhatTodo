import 'package:flutter_app/utils/keys.dart';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group("Add Tasks", () {
    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    final addNewTaskButton = find.byValueKey(HomePageKeys.ADD_NEW_TASK_BUTTON);

    test('Enter Task Details and verify on Task page screen', () async {
      await driver.tap(addNewTaskButton);

      var addTaskTitle = find.byValueKey(AddTaskKeys.ADD_TASK_TITLE);
      expect(await driver.getText(addTaskTitle), "Add Task");

      var addTitle = find.byValueKey(AddTaskKeys.ADD_TITLE);
      await driver.tap(addTitle);
      await driver.enterText("First Task");
      //TODO: 1. Add Project in selection 2. Add Label from dialog 3. Change due date

      var addTask = find.byValueKey(AddTaskKeys.ADD_TASK);
      await driver.tap(addTask);

      var taskTitle = find.byValueKey('taskTitle_1');
      var taskProjectName = find.byValueKey('taskProjectName_1');

      expect(await driver.getText(taskTitle), "First Task");
      expect(await driver.getText(taskProjectName), "Inbox");
    });
  });
}
