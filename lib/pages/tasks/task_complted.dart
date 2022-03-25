import 'package:flutter/material.dart';
import 'package:flutter_app/db/AppDatabase.dart';
import 'package:flutter_app/models/Tasks.dart';
import 'package:flutter_app/pages/tasks/row_task_completed.dart';
import 'package:flutter_app/utils/app_util.dart';

class TaskCompletedScreen extends StatefulWidget {
  @override
  _TaskCompletedScreenState createState() => _TaskCompletedScreenState();
}

class _TaskCompletedScreenState extends State<TaskCompletedScreen> {
  final taskList = <Tasks>[];
  bool isDataChanged = false;

  @override
  void initState() {
    super.initState();
    updateTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task Completed"),
      ),
      body: taskList.length == 0
          ? const NoTaskFound(message: "No Task Complted Yet")
          : Container(
              child: ListView.builder(
                  itemCount: taskList.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                        key: ObjectKey(taskList[index]),
                        direction: DismissDirection.endToStart,
                        background: Container(),
                        onDismissed: (DismissDirection directions) {
                          if (directions == DismissDirection.endToStart) {
                            var taskID = taskList[index].id;
                            setState(() {
                              taskList.removeAt(index);
                            });
                            AppDatabase.get()
                                .updateTaskStatus(taskID, TaskStatus.PENDING)
                                .then((value) {
                              showSnackbar(context, "Task Undo");
                            });
                          }
                        },
                        secondaryBackground: Container(
                          color: Colors.grey,
                          child: ListTile(
                            trailing: Text("UNDO",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                        child: TaskCompletedRow(taskList[index]));
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
