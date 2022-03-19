import 'package:flutter/material.dart';
import 'package:flutter_app/db/AppDatabase.dart';
import 'package:flutter_app/models/Project.dart';
import 'package:flutter_app/models/Tasks.dart';
import 'package:flutter_app/pages/home/side_drawer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_app/pages/home/home.dart';

import '../../helper.dart';

void main() {
  testWidgets('completed task option is available in menu',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      HomeScreen().wrapWithMaterialApp(),
    );
    await tester.tap(find.byKey(ValueKey('key_home_option')));
    await tester.pumpAndSettle();
    expect(find.text('Completed Task'), findsOneWidget);
  });

  group('Home Task List', () {
    testWidgets('No Task Added', (tester) async {
      await tester.pumpWidget(
        HomeScreen().wrapWithMaterialApp(),
      );
      await tester.pumpAndSettle();
      expect(find.text('No Task Added'), findsOneWidget);
    });
    testWidgets('Show task item in list', (tester) async {
      await tester.pumpWidget(
        HomeScreen(
          appDatabase: FakeAppDatabase(),
        ).wrapWithMaterialApp(),
      );
      await tester.pumpAndSettle();
      expect(find.text('Task One'), findsOneWidget);
      expect(find.text('Android'), findsOneWidget);
    });

    testWidgets('Filter task based on project', (tester) async {
      await tester.pumpWidget(
        HomeScreen(
          appDatabase: FakeAppDatabase(),
        ).wrapWithMaterialApp(),
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
  });
}

class FakeAppDatabase extends AppDatabase {
  @override
  Future<List<Tasks>> getTasks(
      {int startDate = 0, int endDate = 0, TaskStatus taskStatus}) {
    final tasks = Tasks.create(
      title: 'Task One',
      projectId: 1,
    );
    tasks.projectName = 'Android';
    tasks.projectColor = Colors.green.value;
    return Future.value([
      tasks,
    ]);
  }

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
}
