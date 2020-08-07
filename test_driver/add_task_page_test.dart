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

    final addTaskButton = find.byValueKey('add_task');

    test('Enter Task Details and verify on Task page screen', () async {
      await driver.tap(addTaskButton);

      var addTaskTitle = find.byValueKey('add_task_title');
      expect(await driver.getText(addTaskTitle), "Add Task");

      var addTitle = find.byValueKey('addTitle');
      await driver.tap(addTitle);
      await driver.enterText("First Task");
      //TODO: 1. Add Project in selection 2. Add Label from dialog 3. Change due date

      var addTask = find.byValueKey('addTask');
      await driver.tap(addTask);

      var taskTitle = find.byValueKey('taskTitle_1');
      var taskProjectName = find.byValueKey('taskProjectName_1');
      // var taskLabel = find.byValueKey('taskLabel');

      expect(await driver.getText(taskTitle), "First Task");
      expect(await driver.getText(taskProjectName), "Inbox");
      // expect(await driver.getText(taskLabel), "");
    });
  });
}
