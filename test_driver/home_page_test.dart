import 'package:flutter_app/utils/keys.dart';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Home Page', () {
    final homeTitle = find.byValueKey(HomePageKeys.HOME_TITLE);

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

    test('Today in Title', () async {
      expect(await driver.getText(homeTitle), "Today");
      var emptyTaskMessage = find.byValueKey(HomePageKeys.MESSAGE_IN_CENTER);
      expect(await driver.getText(emptyTaskMessage), "No Task Added");
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
      expect(await driver.getText(homeTitle), "Today");

      var taskTitle1 = find.byValueKey('taskTitle_1');
      var taskProjectName1 = find.byValueKey('taskProjectName_1');

      expect(await driver.getText(taskTitle1), "Task One");
      expect(await driver.getText(taskProjectName1), "Inbox");

      var taskTitle2 = find.byValueKey('taskTitle_2');
      var taskProjectName2 = find.byValueKey('taskProjectName_2');

      expect(await driver.getText(taskTitle2), "Task Two");
      expect(await driver.getText(taskProjectName2), "Personal");
    });

    test('Show Inbox Tasks', () async {
      var drawer = find.byValueKey(SideDrawerKeys.DRAWER);
      await driver.tap(drawer);

      var inbox = find.byValueKey(SideDrawerKeys.INBOX);
      await driver.tap(inbox);

      var taskTitle1 = find.byValueKey('taskTitle_1');
      var taskProjectName1 = find.byValueKey('taskProjectName_1');
      expect(await driver.getText(homeTitle), "Inbox");

      expect(await driver.getText(taskTitle1), "Task One");
      expect(await driver.getText(taskProjectName1), "Inbox");
    });

    test('Show Next 7 days Tasks', () async {
      var drawer = find.byValueKey(SideDrawerKeys.DRAWER);
      await driver.tap(drawer);

      var next7Days = find.byValueKey(SideDrawerKeys.NEXT_7_DAYS);
      await driver.tap(next7Days);
      expect(await driver.getText(homeTitle), "Next 7 Days");

      var taskTitle1 = find.byValueKey('taskTitle_1');
      var taskProjectName1 = find.byValueKey('taskProjectName_1');

      expect(await driver.getText(taskTitle1), "Task One");
      expect(await driver.getText(taskProjectName1), "Inbox");

      var taskTitle2 = find.byValueKey('taskTitle_2');
      var taskProjectName2 = find.byValueKey('taskProjectName_2');

      expect(await driver.getText(taskTitle2), "Task Two");
      expect(await driver.getText(taskProjectName2), "Personal");

      var taskTitle3 = find.byValueKey('taskTitle_3');
      var taskProjectName3 = find.byValueKey('taskProjectName_3');

      expect(await driver.getText(taskTitle3), "Task Three");
      expect(await driver.getText(taskProjectName3), "Work");
    });

    test('Show Personal project Tasks', () async {
      var drawer = find.byValueKey(SideDrawerKeys.DRAWER);
      await driver.tap(drawer);

      var drawerProjects = find.byValueKey(SideDrawerKeys.DRAWER_PROJECTS);
      await driver.tap(drawerProjects);

      var personalProject = find.byValueKey('Personal_2');
      await driver.tap(personalProject);

      var taskTitle2 = find.byValueKey('taskTitle_2');
      var taskProjectName2 = find.byValueKey('taskProjectName_2');

      expect(await driver.getText(taskTitle2), "Task Two");
      expect(await driver.getText(taskProjectName2), "Personal");
    });

    test('Show No Travel project Tasks Found', () async {
      var drawer = find.byValueKey(SideDrawerKeys.DRAWER);
      await driver.tap(drawer);

      var drawerProjects = find.byValueKey(SideDrawerKeys.DRAWER_PROJECTS);
      await driver.tap(drawerProjects);

      var personalProject = find.byValueKey('Travel_4');
      await driver.tap(personalProject);

      var emptyTaskMessage = find.byValueKey(HomePageKeys.MESSAGE_IN_CENTER);
      expect(await driver.getText(emptyTaskMessage), "No Task Added");
    });

    //TODO: Add test for tasks Label Filter
  });
}
