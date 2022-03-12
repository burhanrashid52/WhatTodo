import 'package:flutter/material.dart';
import 'package:flutter_app/db/AppDatabase.dart';
import 'package:flutter_app/models/Tasks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_app/pages/home/home.dart';

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
      AppDatabase.setTestInstance(FakeAppDatabase());
      await tester.pumpWidget(
        HomeScreen().wrapWithMaterialApp(),
      );
      await tester.pumpAndSettle();
      expect(find.text('Task One'), findsOneWidget);
      expect(find.text('Android'), findsOneWidget);
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
}

extension WidgetWrapperExtension on Widget {
  Widget wrapWithMaterialApp() {
    return MaterialApp(
      home: this,
    );
  }
}
