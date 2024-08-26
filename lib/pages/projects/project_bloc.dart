import 'dart:async';

import 'package:flutter_app/bloc/bloc_provider.dart';
import 'package:flutter_app/pages/projects/project_db.dart';
import 'package:flutter_app/pages/projects/project.dart';
import 'package:flutter_app/utils/color_utils.dart';

class ProjectBloc implements BlocBase {
  StreamController<List<Project>> _projectController =
      StreamController<List<Project>>.broadcast();

  Stream<List<Project>> get projects => _projectController.stream;

  StreamController<bool> _projectExistController =
      StreamController<bool>.broadcast();

  Stream<bool> get projectExist => _projectExistController.stream;

  StreamController<ColorPalette> _colorController =
      StreamController<ColorPalette>.broadcast();

  Stream<ColorPalette> get colorSelection => _colorController.stream;

  ProjectDB _projectDB;
  bool isInboxVisible;

  ProjectBloc(this._projectDB, {this.isInboxVisible = false}) {
    _loadProjects(isInboxVisible);
  }

  @override
  void dispose() {
    _projectExistController.close();
    _projectController.close();
    _colorController.close();
  }

  void _loadProjects(bool isInboxVisible) {
    _projectDB.getProjects(isInboxVisible: isInboxVisible).then((projects) {
      if (!_projectController.isClosed) {
        _projectController.sink.add(projects);
      }
    });
  }

  void createOrExists(Project project) async {
    _projectDB.projectExists(project).then((exist) {
      _projectExistController.sink.add(exist);
      if (!exist) {
        _projectDB.insertOrReplace(project);
      }
    });
  }

  void createProject(Project project) {
    _projectDB.insertOrReplace(project).then((value) {
      if (value == null) return;
      _loadProjects(isInboxVisible);
    });
  }

  void deleteProject(int projectId) {
    _projectDB.deleteProject(projectId).then((value) {
      _loadProjects(isInboxVisible);
    });
  }

  void updateColorSelection(ColorPalette colorPalette) {
    _colorController.sink.add(colorPalette);
  }

  void refresh() {
    _loadProjects(isInboxVisible);
  }
}
