import 'package:flutter/material.dart';
import 'package:flutter_app/models/priority.dart';
import 'package:flutter_app/pages/labels/label.dart';
import 'package:flutter_app/pages/projects/project.dart';
import 'package:flutter_app/pages/tasks/models/tasks.dart';

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
