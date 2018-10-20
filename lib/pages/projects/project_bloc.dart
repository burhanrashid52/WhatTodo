import 'dart:async';

import 'package:flutter_app/bloc/bloc_provider.dart';
import 'package:flutter_app/db/project_db.dart';
import 'package:flutter_app/models/project.dart';

class ProjectBloc implements BlocBase {
  StreamController<List<Project>> _projectController =
      StreamController<List<Project>>.broadcast();

  Stream<List<Project>> get projects => _projectController.stream;

  ProjectDB _projectDB;
  bool isInboxVisible;

  ProjectBloc(this._projectDB, {this.isInboxVisible = false}) {
    _loadProjects(isInboxVisible);
  }

  @override
  void dispose() {
    _projectController.close();
  }

  void _loadProjects(bool isInboxVisible) {
    _projectDB.getProjects(isInboxVisible: isInboxVisible).then((projects) {
      _projectController.sink.add(projects);
    });
  }

  void createProject(Project project) {
    _projectDB.insertOrReplace(project).then((value) {
      if (value == null) return;
      _loadProjects(isInboxVisible);
    });
  }
}
