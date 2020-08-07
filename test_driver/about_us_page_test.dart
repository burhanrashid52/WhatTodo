import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group("About Screen", () {
    FlutterDriver driver;
    final titleAbout = find.byValueKey('titleAbout');
    final titleReport = find.byValueKey('titleReport');
    final subtitleReport = find.byValueKey('subtitleReport');
    final authorName = find.byValueKey('authorName');
    final authorUsername = find.byValueKey('authorUsername');
    final authorEmail = find.byValueKey('authorEmail');
    final versionNumber = find.byValueKey('versionNumber');

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

    test('Profile Details', () async {
      expect(await driver.getText(titleAbout), "About");
      expect(await driver.getText(titleReport), "Report an Issue");
      expect(await driver.getText(subtitleReport), "Having an issue ? Report it here");
      expect(await driver.getText(authorName), "Burhanuddin Rashid");
      expect(await driver.getText(authorUsername), "burhanrashid52");
      expect(await driver.getText(authorEmail), "burhanrashid5253@gmail.com");
      expect(await driver.getText(versionNumber), "1.0.0");
    });
  });
}
