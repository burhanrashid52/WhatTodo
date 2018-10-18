import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/application_bloc.dart';
import 'package:flutter_app/bloc/bloc_provider.dart';
import 'package:flutter_app/db/AppDatabase.dart';
import 'package:flutter_app/models/Label.dart';
import 'package:flutter_app/models/Project.dart';
import 'package:flutter_app/models/Tasks.dart';
import 'package:flutter_app/pages/home/side_drawer.dart';
import 'package:flutter_app/pages/home/task_widgets.dart';
import 'package:flutter_app/pages/tasks/add_task.dart';
import 'package:flutter_app/pages/tasks/row_task.dart';
import 'package:flutter_app/pages/tasks/task_complted.dart';
import 'package:flutter_app/utils/app_constant.dart';
import 'package:flutter_app/utils/app_util.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<HomeScreen> {
  final List<Tasks> taskList = new List();
  GlobalKey<ScaffoldState> _scaffoldHomeState = new GlobalKey<ScaffoldState>();
  String homeTitle = "Today";
  int taskStartTime, taskEndTime;

  @override
  void initState() {
    var dateTime = new DateTime.now();
    taskStartTime = new DateTime(dateTime.year, dateTime.month, dateTime.day)
        .millisecondsSinceEpoch;
    taskEndTime =
        new DateTime(dateTime.year, dateTime.month, dateTime.day, 23, 59)
            .millisecondsSinceEpoch;
    updateTasks(taskStartTime, taskEndTime);
    super.initState();
  }

  void updateTasks(int taskStartTime, int taskEndTime) {
    AppDatabase.get()
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
    AppDatabase.get().getTasksByProject(project.id).then((tasks) {
      if (tasks == null) return;
      setState(() {
        homeTitle = project.name;
        taskList.clear();
        taskList.addAll(tasks);
      });
    });
  }

  void updateTasksByLabel(Label label) {
    AppDatabase.get().getTasksByLabel(label.name).then((tasks) {
      if (tasks == null) return;
      setState(() {
        homeTitle = label.name;
        taskList.clear();
        taskList.addAll(tasks);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldHomeState,
      appBar: new AppBar(
        title: new Text(homeTitle),
        actions: <Widget>[buildPopupMenu()],
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
            //TasksBloc tasksBloc = BlocProvider.of<TasksBloc>(context);
            //tasksBloc.filterTodayTasks();
            updateTasks(taskStartTime, taskEndTime);
          }
        },
      ),
      drawer: new SideDrawer(
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
      body: BlocProvider<TasksBloc>(
        bloc: TasksBloc(AppDatabase.get()),
        child: TasksPage(),
      ),
    );
  }

// This menu button widget updates a _selection field (of type WhyFarther,
// not shown here).
  Widget buildPopupMenu() {
    return new PopupMenuButton<MenuItem>(
      onSelected: (MenuItem result) async {
        switch (result) {
          case MenuItem.taskCompleted:
            bool isDataChanged = await Navigator.push(
              context,
              new MaterialPageRoute<bool>(
                  builder: (context) => new TaskCompletedScreen()),
            );
            updateTasks(taskStartTime, taskEndTime);
            break;
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<MenuItem>>[
            const PopupMenuItem<MenuItem>(
              value: MenuItem.taskCompleted,
              child: const Text('Complted Task'),
            )
          ],
    );
  }
}

// This is the type used by the popup menu below.
enum MenuItem { taskCompleted }
