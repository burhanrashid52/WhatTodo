import 'package:flutter/material.dart';
import 'package:flutter_app/db/AppDatabase.dart';
import 'package:flutter_app/models/Tasks.dart';
import 'package:flutter_app/taskpages/add_task.dart';
import 'package:flutter_app/taskpages/row_task.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<HomeScreen> {
  List<Tasks> taskList = new List();

  @override
  void initState() {
    // TODO: implement initState
    updateTasks();
    super.initState();
  }

  void updateTasks() {
    AppDatabase.get().getTasks().then((tasks) {
      if (tasks == null) return;
      setState(() {
        taskList.clear();
        taskList.addAll(tasks);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Today"),
      ),
      floatingActionButton: new FloatingActionButton(
        child: new Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.orange,
        onPressed: () async {
          bool isDataChanged = await Navigator.push(
            context,
            new MaterialPageRoute<bool>(
                builder: (context) => new AddTaskScreen()),
          );

          if (isDataChanged) {
            updateTasks();
          }
        },
      ),
      drawer: new Drawer(
        child: new ListView(
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[new DrawerHeader(child: new CircleAvatar())],
        ),
      ),
      body: new Container(
        child: new ListView.builder(
            itemCount: taskList.length,
            itemBuilder: (BuildContext context, int index) {
              return new TaskRow(taskList[index]);
            }),
      ),
    );
  }
}
