import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/db/AppDatabase.dart';
import 'package:flutter_app/models/Label.dart';
import 'package:flutter_app/models/Priority.dart';
import 'package:flutter_app/models/Project.dart';
import 'package:flutter_app/models/Tasks.dart';
import 'package:flutter_app/utils/app_util.dart';
import 'package:flutter_app/utils/color_utils.dart';
import 'package:flutter_app/utils/date_util.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskState createState() => new _AddTaskState();
}

class _AddTaskState extends State<AddTaskScreen> {
  String text = "";
  int dueDate = new DateTime.now().millisecondsSinceEpoch;
  Status priorityStatus = Status.PRIORITY_4;
  Project currentSelectedProject = new Project.getInbox();
  List<Label> selectedLabelList = new List();
  GlobalKey<ScaffoldState> _scaffoldState = new GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _formState = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldState,
      appBar: new AppBar(
        title: new Text("Add Task"),
      ),
      body: new ListView(
        children: <Widget>[
          new Form(
            child: new Padding(
              padding: const EdgeInsets.all(8.0),
              child: new TextFormField(
                  validator: (value) {
                    var msg = value.isEmpty ? "Title Cannot be Empty" : null;
                    return msg;
                  },
                  onSaved: (value) {
                    text = value;
                  },
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: new InputDecoration(hintText: "Title")),
            ),
            key: _formState,
          ),
          new ListTile(
            leading: new Icon(Icons.book),
            title: new Text("Project"),
            subtitle: new Text(currentSelectedProject.name),
            onTap: () {
              _showProjectsDialog(context);
            },
          ),
          new ListTile(
            leading: new Icon(Icons.calendar_today),
            title: new Text("Due Date"),
            subtitle: new Text(getFormattedDate(dueDate)),
            onTap: () {
              _selectDate(context);
            },
          ),
          new ListTile(
            leading: new Icon(Icons.flag),
            title: new Text("Priority"),
            subtitle: new Text(priorityText[priorityStatus.index]),
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
          new ListTile(
              leading: new Icon(Icons.label),
              title: new Text("Lables"),
              subtitle: new Text(selectedLabelList.length == 0
                  ? "No Label"
                  : getDisplayLabels()),
              onTap: () {
                _showLabelsDialog(context);
              }),
          new ListTile(
            leading: new Icon(Icons.mode_comment),
            title: new Text("Comments"),
            subtitle: new Text("No Comments"),
            onTap: () {
              showSnackbar(_scaffoldState, "Comming Soon");
            },
          ),
          new ListTile(
            leading: new Icon(Icons.timer),
            title: new Text("Reminder"),
            subtitle: new Text("No Reminder"),
            onTap: () {
              showSnackbar(_scaffoldState, "Comming Soon");
            },
          )
        ],
      ),
      floatingActionButton: new FloatingActionButton(
          child: new Icon(Icons.send, color: Colors.white),
          onPressed: () {
            if (_formState.currentState.validate()) {
              _formState.currentState.save();
              List<int> labelIds = new List();
              selectedLabelList.forEach((label) {
                labelIds.add(label.id);
              });
              var task = new Tasks.create(
                  title: text,
                  dueDate: dueDate,
                  priority: priorityStatus,
                  projectId: currentSelectedProject.id);
              AppDatabase
                  .get()
                  .updateTask(task, labelIDs: labelIds)
                  .then((book) {
                print(book);
                Navigator.pop(context, true);
              });
            }
          }),
    );
  }

  String getDisplayLabels() {
    List<String> selectedLabelNameList = new List();
    selectedLabelList.forEach((label) {
      selectedLabelNameList.add("@${label.name}");
    });
    return selectedLabelNameList.join("  ");
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2015, 8),
        lastDate: new DateTime(2101));
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
          return new SimpleDialog(
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
            return new SimpleDialog(
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
            return new SimpleDialog(
                title: const Text('Select Labels'),
                children: buildLabels(label));
          });
    });
  }

  List<Widget> buildProjects(List<Project> projectList) {
    List<Widget> projects = new List();
    projectList.forEach((project) {
      projects.add(new ListTile(
        leading: new Container(
          width: 12.0,
          height: 12.0,
          child: new CircleAvatar(
            backgroundColor: new Color(project.colorValue),
          ),
        ),
        title: new Text(project.name),
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
    List<Widget> labels = new List();
    labelList.forEach((label) {
      labels.add(new ListTile(
        leading: new Icon(Icons.label,
            color: new Color(label.colorValue), size: 18.0),
        title: new Text(label.name),
        trailing: selectedLabelList.contains(label)
            ? new Icon(Icons.close)
            : new Container(),
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
    return new GestureDetector(
        onTap: () {
          Navigator.pop(context, status);
        },
        child: new Container(
            color: status == priorityStatus ? Colors.grey : Colors.white,
            child: new Container(
              margin: const EdgeInsets.symmetric(vertical: 2.0),
              decoration: new BoxDecoration(
                border: new Border(
                  left: new BorderSide(
                    width: 6.0,
                    color: priorityColor[status.index],
                  ),
                ),
              ),
              child: new Container(
                margin: const EdgeInsets.all(12.0),
                child: new Text(priorityText[status.index],
                    style: new TextStyle(fontSize: 18.0)),
              ),
            )));
  }
}
