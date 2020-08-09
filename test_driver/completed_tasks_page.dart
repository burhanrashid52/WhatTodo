import 'package:flutter/material.dart';
import 'package:flutter_app/models/priority.dart';
import 'package:flutter_app/pages/labels/label.dart';
import 'package:flutter_app/pages/labels/label_db.dart';
import 'package:flutter_app/pages/projects/project.dart';
import 'package:flutter_app/pages/projects/project_db.dart';
import 'package:flutter_app/pages/tasks/models/tasks.dart';
import 'package:flutter_app/pages/tasks/task_db.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:flutter_app/main.dart' as app;

Future<void> main() async {
  // ignore: missing_return
  Future<String> dataHandler(String msg) async {
    print(msg);
    switch (msg) {
      case "addData":
        seedDataInDb();
        break;
      case "clearData":
        cleanDb();
        break;
    }
  }

  // This line enables the extension.
  enableFlutterDriverExtension(handler: dataHandler);

  // Call the `main()` function of the app, or call `runApp` with
  // any widget you are interested in testing.
  app.main();
}

seedDataInDb() async {
  var projectDB = ProjectDB.get();
  await projectDB.insertOrReplace(testProject1);
  await projectDB.insertOrReplace(testProject2);
  await projectDB.insertOrReplace(testProject3);

  var labelDB = LabelDB.get();
  await labelDB.updateLabels(testLabel1);
  await labelDB.updateLabels(testLabel2);
  await labelDB.updateLabels(testLabel3);

  var taskDB = TaskDB.get();
  await taskDB.updateTask(testTask1);
  await taskDB.updateTask(testTask2);
  await taskDB.updateTask(testTask3);
}

void cleanDb() async {
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

var testProject1 = Project.create("Personal", Colors.red.value, "Red");
var testProject2 = Project.create("Work", Colors.black.value, "Black");
var testProject3 = Project.create("Travel", Colors.orange.value, "Orange");

var testLabel1 = Label.create("Android", Colors.green.value, "Green");
var testLabel2 = Label.create("Flutter", Colors.lightBlue.value, "Blue Light");
var testLabel3 = Label.create("React", Colors.purple.value, "Purple");

var testTask1 = Tasks.create(
    title: "Task One",
    projectId: 1,
    priority: Status.PRIORITY_3,
    dueDate: DateTime.now().millisecondsSinceEpoch);

var testTask2 = Tasks.create(
    title: "Task Two",
    projectId: 2,
    priority: Status.PRIORITY_2,
    dueDate: DateTime.now().millisecondsSinceEpoch);

var testTask3 = Tasks.create(
    title: "Task Three",
    projectId: 3,
    priority: Status.PRIORITY_1,
    dueDate: DateTime.now().add(new Duration(days: 7)).millisecondsSinceEpoch);
