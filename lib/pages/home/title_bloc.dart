import 'dart:async';

import 'package:flutter_app/bloc/bloc_provider.dart';

class TitleBloc implements BlocBase {
  StreamController<String> _titleController =
      StreamController<String>.broadcast();

  Stream<String> get title => _titleController.stream;

  @override
  void dispose() {
    _titleController.close();
  }

  void updateTitle(String title) {
    _titleController.sink.add(title);
  }
}
