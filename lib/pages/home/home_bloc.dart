import 'dart:async';

import 'package:flutter_app/bloc/bloc_provider.dart';
import 'package:flutter_app/pages/tasks/bloc/task_bloc.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc implements BlocBase {
  StreamController<String> _titleController = BehaviorSubject<String>();

  Stream<String> get title => _titleController.stream;

  StreamController<Filter> _filterController = BehaviorSubject<Filter>();

  Stream<Filter> get filter => _filterController.stream;

  StreamController<SCREEN> _screenController = BehaviorSubject<SCREEN>();

  Stream<SCREEN> get screens => _screenController.stream;

  @override
  void dispose() {
    _titleController.close();
    _filterController.close();
    _screenController.close();
  }

  void updateTitle(String title) {
    _titleController.sink.add(title);
  }

  void applyFilter(String title, Filter filter) {
    _filterController.sink.add(filter);
    updateTitle(title);
    updateScreen(SCREEN.HOME);
  }

  void updateScreen(SCREEN screenType) {
    _screenController.sink.add(screenType);
  }
}

enum SCREEN { ABOUT, ADD_TASK, HOME, COMPLETED_TASK, ADD_LABEL, ADD_PROJECT }
