import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Home Page', () {
    final homeTitle = find.byValueKey('home_title');
    final addTaskButton = find.byValueKey('add_task');

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

    test('Today in TItle', () async {
      expect(await driver.getText(homeTitle), "Today");
    });

    test('Add Task Button Clicked', () async {
      await driver.tap(addTaskButton);
      var addTaskTitle = find.byValueKey('add_task_title');
      expect(await driver.getText(addTaskTitle), "Add Task");
    });
  });
}
