import 'package:flutter/material.dart';
import 'package:flutter_app/db/AppDatabase.dart';
import 'package:flutter_app/models/Label.dart';
import 'package:flutter_app/models/Project.dart';
import 'package:flutter_app/models/Tasks.dart';
import 'package:flutter_app/pages/home/side_drawer.dart';
import 'package:flutter_app/pages/tasks/add_task.dart';
import 'package:flutter_app/pages/tasks/row_task.dart';
import 'package:flutter_app/pages/tasks/task_complted.dart';
import 'package:flutter_app/utils/app_util.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();

  HomeScreen({
    AppDatabase appDatabase,
  }) : this.appDatabase = appDatabase ??
            AppDatabase
                .get(); //This will be backward compatible with all other dependencies

  final AppDatabase appDatabase;
}

class _HomeState extends State<HomeScreen> {
  final List<Tasks> taskList = List();
  GlobalKey<ScaffoldState> _scaffoldHomeState = GlobalKey<ScaffoldState>();
  String homeTitle = "Today";
  int taskStartTime, taskEndTime;

  @override
  void initState() {
    var dateTime = DateTime.now();
    taskStartTime = DateTime(dateTime.year, dateTime.month, dateTime.day)
        .millisecondsSinceEpoch;
    taskEndTime =
        DateTime(dateTime.year, dateTime.month, dateTime.day, 23, 59)
            .millisecondsSinceEpoch;
    updateTasks(taskStartTime, taskEndTime);
    super.initState();
  }

  void updateTasks(int taskStartTime, int taskEndTime) {
    database
        .getTasks(
            startDate: taskStartTime,
            endDate: taskEndTime,
            taskStatus: TaskStatus.PENDING)
        .then((tasks) {
      if (tasks == null) return;
      setState(() {
        taskList.clear();
        taskList.addAll(tasks);
      });
    });
  }

  void updateTasksByProject(Project project) {
    database.getTasksByProject(project.id).then((tasks) {
      if (tasks == null) return;
      setState(() {
        homeTitle = project.name;
        taskList.clear();
        taskList.addAll(tasks);
      });
    });
  }

  void updateTasksByLabel(Label label) {
    database.getTasksByLabel(label.name).then((tasks) {
      if (tasks == null) return;
      setState(() {
        homeTitle = label.name;
        taskList.clear();
        taskList.addAll(tasks);
      });
    });
  }

  AppDatabase get database => widget.appDatabase;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldHomeState,
      appBar: AppBar(
        title: Text(homeTitle),
        actions: <Widget>[buildPopupMenu()],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.orange,
        onPressed: () async {
          bool isDataChanged = await Navigator.push(
            context,
            MaterialPageRoute<bool>(
                builder: (context) => AddTaskScreen()),
          );

          if (isDataChanged) {
            updateTasks(taskStartTime, taskEndTime);
          }
        },
      ),
      drawer: SideDrawer(
        appDatabase: database,
        projectSelection: (project) {
          updateTasksByProject(project);
        },
        labelSelection: (label) {
          updateTasksByLabel(label);
        },
        dateSelection: (startTime, endTime) {
          var dayInMillis = 86340000;
          homeTitle =
              endTime - startTime > dayInMillis ? "Next 7 Days" : "Today";
          taskStartTime = startTime;
          taskEndTime = endTime;
          updateTasks(startTime, endTime);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: taskList.length == 0
            ? emptyView("No Task Added")
            : Container(
                child: ListView.builder(
                    itemCount: taskList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Dismissible(
                          key: ObjectKey(taskList[index]),
                          onDismissed: (DismissDirection direction) {
                            var taskID = taskList[index].id;
                            setState(() {
                              taskList.removeAt(index);
                            });
                            if (direction == DismissDirection.endToStart) {
                              database
                                  .updateTaskStatus(taskID, TaskStatus.COMPLETE)
                                  .then((value) {
                                showSnackbar(_scaffoldHomeState,
                                    "Task mark as completed",
                                    materialColor: Colors.green);
                              });
                            } else {
                              database.deleteTask(taskID).then((value) {
                                showSnackbar(_scaffoldHomeState, "Task Deleted",
                                    materialColor: Colors.red);
                              });
                            }
                          },
                          background: Container(
                            color: Colors.red,
                            child: ListTile(
                              leading:
                                  Icon(Icons.delete, color: Colors.white),
                            ),
                          ),
                          secondaryBackground: Container(
                            color: Colors.green,
                            child: ListTile(
                              trailing:
                                  Icon(Icons.check, color: Colors.white),
                            ),
                          ),
                          child: TaskRow(taskList[index]));
                    }),
              ),
      ),
    );
  }

// This menu button widget updates a _selection field (of type WhyFarther,
// not shown here).
  Widget buildPopupMenu() {
    return PopupMenuButton<MenuItem>(
      key: ValueKey('key_home_option'),
      onSelected: (MenuItem result) async {
        switch (result) {
          case MenuItem.taskCompleted:
            bool isDataChanged = await Navigator.push(
              context,
              MaterialPageRoute<bool>(
                  builder: (context) => TaskCompletedScreen()),
            );
            updateTasks(taskStartTime, taskEndTime);
            break;
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<MenuItem>>[
        const PopupMenuItem<MenuItem>(
          value: MenuItem.taskCompleted,
          child: const Text('Completed Task'),
        )
      ],
    );
  }
}

// This is the type used by the popup menu below.
enum MenuItem { taskCompleted }
