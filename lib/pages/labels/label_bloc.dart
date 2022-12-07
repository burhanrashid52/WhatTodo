import 'dart:async';

import 'package:flutter_app/bloc/bloc_provider.dart';
import 'package:flutter_app/pages/labels/label.dart';
import 'package:flutter_app/pages/labels/label_db.dart';
import 'package:flutter_app/utils/color_utils.dart';
import 'package:rxdart/rxdart.dart';

class LabelBloc implements BlocBase {
  StreamController<List<Label>> _labelController =
      BehaviorSubject<List<Label>>();

  Stream<List<Label>> get labels => _labelController.stream;

  StreamController<bool> _labelExistController =
      StreamController<bool>.broadcast();

  Stream<bool> get labelExist => _labelExistController.stream;

  StreamController<ColorPalette> _colorController =
      StreamController<ColorPalette>.broadcast();

  Stream<ColorPalette> get colorSelection => _colorController.stream;

  LabelDB _labelDB;

  LabelBloc(this._labelDB) {
    _loadLabels();
  }

  @override
  void dispose() {
    _labelController.close();
    _labelExistController.close();
    _colorController.close();
  }

  void _loadLabels() {
    _labelDB.getLabels().then((labels) {
      if (!_labelController.isClosed) {
        _labelController.sink.add(List.unmodifiable(labels));
      }
    });
  }

  void refresh() {
    _loadLabels();
  }

  Future createOrExists(Label label) async {
    _labelDB.isLabelExists(label).then((exist) {
      _labelExistController.sink.add(exist);
      if (!exist) {
        _labelDB.updateLabels(label);
        _loadLabels();
      }
    });
  }

  void updateColorSelection(ColorPalette colorPalette) {
    _colorController.sink.add(colorPalette);
  }
}
