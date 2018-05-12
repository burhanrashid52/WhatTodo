import 'package:flutter/material.dart';
import 'package:flutter_app/db/AppDatabase.dart';
import 'package:flutter_app/models/Tasks.dart';
import 'package:flutter_app/pages/tasks/row_task_completed.dart';
import 'package:flutter_app/utils/app_util.dart';

class TaskCompletedScreen extends StatefulWidget {
  @override
  _TaskCompletedScreenState createState() => new _TaskCompletedScreenState();
}

class _TaskCompletedScreenState extends State<TaskCompletedScreen> {
  final List<Tasks> taskList = new List();
  GlobalKey<ScaffoldState> _scaffoldTaskState = new GlobalKey<ScaffoldState>();
  bool isDataChanged = false;

  @override
  void initState() {
    super.initState();
    updateTasks();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldTaskState,
      appBar: new AppBar(
        title: new Text("Task Completed"),
      ),
      body: taskList.length == 0
          ? emptyView("No Task Complted Yet")
          : new Container(
              child: new ListView.builder(
                  itemCount: taskList.length,
                  itemBuilder: (context, index) {
                    return new Dismissible(
                        key: new ObjectKey(taskList[index]),
                        direction: DismissDirection.endToStart,
                        background: new Container(),
                        onDismissed: (DismissDirection directions) {
                          if (directions == DismissDirection.endToStart) {
                            var taskID = taskList[index].id;
                            setState(() {
                              taskList.removeAt(index);
                            });
                            AppDatabase
                                .get()
                                .updateTaskStatus(taskID, TaskStatus.PENDING)
                                .then((value) {
                              showSnackbar(_scaffoldTaskState, "Task Undo");
                            });
                          }
                        },
                        secondaryBackground: new Container(
                          color: Colors.grey,
                          child: new ListTile(
                            trailing: new Text("UNDO",
                                style: new TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                        child: new TaskCompletedRow(taskList[index]));
                  }),
            ),
    );
  }

  void updateTasks() {
    AppDatabase.get().getTasks(taskStatus: TaskStatus.COMPLETE).then((tasks) {
      if (tasks == null) return;
      setState(() {
        taskList.clear();
        taskList.addAll(tasks);
      });
    });
  }
}
