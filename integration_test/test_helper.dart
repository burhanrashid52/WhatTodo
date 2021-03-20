// @dart=2.9
import 'package:flutter/widgets.dart';
import 'package:flutter_app/pages/labels/label_db.dart';
import 'package:flutter_app/pages/projects/project_db.dart';
import 'package:flutter_app/pages/tasks/task_db.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_data.dart';

extension TestFinder on CommonFinders {
  Finder byValueKey(String key) {
    return find.byKey(ValueKey(key));
  }
}

extension TestWidgetTester on WidgetTester {
  Future<void> tapAndSettle(String key) async {
    await this.tap(find.byKey(ValueKey(key)));
    await pumpAndSettle();
  }
}

seedDataInDb() async {
  var projectDB = ProjectDB.get();
  await projectDB.insertOrReplace(testProject1);
  await projectDB.insertOrReplace(testProject2);
  await projectDB.insertOrReplace(testProject3);
  await projectDB.insertOrReplace(testProject4);

  var labelDB = LabelDB.get();
  await labelDB.updateLabels(testLabel1);
  await labelDB.updateLabels(testLabel2);
  await labelDB.updateLabels(testLabel3);

  var taskDB = TaskDB.get();
  await taskDB.updateTask(testTask1);
  await taskDB.updateTask(testTask2);
  await taskDB.updateTask(testTask3);
}

cleanDb() async {
  var projectDB = ProjectDB.get();
  projectDB.deleteProject(1);
  projectDB.deleteProject(2);
  projectDB.deleteProject(3);
  projectDB.deleteProject(4);

  var labelDB = LabelDB.get();
  labelDB.deleteLabel(1);
  labelDB.deleteLabel(2);
  labelDB.deleteLabel(3);
}
