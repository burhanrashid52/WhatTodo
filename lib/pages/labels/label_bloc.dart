import 'dart:async';

import 'package:flutter_app/bloc/bloc_provider.dart';
import 'package:flutter_app/db/label_db.dart';
import 'package:flutter_app/models/label.dart';

class LabelBloc implements BlocBase {
  StreamController<List<Label>> _labelController =
      StreamController<List<Label>>.broadcast();

  Stream<List<Label>> get labels => _labelController.stream;

  StreamController<bool> _labelExistController =
      StreamController<bool>.broadcast();

  Stream<bool> get labelsExist => _labelExistController.stream;

  LabelDB _labelDB;

  LabelBloc(this._labelDB) {
    _loadLabels();
  }

  @override
  void dispose() {
    _labelController.close();
    _labelExistController.close();
  }

  void _loadLabels() {
    _labelDB.getLabels().then((labels) {
      _labelController.sink.add(List.unmodifiable(labels));
    });
  }

  void refresh() {
    _loadLabels();
  }

  void checkIfLabelExist(Label label) async {
    _labelDB.isLabelExits(label).then((isExist) {
      _labelExistController.sink.add(isExist);
    });
  }
}
