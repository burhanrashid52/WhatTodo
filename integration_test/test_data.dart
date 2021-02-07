import 'package:flutter/material.dart';
import 'package:flutter_app/models/priority.dart';
import 'package:flutter_app/pages/labels/label.dart';
import 'package:flutter_app/pages/projects/project.dart';
import 'package:flutter_app/pages/tasks/models/tasks.dart';

//Project Test data
var testProject1 = Project.getInbox();
var testProject2 = Project.update(
  id: 2,
  name: "Personal",
  colorCode: Colors.red.value,
  colorName: "Red",
);
var testProject3 = Project.update(
  id: 3,
  name: "Work",
  colorCode: Colors.black.value,
  colorName: "Black",
);
var testProject4 = Project.update(
  id: 4,
  name: "Travel",
  colorCode: Colors.orange.value,
  colorName: "Orange",
);

//Label Test data
var testLabel1 = Label.update(
  id: 1,
  name: "Android",
  colorCode: Colors.green.value,
  colorName: "Green",
);

var testLabel2 = Label.update(
  id: 2,
  name: "Flutter",
  colorCode: Colors.lightBlue.value,
  colorName: "Blue Light",
);

var testLabel3 = Label.update(
  id: 3,
  name: "React",
  colorCode: Colors.purple.value,
  colorName: "Purple",
);


//Task Test data
var testTask1 = Tasks.update(
  id: 1,
  title: "Task One",
  projectId: 1,
  priority: Status.PRIORITY_3,
  dueDate: DateTime.now().millisecondsSinceEpoch,
);

var testTask2 = Tasks.update(
  id: 2,
  title: "Task Two",
  projectId: 2,
  priority: Status.PRIORITY_2,
  dueDate: DateTime.now().millisecondsSinceEpoch,
);

var testTask3 = Tasks.update(
  id: 3,
  title: "Task Three",
  projectId: 3,
  priority: Status.PRIORITY_1,
  dueDate: DateTime.now().add(new Duration(days: 7)).millisecondsSinceEpoch,
);
