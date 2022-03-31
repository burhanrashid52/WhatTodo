import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/db/AppDatabase.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/models/Label.dart';
import 'package:flutter_app/models/Priority.dart';
import 'package:flutter_app/models/Project.dart';
import 'package:flutter_app/models/Tasks.dart';
import 'package:flutter_app/utils/app_util.dart';
import 'package:flutter_app/utils/color_utils.dart';
import 'package:flutter_app/utils/date_util.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddTaskScreen extends ConsumerStatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends ConsumerState<AddTaskScreen> {
  String text = "";
  int dueDate = DateTime.now().millisecondsSinceEpoch;
  Status priorityStatus = Status.PRIORITY_4;
  Project currentSelectedProject = Project.getInbox();
  List<Label> selectedLabelList = List();
  GlobalKey<FormState> _formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final taskDb = ref.watch(taskDatabaseProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Task"),
      ),
      body: ListView(
        children: <Widget>[
          Form(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                  validator: (value) {
                    var msg = value.isEmpty ? "Title Cannot be Empty" : null;
                    return msg;
                  },
                  onSaved: (value) {
                    text = value;
                  },
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(hintText: "Title")),
            ),
            key: _formState,
          ),
          ListTile(
            leading: Icon(Icons.book),
            title: Text("Project"),
            subtitle: Text(currentSelectedProject.name),
            onTap: () {
              _showProjectsDialog(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text("Due Date"),
            subtitle: Text(getFormattedDate(dueDate)),
            onTap: () {
              _selectDate(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.flag),
            title: Text("Priority"),
            subtitle: Text(priorityText[priorityStatus.index]),
            onTap: () {
              _showPriorityDialog(context).then((status) {
                if (status != null) {
                  setState(() {
                    priorityStatus = status;
                  });
                }
              });
            },
          ),
          ListTile(
              leading: Icon(Icons.label),
              title: Text("Lables"),
              subtitle: Text(selectedLabelList.length == 0
                  ? "No Label"
                  : getDisplayLabels()),
              onTap: () {
                _showLabelsDialog(context);
              }),
          ListTile(
            leading: Icon(Icons.mode_comment),
            title: Text("Comments"),
            subtitle: Text("No Comments"),
            onTap: () {
              showSnackbar(context, "Comming Soon");
            },
          ),
          ListTile(
            leading: Icon(Icons.timer),
            title: Text("Reminder"),
            subtitle: Text("No Reminder"),
            onTap: () {
              showSnackbar(context, "Comming Soon");
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.send, color: Colors.white),
          onPressed: () {
            if (_formState.currentState.validate()) {
              _formState.currentState.save();
              List<int> labelIds = List();
              selectedLabelList.forEach((label) {
                labelIds.add(label.id);
              });
              var task = Tasks.create(
                  title: text,
                  dueDate: dueDate,
                  priority: priorityStatus,
                  projectId: currentSelectedProject.id);
              taskDb.updateTask(task, labelIDs: labelIds).then((_) {
                Navigator.pop(context, true);
              });
            }
          }),
    );
  }

  String getDisplayLabels() {
    List<String> selectedLabelNameList = List();
    selectedLabelList.forEach((label) {
      selectedLabelNameList.add("@${label.name}");
    });
    return selectedLabelNameList.join("  ");
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null) {
      setState(() {
        dueDate = picked.millisecondsSinceEpoch;
      });
    }
  }

  Future<Status> _showPriorityDialog(BuildContext context) async {
    return await showDialog<Status>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Select Priority'),
            children: <Widget>[
              buildContainer(Status.PRIORITY_1),
              buildContainer(Status.PRIORITY_2),
              buildContainer(Status.PRIORITY_3),
              buildContainer(Status.PRIORITY_4),
            ],
          );
        });
  }

  Future<Status> _showProjectsDialog(BuildContext context) async {
    return AppDatabase.get().getProjects().then((projects) {
      showDialog<Status>(
          context: context,
          builder: (BuildContext context) {
            return SimpleDialog(
                title: const Text('Select Project'),
                children: buildProjects(projects));
          });
    });
  }

  Future<Status> _showLabelsDialog(BuildContext context) async {
    return AppDatabase.get().getLabels().then((label) {
      showDialog<Status>(
          context: context,
          builder: (BuildContext context) {
            return SimpleDialog(
                title: const Text('Select Labels'),
                children: buildLabels(label));
          });
    });
  }

  List<Widget> buildProjects(List<Project> projectList) {
    List<Widget> projects = List();
    projectList.forEach((project) {
      projects.add(ListTile(
        leading: Container(
          width: 12.0,
          height: 12.0,
          child: CircleAvatar(
            backgroundColor: Color(project.colorValue),
          ),
        ),
        title: Text(project.name),
        onTap: () {
          setState(() {
            currentSelectedProject = project;
          });
          Navigator.pop(context);
        },
      ));
    });
    return projects;
  }

  List<Widget> buildLabels(List<Label> labelList) {
    List<Widget> labels = List();
    labelList.forEach((label) {
      labels.add(ListTile(
        leading: Icon(Icons.label, color: Color(label.colorValue), size: 18.0),
        title: Text(label.name),
        trailing:
            selectedLabelList.contains(label) ? Icon(Icons.close) : Container(),
        onTap: () {
          setState(() {
            if (!selectedLabelList.contains(label)) {
              selectedLabelList.add(label);
            } else {
              selectedLabelList.remove(label);
            }
          });
          Navigator.pop(context);
        },
      ));
    });
    return labels;
  }

  GestureDetector buildContainer(Status status) {
    return GestureDetector(
        onTap: () {
          Navigator.pop(context, status);
        },
        child: Container(
            color: status == priorityStatus ? Colors.grey : Colors.white,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 2.0),
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    width: 6.0,
                    color: priorityColor[status.index],
                  ),
                ),
              ),
              child: Container(
                margin: const EdgeInsets.all(12.0),
                child: Text(priorityText[status.index],
                    style: TextStyle(fontSize: 18.0)),
              ),
            )));
  }
}
