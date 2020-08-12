import 'package:flutter/widgets.dart';
import 'package:flutter_app/models/priority.dart';
import 'package:flutter_app/pages/labels/label_db.dart';
import 'package:flutter_app/pages/projects/project.dart';
import 'package:flutter_app/pages/projects/project_db.dart';
import 'package:flutter_app/pages/tasks/add_task.dart';
import 'package:flutter_app/pages/tasks/bloc/add_task_bloc.dart';
import 'package:flutter_app/pages/tasks/models/tasks.dart';
import 'package:flutter_app/pages/tasks/task_db.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'test_data.dart';
import 'test_helpers.dart';

class FakeTaskDb extends Fake implements TaskDB {
  Tasks task;
  List<int> labelIds;

  Future updateTask(Tasks task, {List<int> labelIDs}) async {
    this.task = task;
    this.labelIds = labelIDs;
    return Future.value();
  }
}

class MockProjectDb extends Mock implements ProjectDB {}

class MockLabelDb extends Mock implements LabelDB {}

void main() {
  group("Add Task", () {
    testWidgets("Add Task", (tester) async {
      final mockProjectDb = MockProjectDb();
      when(mockProjectDb.getProjects(isInboxVisible: true)).thenAnswer(
          (_) => Future.value([testProject1, testProject2, testProject3]));

      final mockLabelDb = MockLabelDb();
      when(mockLabelDb.getLabels()).thenAnswer(
          (_) => Future.value([testLabel1, testLabel2, testLabel3]));

      final fakeTaskDb = FakeTaskDb();

      final addTaskBloc = AddTaskBloc(fakeTaskDb, mockProjectDb, mockLabelDb);
      var addTaskWidget = AddTaskScreen().wrapMaterialAppWithBloc(addTaskBloc);
      await tester.pumpWidget(addTaskWidget);
      await expectLater(
          find.byType(AddTaskScreen), matchesGoldenFile('add_task.png'));

      expect(find.text("Add Task"), findsOneWidget);
      var taskTitleKey = find.byKey(ValueKey("addTitle"));
      await tester.tap(taskTitleKey);
      await tester.pump();
      await tester.enterText(taskTitleKey, "My Task");
      await tester.pump();

      var addTaskButtonFinder = find.byKey(ValueKey("addTask"));
      await tester.tap(addTaskButtonFinder);
      await tester.pump();

      expect(fakeTaskDb.task.title, "My Task");
      expect(fakeTaskDb.task.priority, Status.PRIORITY_4);
      expect(fakeTaskDb.task.projectId, Project.getInbox().id);
      expect(fakeTaskDb.labelIds, []);
    });
  });
}
