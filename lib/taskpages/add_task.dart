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
      body: new Container(
        child: new Column(
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
            new Text(text),
            new Padding(
              padding: const EdgeInsets.all(16.0),
              child: new RaisedButton(
                  child: new Text("Save"),
                  onPressed: () {
                    var id = new DateTime.now().millisecondsSinceEpoch;
                    var task = new Tasks(id: id, title: text);
                    AppDatabase.get().updateTask(task).then((book) {
                      print(book);
                      Navigator.pop(context,true);
                    });
                  }),
            )
          ],
        ),
      ),
    );
  }
}
