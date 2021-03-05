import 'package:flutter/material.dart';
import 'package:flutter_app/pages/about/about_us.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_app/main.dart' as app;
import 'package:flutter_app/utils/keys.dart';
import 'home_page_test.dart';
import 'test_helper.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group("About Screen", () {
    testWidgets('Profile Details', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AboutUsScreen(),
        ),
      );
      expect(find.text("About"), findsOneWidget);
      expect(find.text("Report an Issue"), findsOneWidget);
      expect(find.text("Having an issue ? Report it here"), findsOneWidget);
      expect(find.text("Burhanuddin Rashid"), findsOneWidget);
      expect(find.text("burhanrashid52"), findsOneWidget);
      expect(find.text("burhanrashid5253@gmail.com"), findsOneWidget);
      expect(find.text("1.0.0"), findsOneWidget);
    });
  });

  group("Add Labels", () {
    testWidgets('Test Add Label screen display on click of Add Label button',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.tapAndSettle(SideDrawerKeys.DRAWER);

      await tester.tapAndSettle(SideDrawerKeys.DRAWER_LABELS);

      await tester.tapAndSettle(SideDrawerKeys.ADD_LABEL);

      expect(find.text("Add Label"), findsOneWidget);
    });

    testWidgets('Enter Label Details and verify on Side drawer screen',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.tapAndSettle(SideDrawerKeys.DRAWER);

      await tester.tapAndSettle(SideDrawerKeys.DRAWER_LABELS);

      await tester.tapAndSettle(SideDrawerKeys.ADD_LABEL);

      var addLabelNameField =
          find.byValueKey(AddLabelKeys.TEXT_FORM_LABEL_NAME);

      await tester.enterText(addLabelNameField, "Android");
      await tester.pumpAndSettle();

      await tester.tapAndSettle(AddLabelKeys.ADD_LABEL_BUTTON);

      await tester.tapAndSettle(SideDrawerKeys.DRAWER);

      await tester.tapAndSettle(SideDrawerKeys.DRAWER_LABELS);

      expect(find.text("@ Android"), findsOneWidget);
      //TODO Match the Label color as well
    });
  });

  group("Add Projects", () {
    testWidgets(
        'Test Add Project screen display on click of Add Project button',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.tapAndSettle(SideDrawerKeys.DRAWER);

      await tester.tapAndSettle(SideDrawerKeys.DRAWER_PROJECTS);

      await tester.tapAndSettle(SideDrawerKeys.ADD_PROJECT);

      expect(find.text("Add Project"), findsOneWidget);
    }, skip: true);

    testWidgets('Enter Project Details and verify on Side drawer screen',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.tapAndSettle(SideDrawerKeys.DRAWER);

      await tester.tapAndSettle(SideDrawerKeys.DRAWER_PROJECTS);

      await tester.tapAndSettle(SideDrawerKeys.ADD_PROJECT);

      final addProjectName =
          find.byValueKey(AddProjectKeys.TEXT_FORM_PROJECT_NAME);
      await tester.enterText(addProjectName, "Personal");

      await tester.tapAndSettle(AddProjectKeys.ADD_PROJECT_BUTTON);

      await tester.tapAndSettle(SideDrawerKeys.DRAWER);

      await tester.tapAndSettle(SideDrawerKeys.DRAWER_PROJECTS);

      expect(find.text("Personal"), findsOneWidget);
      //TODO Match the project color as well
    });
  });

  group("Add Tasks", () {
    testWidgets('Enter Task Details and verify on Task page screen',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.tapAndSettle(HomePageKeys.ADD_NEW_TASK_BUTTON);

      expect(find.text("Add Task"), findsOneWidget);

      await tester.enterText(
          find.byValueKey(AddTaskKeys.ADD_TITLE), "First Task");
      await tester.pumpAndSettle();
      //TODO: 1. Add Project in selection 2. Add Label from dialog 3. Change due date

      await tester.tapAndSettle(AddTaskKeys.ADD_TASK);

      expect(find.text("First Task"), findsOneWidget);
      expect(find.text("Inbox"), findsOneWidget);
    });
  });

  group('Completed Tasks Page', () {
    testWidgets('Show Today Tasks', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      await seedDataInDb();

      await tester.tapAndSettle(SideDrawerKeys.DRAWER);

      await tester.tapAndSettle(SideDrawerKeys.TODAY);

      //swipe left to mark as complete
      var firstTaskListItem = find.byValueKey('swipe_1_0');
      await tester.drag(firstTaskListItem, const Offset(-300.0, 0.0));
      await tester.pumpAndSettle();

      await tester.tapAndSettle(CompletedTaskPageKeys.POPUP_ACTION);

      await tester.tapAndSettle(CompletedTaskPageKeys.COMPLETED_TASKS);

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

  group('Home Page', () {

    setUp(() async {
      await cleanDb();
    });

    testWidgets('Today in Title', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      expect(find.text("Today"), findsOneWidget);
      expect(find.text("No Task Added"), findsOneWidget);
    });

    testWidgets('Show Today Tasks', (WidgetTester tester) async {
      await seedAndStartApp(tester);

      await tester.tapAndSettle(SideDrawerKeys.DRAWER);

      await tester.tapAndSettle(SideDrawerKeys.TODAY);

      expect(find.text("Today"), findsOneWidget);

      expect(find.text("Task One"), findsOneWidget);
      expect(find.text("Inbox"), findsOneWidget);

      expect(find.text("Task Two"), findsOneWidget);
      expect(find.text("Personal"), findsOneWidget);

      await cleanDb();
    });

    testWidgets('Show Inbox Tasks', (WidgetTester tester) async {
      await seedAndStartApp(tester);

      await tester.tapAndSettle(SideDrawerKeys.DRAWER);

      await tester.tapAndSettle(SideDrawerKeys.INBOX);

      expect(find.text("Task One"), findsOneWidget);
      expect(find.text("Inbox"), findsNWidgets(2));
      await cleanDb();
    });

    testWidgets('Show Next 7 days Tasks', (WidgetTester tester) async {
      await seedAndStartApp(tester);

      await tester.tapAndSettle(SideDrawerKeys.DRAWER);

      await tester.tapAndSettle(SideDrawerKeys.NEXT_7_DAYS);

      expect(find.text("Next 7 Days"), findsOneWidget);

      expect(find.text("Task One"), findsOneWidget);
      expect(find.text("Inbox"), findsOneWidget);

      expect(find.text("Task Two"), findsOneWidget);
      expect(find.text("Personal"), findsOneWidget);

      expect(find.text("Task Three"), findsOneWidget);
      expect(find.text("Work"), findsOneWidget);

      await cleanDb();
    });

    testWidgets('Show Personal project Tasks', (WidgetTester tester) async {
      await seedAndStartApp(tester);

      await tester.tapAndSettle(SideDrawerKeys.DRAWER);

      await tester.tapAndSettle(SideDrawerKeys.DRAWER_PROJECTS);

      await tester.tapAndSettle('Personal_2');

      expect(find.text("Task Two"), findsOneWidget);
      expect(find.text("Personal"), findsNWidgets(2));
    });

    testWidgets('Show No Travel project Tasks Found',
        (WidgetTester tester) async {
      await seedAndStartApp(tester);

      await tester.tapAndSettle(SideDrawerKeys.DRAWER);

      await tester.tapAndSettle(SideDrawerKeys.DRAWER_PROJECTS);

      await tester.tapAndSettle('Travel_4');

      expect(find.text("No Task Added"), findsOneWidget);

      await cleanDb();
    });

    //TODO: Add test for tasks Label Filter
  });
}
