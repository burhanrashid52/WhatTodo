import 'dart:async';

import 'package:flutter_app/bloc/bloc_provider.dart';
import 'package:flutter_app/pages/tasks/bloc/task_bloc.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc implements BlocBase {
  StreamController<String> _titleController = BehaviorSubject<String>();

  Stream<String> get title => _titleController.stream;

  StreamController<Filter> _filterController = BehaviorSubject<Filter>();

  Stream<Filter> get filter => _filterController.stream;

  StreamController<SCREEN?> _screenController =
      StreamController<SCREEN?>.broadcast();

  Stream<SCREEN?> get screens => _screenController.stream;

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
    updateScreen(title, SCREEN.HOME);
  }

  void updateScreen(String title, SCREEN screenType) {
    _screenController.sink.add(screenType);
    updateTitle(title);
  }
}

enum SCREEN { ABOUT, ADD_TASK, HOME }
