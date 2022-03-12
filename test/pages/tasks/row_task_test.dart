import 'package:flutter/material.dart';
import 'package:flutter_app/models/Priority.dart';
import 'package:flutter_app/models/Tasks.dart';
import 'package:flutter_app/pages/tasks/row_task.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helper.dart';

void main() {
  testWidgets('Task Row Golden', (tester) async {
    final tasks = Tasks.create(
      title: 'Task One',
      projectId: 1,
      priority: Status.PRIORITY_2,
    );
    tasks.projectName = 'Android';
    tasks.projectColor = Colors.green.value;
    await tester.pumpWidget(
      TaskRow(tasks).wrapWithMaterialApp().wrapToSizeForGoldenTest(
            Size(400, 75),
          ),
    );
    await tester.pumpAndSettle();
    await expectLater(
      find.byType(TaskRow),
      matchesGoldenFile('row_task.png'),
    );
  });
}
