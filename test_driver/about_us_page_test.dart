import 'package:flutter_app/utils/keys.dart';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group("About Screen", () {
    FlutterDriver driver;
    final titleAbout = find.byValueKey(AboutUsKeys.TITLE_ABOUT);
    final titleReport = find.byValueKey(AboutUsKeys.TITLE_REPORT);
    final subtitleReport = find.byValueKey(AboutUsKeys.SUBTITLE_REPORT);
    final authorName = find.byValueKey(AboutUsKeys.AUTHOR_NAME);
    final authorUsername = find.byValueKey(AboutUsKeys.AUTHOR_USERNAME);
    final authorEmail = find.byValueKey(AboutUsKeys.AUTHOR_EMAIL);
    final versionNumber = find.byValueKey(AboutUsKeys.VERSION_NUMBER);

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
