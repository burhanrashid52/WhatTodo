import 'dart:async';
import 'dart:collection';

import 'package:flutter_app/bloc/bloc_provider.dart';
import 'package:flutter_app/db/AppDatabase.dart';
import 'package:flutter_app/models/Tasks.dart';

class TasksBloc implements BlocBase {
  ///
  /// Synchronous Stream to handle the provision of the movie genres
  ///
  StreamController<List<Tasks>> _syncController =
      StreamController<List<Tasks>>.broadcast();

  Stream<List<Tasks>> get tasks => _syncController.stream;

  ///
  StreamController<List<Tasks>> _cmdController =
      StreamController<List<Tasks>>.broadcast();

  StreamSink get getMovieGenres => _cmdController.sink;

  AppDatabase _appDatabase;

  TasksBloc(this._appDatabase) {
    // Read all tasks from database
    _appDatabase.getTasks().then((tasks) {
      _tasksList = tasks;
      _syncController.sink.add(UnmodifiableListView<Tasks>(_tasksList));
    });

    _cmdController.stream.listen((_) {
      _syncController.sink.add(UnmodifiableListView<Tasks>(_tasksList));
    });
  }

  void dispose() {
    _syncController.close();
    _cmdController.close();
  }

  void filterTodayTasks(){
    final dateTime = new DateTime.now();
    final int taskStartTime = new DateTime(dateTime.year, dateTime.month, dateTime.day).millisecondsSinceEpoch;
    final int taskEndTime =
        new DateTime(dateTime.year, dateTime.month, dateTime.day, 23, 59)
            .millisecondsSinceEpoch;

    _appDatabase.getTasks(startDate: taskStartTime,endDate: taskEndTime).then((tasks){
      _tasksList=tasks;
      _syncController.sink.add(UnmodifiableListView<Tasks>(_tasksList));
    });
  }

  void filterTasksForNextWeek(){
    final dateTime = new DateTime.now();

    /*_appDatabase.getTasks(startDate: taskStartTime,endDate: taskEndTime).then((tasks){
      _tasksList=tasks;
      _syncController.sink.add(UnmodifiableListView<Tasks>(_tasksList));
    });*/
  }

  List<Tasks> _tasksList;
}
