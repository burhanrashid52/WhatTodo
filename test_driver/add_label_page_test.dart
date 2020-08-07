import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group("Add Labels", () {
    FlutterDriver driver;
    final sideDrawer = find.byValueKey('drawer');
    final drawerLabels = find.byValueKey('drawerLabels');
    final addLabel = find.byValueKey('addLabel');
    final titleAddLabel = find.byValueKey('titleAddLabel');

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

    test('Test Add Label screen display on click of Add Label button',
        () async {
      await driver.tap(sideDrawer);
      await driver.tap(drawerLabels);
      await driver.tap(addLabel);
      expect(await driver.getText(titleAddLabel), "Add Label");
      //Need to clear the page from stack else give problem with other tests
      await driver.tap(find.pageBack());
    });

    test('Enter Label Details and verify on Side drawer screen', () async {
      await driver.tap(sideDrawer);
      await driver.tap(drawerLabels);
      await driver.tap(addLabel);

      var addLabelNameField = find.byValueKey('textFormLabelName');
      await driver.tap(addLabelNameField);
      await driver.enterText("Android");

      var addLabelButton = find.byValueKey('addLabelButton');
      await driver.tap(addLabelButton);

      await driver.tap(sideDrawer);
      await driver.tap(drawerLabels);

      var personalLabel = find.byValueKey('Android_1');
      expect(await driver.getText(personalLabel), "@ Android");
      //TODO Match the Label color as well
    });
  });
}
