import 'package:flutter/material.dart';
import 'package:flutter_app/models/priority.dart';
import 'package:flutter_app/pages/labels/label.dart';
import 'package:flutter_app/pages/projects/project.dart';
import 'package:flutter_app/pages/tasks/models/tasks.dart';

var testProject1 = Project.getInbox();
var testProject2 = Project.update(
    id: 2, name: "Personal", colorCode: Colors.red.value, colorName: "Red");
var testProject3 = Project.update(
    id: 3, name: "Work", colorCode: Colors.black.value, colorName: "Black");
var testProject4 = Project.update(
    id: 4, name: "Travel", colorCode: Colors.orange.value, colorName: "Orange");

var testLabel1 = Label.create("Android", Colors.green.value, "Green");
var testLabel2 = Label.create("Flutter", Colors.lightBlue.value, "Blue Light");
var testLabel3 = Label.create("React", Colors.purple.value, "Purple");

var testTask1 = Tasks.update(
    id: 1,
    title: "Task One",
    projectId: 1,
    priority: Status.PRIORITY_3,
    dueDate: DateTime.now().millisecondsSinceEpoch);

var testTask2 = Tasks.update(
    id: 2,
    title: "Task Two",
    projectId: 2,
    priority: Status.PRIORITY_2,
    dueDate: DateTime.now().millisecondsSinceEpoch);

var testTask3 = Tasks.update(
    id: 3,
    title: "Task Three",
    projectId: 3,
    priority: Status.PRIORITY_1,
    dueDate: DateTime.now().add(new Duration(days: 7)).millisecondsSinceEpoch);
