import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/bloc_provider.dart';
import 'package:flutter_app/models/priority.dart';
import 'package:flutter_app/pages/labels/label.dart';
import 'package:flutter_app/pages/projects/project.dart';
import 'package:flutter_app/pages/tasks/bloc/add_task_bloc.dart';
import 'package:flutter_app/utils/app_util.dart';
import 'package:flutter_app/utils/color_utils.dart';
import 'package:flutter_app/utils/date_util.dart';

class AddTaskScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldState =
      new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formState = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AddTaskBloc createTaskBloc = BlocProvider.of(context);
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
                    createTaskBloc.updateTitle = value;
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
            subtitle: StreamBuilder<Project>(
              stream: createTaskBloc.selectedProject,
              initialData: Project.getInbox(),
              builder: (context, snapshot) => new Text(snapshot.data.name),
            ),
            onTap: () {
              _showProjectsDialog(createTaskBloc, context);
            },
          ),
          new ListTile(
            leading: new Icon(Icons.calendar_today),
            title: new Text("Due Date"),
            subtitle: StreamBuilder(
              stream: createTaskBloc.dueDateSelected,
              initialData: DateTime.now().millisecondsSinceEpoch,
              builder: (context, snapshot) =>
                  Text(getFormattedDate(snapshot.data)),
            ),
            onTap: () {
              _selectDate(context);
            },
          ),
          new ListTile(
            leading: new Icon(Icons.flag),
            title: new Text("Priority"),
            subtitle: StreamBuilder(
              stream: createTaskBloc.prioritySelected,
              initialData: Status.PRIORITY_4,
              builder: (context, snapshot) =>
                  Text(priorityText[snapshot.data.index]),
            ),
            onTap: () {
              _showPriorityDialog(createTaskBloc, context);
            },
          ),
          new ListTile(
              leading: new Icon(Icons.label),
              title: new Text("Lables"),
              subtitle: StreamBuilder(
                stream: createTaskBloc.labelSelection,
                initialData: "No Labels",
                builder: (context, snapshot) => Text(snapshot.data),
              ),
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
              createTaskBloc.createTask().listen((value) {
                Navigator.pop(context, true);
              });
            }
          }),
    );
  }

  Future<Null> _selectDate(BuildContext context) async {
    AddTaskBloc createTaskBloc = BlocProvider.of(context);
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2015, 8),
        lastDate: new DateTime(2101));
    if (picked != null) {
      createTaskBloc.updateDueDate(picked.millisecondsSinceEpoch);
    }
  }

  Future<Status> _showPriorityDialog(
      AddTaskBloc createTaskBloc, BuildContext context) async {
    return await showDialog<Status>(
        context: context,
        builder: (BuildContext dialogContext) {
          return new SimpleDialog(
            title: const Text('Select Priority'),
            children: <Widget>[
              buildContainer(context, Status.PRIORITY_1),
              buildContainer(context, Status.PRIORITY_2),
              buildContainer(context, Status.PRIORITY_3),
              buildContainer(context, Status.PRIORITY_4),
            ],
          );
        });
  }

  Future<Status> _showProjectsDialog(
      AddTaskBloc createTaskBloc, BuildContext context) async {
    return showDialog<Status>(
        context: context,
        builder: (BuildContext dialogContext) {
          return StreamBuilder(
              stream: createTaskBloc.projects,
              initialData: List<Project>(),
              builder: (context, snapshot) {
                return SimpleDialog(
                  title: const Text('Select Project'),
                  children:
                      buildProjects(createTaskBloc, context, snapshot.data),
                );
              });
        });
  }

  Future<Status> _showLabelsDialog(BuildContext context) async {
    AddTaskBloc createTaskBloc = BlocProvider.of(context);
    return showDialog<Status>(
        context: context,
        builder: (BuildContext context) {
          return StreamBuilder(
              stream: createTaskBloc.labels,
              initialData: List<Label>(),
              builder: (context, snapshot) {
                return SimpleDialog(
                  title: const Text('Select Labels'),
                  children: buildLabels(createTaskBloc, context, snapshot.data),
                );
              });
        });
  }

  List<Widget> buildProjects(
    AddTaskBloc createTaskBloc,
    BuildContext context,
    List<Project> projectList,
  ) {
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
          createTaskBloc.projectSelected(project);
          Navigator.pop(context);
        },
      ));
    });
    return projects;
  }

  List<Widget> buildLabels(
    AddTaskBloc createTaskBloc,
    BuildContext context,
    List<Label> labelList,
  ) {
    List<Widget> labels = new List();
    labelList.forEach((label) {
      labels.add(new ListTile(
        leading: new Icon(Icons.label,
            color: new Color(label.colorValue), size: 18.0),
        title: new Text(label.name),
        trailing: createTaskBloc.selectedLabels.contains(label)
            ? new Icon(Icons.close)
            : new Container(width: 18.0, height: 18.0),
        onTap: () {
          createTaskBloc.labelAddOrRemove(label);
          Navigator.pop(context);
        },
      ));
    });
    return labels;
  }

  GestureDetector buildContainer(BuildContext context, Status status) {
    AddTaskBloc createTaskBloc = BlocProvider.of(context);
    return new GestureDetector(
        onTap: () {
          createTaskBloc.updatePriority(status);
          Navigator.pop(context, status);
        },
        child: new Container(
            color: status == createTaskBloc.lastPrioritySelection
                ? Colors.grey
                : Colors.white,
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
