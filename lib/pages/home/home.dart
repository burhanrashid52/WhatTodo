import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/task_bloc.dart';
import 'package:flutter_app/bloc/bloc_provider.dart';
import 'package:flutter_app/db/app_db.dart';
import 'package:flutter_app/pages/home/side_drawer.dart';
import 'package:flutter_app/pages/tasks/task_widgets.dart';
import 'package:flutter_app/pages/home/title_bloc.dart';
import 'package:flutter_app/pages/tasks/add_task.dart';
import 'package:flutter_app/pages/tasks/task_complted.dart';

class HomeScreen extends StatelessWidget {
  final TitleBloc _titleBloc = TitleBloc();
  final TasksBloc _taskBloc = TasksBloc(AppDatabase.get());

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: StreamBuilder<String>(
            initialData: 'Today',
            stream: _titleBloc.title,
            builder: (context, snapshot) {
              return Text(snapshot.data);
            }),
        actions: <Widget>[buildPopupMenu(context)],
      ),
      floatingActionButton: new FloatingActionButton(
        child: new Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.orange,
        onPressed: () async {
          await Navigator.push(
            context,
            new MaterialPageRoute<bool>(
                builder: (context) => new AddTaskScreen()),
          );
          _taskBloc.refresh();
        },
      ),
      drawer: new SideDrawer(
        projectSelection: (project) {
          _titleBloc.updateTitle(project.name);
          _taskBloc.filterByProject(project.id);
        },
        labelSelection: (label) {
          _titleBloc.updateTitle('@${label.name}');
          _taskBloc.filterByLabel(label.name);
        },
        dateSelection: (startTime, endTime) {
          var dayInMillis = 86340000;
          bool isNextWeek = endTime - startTime > dayInMillis;
          String homeTitle = isNextWeek ? 'Next 7 Days' : 'Today';
          _titleBloc.updateTitle(homeTitle);
          if (isNextWeek) {
            _taskBloc.filterTasksForNextWeek();
          } else {
            _taskBloc.filterTodayTasks();
          }
        },
      ),
      /*drawer: BlocProvider<TasksBloc>(
        bloc: _taskBloc,
        child: SideDrawer(),
      ),*/
      body: BlocProvider(
        bloc: _taskBloc,
        child: TasksPage(),
      ),
    );
  }

// This menu button widget updates a _selection field (of type WhyFarther,
// not shown here).
  Widget buildPopupMenu(BuildContext context) {
    return new PopupMenuButton<MenuItem>(
      onSelected: (MenuItem result) async {
        switch (result) {
          case MenuItem.taskCompleted:
            await Navigator.push(
              context,
              new MaterialPageRoute<bool>(
                  builder: (context) => new TaskCompletedScreen()),
            );
            _taskBloc.refresh();
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
