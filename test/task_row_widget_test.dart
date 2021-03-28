import 'package:flutter/material.dart';
import 'package:flutter_app/models/priority.dart';
import 'package:flutter_app/pages/tasks/models/tasks.dart';
import 'package:flutter_app/pages/tasks/row_task.dart';
import 'package:flutter_app/utils/color_utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'test_helpers.dart';

void main() {
  Future<void> verifyPriorityColor(WidgetTester tester, Status priority) async {
    var testTask = Tasks.update(
        id: 1, title: "Task One", projectId: 1, priority: priority);

    testTask.projectName = "Inbox";
    testTask.projectColor = Colors.grey.value;

    var wrapMaterialApp = TaskRow(testTask).wrapMaterialApp();
    await tester.pumpWidget(wrapMaterialApp);

    var container = tester.findWidgetByKey<Container>("taskPriority_1");
    expect(
        container.getBorderLeftColor(), priorityColor[testTask.priority.index]);
  }

  testWidgets("Task row smoke test without labels",
      (WidgetTester tester) async {
    //Set 15 august 2020 date for testing i.e Aug  15 in UI
    var dueDate = DateTime(2020, 8, 15);

    var testTask1 = Tasks.update(
        id: 1,
        title: "Task One",
        projectId: 1,
        priority: Status.PRIORITY_3,
        dueDate: dueDate.millisecondsSinceEpoch);

    testTask1.projectName = "Inbox";
    testTask1.projectColor = Colors.grey.value;

    var wrapMaterialApp = TaskRow(testTask1).wrapMaterialApp();
    await tester.pumpWidget(wrapMaterialApp);

    expect(find.text(testTask1.title), findsOneWidget);
    expect(find.text(testTask1.projectName!), findsOneWidget);
    expect(find.text('Aug  15'), findsOneWidget);

    var container = tester.findWidgetByKey<Container>("taskPriority_1");
    expect(container.getBorderLeftColor(),
        priorityColor[testTask1.priority.index]);

    //Test no label is visible
    expect(find.byKey(ValueKey("taskLabels_1")), findsNothing);
  });

  testWidgets("Task row smoke test with labels", (WidgetTester tester) async {
    //Set 15 august 2020 date for testing i.e Aug  15 in UI
    var dueDate = DateTime(2020, 8, 15);

    var testTask1 = Tasks.update(
        id: 1,
        title: "Task One",
        projectId: 1,
        priority: Status.PRIORITY_3,
        dueDate: dueDate.millisecondsSinceEpoch);

    testTask1.projectName = "Inbox";
    testTask1.projectColor = Colors.grey.value;
    testTask1.labelList = ["Android", "Flutter"];

    var wrapMaterialApp = TaskRow(testTask1).wrapMaterialApp();
    await tester.pumpWidget(wrapMaterialApp);

    expect(find.text(testTask1.title), findsOneWidget);
    expect(find.text(testTask1.projectName!), findsOneWidget);
    expect(find.text('Aug  15'), findsOneWidget);

    //Test labels are visible
    expect(find.byKey(ValueKey("taskLabels_1")), findsOneWidget);
    expect(find.text("Android  Flutter"), findsOneWidget);
  });

  testWidgets("Task row smoke test with priorities color",
      (WidgetTester tester) async {
    await verifyPriorityColor(tester, Status.PRIORITY_1);
    await verifyPriorityColor(tester, Status.PRIORITY_2);
    await verifyPriorityColor(tester, Status.PRIORITY_3);
    await verifyPriorityColor(tester, Status.PRIORITY_4);
  });
}
