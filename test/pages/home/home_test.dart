import 'package:flutter/material.dart';
import 'package:flutter_app/db/AppDatabase.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/models/Label.dart';
import 'package:flutter_app/models/Project.dart';
import 'package:flutter_app/models/Tasks.dart';
import 'package:flutter_app/pages/tasks/add_task.dart';
import 'package:flutter_app/pages/tasks/task_complted.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_app/pages/home/home.dart';

import '../../helper.dart';

void main() {
  group('Completed Task', () {
    testWidgets('completed task option is available in menu', (tester) async {
      await tester.pumpWidget(
        HomeScreen().wrapWithMaterialApp().wrapWithProviderScope(),
      );
      await tester.tap(find.byKey(ValueKey('key_home_option')));
      await tester.pumpAndSettle();
      expect(find.text('Completed Task'), findsOneWidget);
    });

    testWidgets('Open task completed screen', (tester) async {
      await tester.pumpWidget(
        HomeScreen().wrapWithMaterialApp().wrapWithProviderScope(),
      );
      await tester.tapAndSettle(find.byKey(ValueKey('key_home_option')));
      await tester.tapAndSettle(find.text('Completed Task'));
      expect(find.byType(TaskCompletedScreen), findsOneWidget);
    });
  });

  group('Add Task', () {
    testWidgets('Open task completed screen', (tester) async {
      final fakeObserver = FakeNavigatorObserver();
      await tester.pumpWidget(
        HomeScreen().wrapWithMaterialApp(
          navigatorObservers: [fakeObserver],
        ).wrapWithProviderScope(),
      );
      await tester.tapAndSettle(find.byType(FloatingActionButton));

      //didPush route is called.
      expect(fakeObserver.route != null, true);
      expect(fakeObserver.previousRoute != null, true);

      expect(find.byType(AddTaskScreen), findsOneWidget);
    });
  });

  group('Home Task List', () {
    testWidgets('No Task Added', (tester) async {
      await tester.pumpWidget(
        HomeScreen().wrapWithMaterialApp().wrapWithProviderScope(),
      );
      await tester.pumpAndSettle();
      expect(find.text('No Task Added'), findsOneWidget);
    });

    testWidgets('Show task item in list', (tester) async {
      await tester.pumpWidget(
        HomeScreen().wrapWithMaterialApp().wrapWithProviderScope(
          overrides: [
            taskDatabaseProvider.overrideWithValue(FakeTaskDatabase()),
          ],
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Task One'), findsOneWidget);
      expect(find.text('Android'), findsOneWidget);
    });

    testWidgets('Filter task based on project', (tester) async {
      await tester.pumpWidget(
        HomeScreen().wrapWithMaterialApp().wrapWithProviderScope(
          overrides: [
            projectDatabaseProvider.overrideWithValue(FakeProjectDatabase()),
            taskDatabaseProvider.overrideWithValue(FakeTaskDatabase())
          ],
        ),
      );
      await tester.pumpAndSettle();
      await tester.dragFrom(
          tester.getTopLeft(find.byType(MaterialApp)), Offset(300, 0));
      await tester.pumpAndSettle();
      await tester.tapAndSettle(find.text('Projects'));
      await tester.tapAndSettle(find.text('Flutter'));
      expect(find.text('Flutter'), findsNWidgets(2));
      expect(find.text('Task Two'), findsOneWidget);
    });

    testWidgets('Filter task based on label', (tester) async {
      await tester.pumpWidget(
        HomeScreen().wrapWithMaterialApp().wrapWithProviderScope(
          overrides: [
            labelDatabaseProvider.overrideWithValue(FakeLabelDatabase()),
            taskDatabaseProvider.overrideWithValue(FakeTaskDatabase())
          ],
        ),
      );
      await tester.pumpAndSettle();
      await tester.dragFrom(
          tester.getTopLeft(find.byType(MaterialApp)), Offset(300, 0));
      await tester.pumpAndSettle();
      await tester.tapAndSettle(find.text('Labels'));
      await tester.tapAndSettle(find.text('@ Mobile'));
      expect(find.text('Mobile'), findsOneWidget);
      expect(find.text('Task Three'), findsOneWidget);
    });
  });

  group('Swipe Tasks', () {
    testWidgets('Left to right to mark as completed', (tester) async {
      var fakeTaskDatabase = FakeTaskDatabase();
      await tester.pumpWidget(
        HomeScreen().wrapWithMaterialApp().wrapWithProviderScope(
          overrides: [
            taskDatabaseProvider.overrideWithValue(fakeTaskDatabase),
          ],
        ),
      );
      await tester.pumpAndSettle();

      await tester.drag(find.byType(Dismissible), const Offset(-500.0, 0.0));
      await tester.pumpAndSettle();

      expect(fakeTaskDatabase.taskStatus, TaskStatus.COMPLETE);
    });
    testWidgets('right to left to delete', (tester) async {
      final fakeTaskDatabase = FakeTaskDatabase();
      await tester.pumpWidget(
        HomeScreen().wrapWithMaterialApp().wrapWithProviderScope(
          overrides: [
            taskDatabaseProvider.overrideWithValue(fakeTaskDatabase),
          ],
        ),
      );
      await tester.pumpAndSettle();

      await tester.drag(find.byType(Dismissible), const Offset(500.0, 0.0));
      await tester.pumpAndSettle();

      expect(fakeTaskDatabase.deletedTaskId, 1);
    });
  });
}

class FakeNavigatorObserver extends NavigatorObserver {
  Route<dynamic> route;

  Route<dynamic> previousRoute;

  @override
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    this.route = route;
    this.previousRoute = previousRoute;
    super.didPush(route, previousRoute);
  }
}

class FakeTaskDatabase extends TaskDatabase {
  FakeTaskDatabase() : super(null);

  @override
  Future<List<Tasks>> getTasksByProject(int projectId) {
    final tasks = Tasks.create(
      title: 'Task Two',
      projectId: 2,
    );
    tasks.projectName = 'Flutter';
    tasks.projectColor = Colors.blue.value;
    return Future.value([
      tasks,
    ]);
  }

  @override
  Future<List<Tasks>> getTasksByLabel(String labelName) {
    final tasks = Tasks.create(
      title: 'Task Three',
      projectId: 3,
    );
    tasks.projectName = 'Flutter';
    tasks.projectColor = Colors.blue.value;
    return Future.value([
      tasks,
    ]);
  }

  int deletedTaskId;

  @override
  Future deleteTask(int taskID) {
    deletedTaskId = taskID;
    return Future.value();
  }

  @override
  Future<List<Tasks>> getTasks(
      {int startDate = 0, int endDate = 0, TaskStatus taskStatus}) {
    final tasks = Tasks.create(
      title: 'Task One',
      projectId: 1,
    );
    tasks.id = 1;
    tasks.projectName = 'Android';
    tasks.projectColor = Colors.green.value;
    return Future.value([
      tasks,
    ]);
  }

  TaskStatus taskStatus;

  @override
  Future updateTaskStatus(int taskID, TaskStatus status) {
    this.taskStatus = status;
    return Future.value();
  }
}

class FakeLabelDatabase extends LabelDatabase {
  FakeLabelDatabase() : super(null);

  @override
  Future<List<Label>> getLabels() async {
    return [
      Label.create(
        'Mobile',
        Colors.blueGrey.value,
        "Blue Grey",
      ),
    ];
  }
}

class FakeProjectDatabase extends ProjectDatabase {
  FakeProjectDatabase() : super(null);

  @override
  Future<List<Project>> getProjects({bool isInboxVisible = true}) async {
    return [
      Project.create(
        'Flutter',
        Colors.blue.value,
        "Blue",
      ),
    ];
  }
}
