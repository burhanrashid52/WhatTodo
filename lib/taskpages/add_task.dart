import 'package:flutter/material.dart';
import 'package:flutter_app/db/AppDatabase.dart';
import 'package:flutter_app/models/Tasks.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskState createState() => new _AddTaskState();
}

class _AddTaskState extends State<AddTaskScreen> {
  String text = "";

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
            subtitle: new Text("Apr 25"),
          ),
          new ListTile(
            leading: new Icon(Icons.flag),
            title: new Text("Priority"),
            subtitle: new Text("Priority 3"),
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
            var task = new Tasks(id: id, title: text);
            AppDatabase.get().updateTask(task).then((book) {
              print(book);
              Navigator.pop(context, true);
            });
          }),
    );
  }
}
