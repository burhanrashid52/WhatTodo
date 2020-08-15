import 'package:flutter_app/utils/keys.dart';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group("Add Projects", () {
    FlutterDriver driver;
    final sideDrawer = find.byValueKey(SideDrawerKeys.DRAWER);
    final drawerProjects = find.byValueKey(SideDrawerKeys.DRAWER_PROJECTS);
    final addProject = find.byValueKey(SideDrawerKeys.ADD_PROJECT);
    final titleAddProject = find.byValueKey(AddProjectKeys.TITLE_ADD_PROJECT);

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

    test('Test Add Project screen display on click of Add Project button',
        () async {
      await driver.tap(sideDrawer);
      await driver.tap(drawerProjects);
      await driver.tap(addProject);
      expect(await driver.getText(titleAddProject), "Add Project");
      //Need to clear the page from stack else give problem with other tests
      await driver.tap(find.pageBack());
    });

    test('Enter Project Details and verify on Side drawer screen', () async {
      await driver.tap(sideDrawer);
      await driver.tap(drawerProjects);
      await driver.tap(addProject);

      var addProjectNameField = find.byValueKey(AddProjectKeys.TEXT_FORM_PROJECT_NAME);
      await driver.tap(addProjectNameField);
      await driver.enterText("Personal");

      var addProjectButton = find.byValueKey(AddProjectKeys.ADD_PROJECT_BUTTON);
      await driver.tap(addProjectButton);

      await driver.tap(sideDrawer);
      await driver.tap(drawerProjects);

      var personalProject = find.byValueKey('Personal_2');
      expect(await driver.getText(personalProject), "Personal");
      //TODO Match the project color as well
    });
  });
}
