import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/bloc_provider.dart';
import 'package:flutter_app/pages/home/home_bloc.dart';
import 'package:flutter_app/pages/home/side_drawer.dart';
import 'package:flutter_app/pages/tasks/add_task.dart';
import 'package:flutter_app/pages/tasks/bloc/task_bloc.dart';
import 'package:flutter_app/pages/tasks/task_completed/task_complted.dart';
import 'package:flutter_app/pages/tasks/task_db.dart';
import 'package:flutter_app/pages/tasks/task_widgets.dart';
import 'package:flutter_app/utils/keys.dart';
import 'package:flutter_app/utils/extension.dart';

class HomePage extends StatelessWidget {
  final TaskBloc _taskBloc = TaskBloc(TaskDB.get());
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final bool isWiderScreen = context.isWiderScreen();
    final homeBloc = context.bloc<HomeBloc>();
    scheduleMicrotask(() {
      StreamSubscription? _filterSubscription;
      _filterSubscription = homeBloc.filter.listen((filter) {
        _taskBloc.updateFilters(filter);
        //_filterSubscription?.cancel();
      });
    });
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: StreamBuilder<String>(
            initialData: 'Today',
            stream: homeBloc.title,
            builder: (context, snapshot) {
              return Text(
                snapshot.data!,
                key: ValueKey(HomePageKeys.HOME_TITLE),
              );
            }),
        actions: <Widget>[buildPopupMenu(context)],
        leading: isWiderScreen
            ? null
            : new IconButton(
                icon: new Icon(
                  Icons.menu,
                  key: ValueKey(SideDrawerKeys.DRAWER),
                ),
                onPressed: () => _scaffoldKey.currentState?.openDrawer(),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        key: ValueKey(HomePageKeys.ADD_NEW_TASK_BUTTON),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.orange,
        onPressed: () async {
          await context.adaptiveNavigate(SCREEN.ADD_TASK, AddTaskProvider());
          _taskBloc.refresh();
        },
      ),
      drawer: isWiderScreen ? null : SideDrawer(),
      onDrawerChanged: (isOpened) {
        if (!isOpened) {
          _taskBloc.refresh();
        }
      },
      body: BlocProvider(
        bloc: _taskBloc,
        child: TasksPage(),
      ),
    );
  }

// This menu button widget updates a _selection field (of type WhyFarther,
// not shown here).
  Widget buildPopupMenu(BuildContext context) {
    return PopupMenuButton<MenuItem>(
      icon: Icon(Icons.adaptive.more),
      key: ValueKey(CompletedTaskPageKeys.POPUP_ACTION),
      onSelected: (MenuItem result) async {
        switch (result) {
          case MenuItem.TASK_COMPLETED:
            await context.adaptiveNavigate(
                SCREEN.COMPLETED_TASK, TaskCompletedPage());
            _taskBloc.refresh();
            break;
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<MenuItem>>[
        const PopupMenuItem<MenuItem>(
          value: MenuItem.TASK_COMPLETED,
          child: const Text(
            'Completed Tasks',
            key: ValueKey(CompletedTaskPageKeys.COMPLETED_TASKS),
          ),
        )
      ],
    );
  }
}

// This is the type used by the popup menu below.
enum MenuItem { TASK_COMPLETED }
