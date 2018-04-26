import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/db/AppDatabase.dart';
import 'package:flutter_app/models/Priority.dart';
import 'package:flutter_app/models/Tasks.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskState createState() => new _AddTaskState();
}

class _AddTaskState extends State<AddTaskScreen> {
  String text = "";
  int dueDate = new DateTime.now().millisecondsSinceEpoch;
  Status priorityStatus = Status.PRIORITY_4;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Add Task"),
      ),
      body: new ListView(
        children: <Widget>[
          new Padding(
            padding: const EdgeInsets.all(8.0),
            child: new TextField(
                onChanged: (value) {
                  setState(() {
                    text = value;
                  });
                },
                decoration: new InputDecoration(hintText: "Title")),
          ),
          new ListTile(
            leading: new Icon(Icons.calendar_today),
            title: new Text("Due Date"),
            subtitle: new Text(_getFormattedDate(dueDate)),
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
            subtitle: new Text("@Movies"),
          ),
          new ListTile(
            leading: new Icon(Icons.mode_comment),
            title: new Text("Comments"),
            subtitle: new Text("No Comments"),
          ),
          new ListTile(
            leading: new Icon(Icons.timer),
            title: new Text("Reminder"),
            subtitle: new Text("No Reminder"),
          )
        ],
      ),
      floatingActionButton: new FloatingActionButton(
          child: new Icon(Icons.send, color: Colors.white),
          onPressed: () {
            var id = new DateTime.now().millisecondsSinceEpoch;
            var task = new Tasks(
                id: id,
                title: text,
                dueDate: dueDate,
                priority: priorityStatus);
            AppDatabase.get().updateTask(task).then((book) {
              print(book);
              Navigator.pop(context, true);
            });
          }),
    );
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

  String _getFormattedDate(int dueDate) {
    DateTime date = new DateTime.fromMillisecondsSinceEpoch(dueDate);
    return "${monthsNames[date.month - 1]}  ${date.day}";
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

var monthsNames = [
  "Jan",
  "Feb",
  "Mar",
  "Apr",
  "May",
  "Jun",
  "July",
  "Aug",
  "Sept",
  "Oct",
  "Nov",
  "Dec"
];
