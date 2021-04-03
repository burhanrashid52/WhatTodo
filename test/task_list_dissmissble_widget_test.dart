import 'package:flutter/material.dart';
import 'package:flutter_app/pages/tasks/bloc/task_bloc.dart';
import 'package:flutter_app/pages/tasks/row_task.dart';
import 'package:flutter_app/pages/tasks/task_db.dart';
import 'package:flutter_app/pages/tasks/task_widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'task_list_dissmissble_widget_test.mocks.dart';
import 'test_data.dart';
import 'test_helpers.dart';

@GenerateMocks([TaskDB])
void main() {
  testWidgets(("Task page with empty task list"), (tester) async {
    final mockTaskDb = MockTaskDB();

    //Return empty task list
    when(mockTaskDb.getTasks(
        startDate: anyNamed("startDate"),
        endDate: anyNamed("endDate"),
        taskStatus: anyNamed("taskStatus")))
        .thenAnswer((_) => Future.value(List.empty()));

    var taskBloc = TaskBloc(mockTaskDb);

    final wrapMaterialAppWithBlock = TasksPage().wrapScaffoldWithBloc(taskBloc);
    await tester.pumpWidget(wrapMaterialAppWithBlock);
    //Show progress when fetch from db initially
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.byType(TaskRow), findsNothing);

    taskBloc.refresh();
    await tester.pump();
    expect(find.text("No Task Added"), findsOneWidget);
    expect(find.byType(TaskRow), findsNothing);
  });

  testWidgets(("Task page with 3 task list"), (tester) async {
    final mockTaskDb = MockTaskDB();

    testTask1.projectName = testProject1.name;
    testTask1.projectColor = testProject1.colorValue;

    testTask2.projectName = testProject2.name;
    testTask2.projectColor = testProject2.colorValue;

    testTask3.projectName = testProject3.name;
    testTask3.projectColor = testProject3.colorValue;

    //Return empty task list
    when(mockTaskDb.getTasks(
        startDate: anyNamed("startDate"),
        endDate: anyNamed("endDate"),
        taskStatus: anyNamed("taskStatus")))
        .thenAnswer((_) => Future.value([testTask1, testTask2, testTask3]));

    var taskBloc = TaskBloc(mockTaskDb);

    final wrapMaterialAppWithBlock = TasksPage().wrapScaffoldWithBloc(taskBloc);
    await tester.pumpWidget(wrapMaterialAppWithBlock);

    //Show progress when fetch from db initially
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.byType(TaskRow), findsNothing);

    taskBloc.refresh();
    await tester.pump();
    expect(find.byType(TaskRow), findsNWidgets(3));
    expect(find.text(testTask1.title), findsOneWidget);
    expect(find.text(testTask2.title), findsOneWidget);
    expect(find.text(testTask3.title), findsOneWidget);
    expect(find.text("No Task Added"), findsNothing);
  });

  testWidgets(("Swipe left to mark task as completed"), (tester) async {
    final mockTaskDb = MockTaskDB();

    testTask1.projectName = testProject1.name;
    testTask1.projectColor = testProject1.colorValue;

    testTask2.projectName = testProject2.name;
    testTask2.projectColor = testProject2.colorValue;

    //Return empty task list
    when(mockTaskDb.getTasks(
        startDate: anyNamed("startDate"),
        endDate: anyNamed("endDate"),
        taskStatus: anyNamed("taskStatus")))
        .thenAnswer((_) => Future.value([testTask1, testTask2]));

    when(mockTaskDb.deleteTask(any)).thenAnswer((_) => Future.value());

    var taskBloc = TaskBloc(mockTaskDb);

    final wrapMaterialAppWithBlock = TasksPage().wrapScaffoldWithBloc(taskBloc);
    await tester.pumpWidget(wrapMaterialAppWithBlock);
    taskBloc.refresh();

    await tester.pump();

    //Return task list after delete
    when(mockTaskDb.getTasks(
        startDate: anyNamed("startDate"),
        endDate: anyNamed("endDate"),
        taskStatus: anyNamed("taskStatus")))
        .thenAnswer((_) => Future.value([testTask2]));

    // Swipe the item to dismiss it.
    const position = 0;
    await tester.drag(find.byKey(ValueKey("swipe_${testTask1.id}_$position")),
        Offset(500.0, 0.0));
    await tester.pumpAndSettle();

    expect(find.byType(TaskRow), findsNWidgets(1));
    expect(find.text(testTask1.title), findsNothing);
    expect(find.text(testTask2.title), findsOneWidget);
    expect(verify(mockTaskDb.deleteTask(captureAny)).captured.single,
        testTask1.id);
  });
}
