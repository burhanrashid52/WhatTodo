import 'package:flutter_app/pages/projects/project.dart';
import 'package:sqflite/sqflite.dart';
import 'package:vyuh_core/runtime/platform/vyuh_platform.dart';

ProjectDB get projectDbStore => vyuh.di.get<ProjectDB>();

class ProjectDB {
  ProjectDB(this._dbStore);

  final Database _dbStore;

  Future<List<Project>> getProjects({bool isInboxVisible = true}) async {
    var db = _dbStore;
    var whereClause = isInboxVisible ? ";" : " WHERE ${Project.dbId}!=1;";
    var result =
        await db.rawQuery('SELECT * FROM ${Project.tblProject} $whereClause');
    List<Project> projects = [];
    for (Map<String, dynamic> item in result) {
      var myProject = Project.fromMap(item);
      projects.add(myProject);
    }
    return projects;
  }

  Future insertOrReplace(Project project) async {
    var db = _dbStore;
    await db.transaction((Transaction txn) async {
      await txn.rawInsert('INSERT OR REPLACE INTO '
          '${Project.tblProject}(${Project.dbId},${Project.dbName},${Project.dbColorCode},${Project.dbColorName})'
          ' VALUES(${project.id},"${project.name}", ${project.colorValue}, "${project.colorName}")');
    });
  }

  Future deleteProject(int projectID) async {
    var db = _dbStore;
    await db.transaction((Transaction txn) async {
      await txn.rawDelete(
          'DELETE FROM ${Project.tblProject} WHERE ${Project.dbId}==$projectID;');
    });
  }
}
