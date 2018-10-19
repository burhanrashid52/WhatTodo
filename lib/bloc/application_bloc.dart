import 'dart:async';
import 'dart:collection';

import 'package:flutter_app/bloc/bloc_provider.dart';
import 'package:flutter_app/db/AppDatabase.dart';
import 'package:flutter_app/models/Tasks.dart';

class TasksBloc implements BlocBase {
  ///
  /// Synchronous Stream to handle the provision of the movie genres
  ///
  StreamController<List<Tasks>> _taskController =
      StreamController<List<Tasks>>.broadcast();

  Stream<List<Tasks>> get tasks => _taskController.stream;

  ///
  StreamController<int> _cmdController = StreamController<int>.broadcast();

  //StreamSink get getMovieGenres => _cmdController.sink;

  AppDatabase _appDatabase;
  List<Tasks> _tasksList;

  TasksBloc(this._appDatabase) {
    filterTodayTasks();
    _cmdController.stream.listen((_) {
      _updateTaskStream(_tasksList);
    });
  }

  void _filterTask(int taskStartTime, int taskEndTime, TaskStatus status) {
    _appDatabase
        .getTasks(
            startDate: taskStartTime, endDate: taskEndTime, taskStatus: status)
        .then((tasks) {
      _updateTaskStream(tasks);
    });
  }

  void _updateTaskStream(List<Tasks> tasks) {
    _tasksList = tasks;
    _taskController.sink.add(UnmodifiableListView<Tasks>(_tasksList));
  }

  void dispose() {
    _taskController.close();
    _cmdController.close();
  }

  void filterTodayTasks() {
    final dateTime = new DateTime.now();
    final int taskStartTime =
        new DateTime(dateTime.year, dateTime.month, dateTime.day)
            .millisecondsSinceEpoch;
    final int taskEndTime =
        new DateTime(dateTime.year, dateTime.month, dateTime.day, 23, 59)
            .millisecondsSinceEpoch;

    // Read all today's tasks from database
    _filterTask(taskStartTime, taskEndTime, TaskStatus.PENDING);
  }

  void filterTasksForNextWeek() {
    var dateTime = new DateTime.now();
    var taskStartTime =
        new DateTime(dateTime.year, dateTime.month, dateTime.day)
            .millisecondsSinceEpoch;
    var taskEndTime =
        new DateTime(dateTime.year, dateTime.month, dateTime.day + 7, 23, 59)
            .millisecondsSinceEpoch;
    // Read all next week tasks from database
    _filterTask(taskStartTime, taskEndTime, TaskStatus.PENDING);
  }

  void filterByProject(int projectId) {
    _appDatabase.getTasksByProject(projectId).then((tasks) {
      if (tasks == null) return;
      _updateTaskStream(tasks);
    });
  }

  void filterByLabel(String labelName) {
    _appDatabase.getTasksByLabel(labelName).then((tasks) {
      if (tasks == null) return;
      _updateTaskStream(tasks);
    });
  }

  void updateStatus(int taskID, TaskStatus complete) {
    _appDatabase.updateTaskStatus(taskID, TaskStatus.COMPLETE).then((value) {
      filterTodayTasks();
      filterTasksForNextWeek();
      /* showSnackbar(
                                  widget.scaffoldHomeState, "Task mark as completed",
                                  materialColor: Colors.green);*/
    });
  }

  void delete(int taskID) {
    _appDatabase.deleteTask(taskID).then((value) {
      filterTodayTasks();
      filterTasksForNextWeek();
      /*showSnackbar(_scaffoldHomeState, "Task Deleted",
                                  materialColor: Colors.red);*/
    });
  }
}
