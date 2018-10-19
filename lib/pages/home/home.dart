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
  final TasksBloc _taskBloc = TasksBloc(AppDatabase.get());

  @override
  void initState() {
    super.initState();
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
        onPressed: () {
          Navigator.push(
            context,
            new MaterialPageRoute<bool>(
                builder: (context) => new AddTaskScreen()),
          );
        },
      ),
      drawer: new SideDrawer(
        projectSelection: (project) {
          _taskBloc.filterByProject(project.id);
        },
        labelSelection: (label) {
          _taskBloc.filterByLabel(label.name);
        },
        dateSelection: (startTime, endTime) {
          var dayInMillis = 86340000;
          bool isNextWeek = endTime - startTime > dayInMillis;
          homeTitle = isNextWeek ? "Next 7 Days" : "Today";
          if (isNextWeek) {
            _taskBloc.filterTasksForNextWeek();
          } else {
            _taskBloc.filterTodayTasks();
          }
        },
      ),
      body: BlocProvider<TasksBloc>(
        bloc: _taskBloc,
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
            Navigator.push(
              context,
              new MaterialPageRoute<bool>(
                  builder: (context) => new TaskCompletedScreen()),
            );
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
