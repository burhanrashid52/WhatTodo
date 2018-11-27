import 'package:flutter_app/db/app_db.dart';
import 'package:flutter_app/pages/labels/label.dart';
import 'package:sqflite/sqflite.dart';

class LabelDB {
  static final LabelDB _labelDb = LabelDB._internal(AppDatabase.get());

  AppDatabase _appDatabase;

  //private internal constructor to make it singleton
  LabelDB._internal(this._appDatabase);

  static LabelDB get() {
    return _labelDb;
  }

  Future<bool> isLabelExits(Label label) async {
    var db = await _appDatabase.getDb();
    var result = await db.rawQuery(
        "SELECT * FROM ${Label.tblLabel} WHERE ${Label.dbName} LIKE '${label.name}'");
    if (result.length == 0) {
      return await updateLabels(label).then((value) {
        return false;
      });
    } else {
      return true;
    }
  }

  Future updateLabels(Label label) async {
    var db = await _appDatabase.getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawInsert('INSERT OR REPLACE INTO '
          '${Label.tblLabel}(${Label.dbName},${Label.dbColorCode},${Label.dbColorName})'
          ' VALUES("${label.name}", ${label.colorValue}, "${label.colorName}")');
    });
  }

  Future<List<Label>> getLabels() async {
    var db = await _appDatabase.getDb();
    var result = await db.rawQuery('SELECT * FROM ${Label.tblLabel}');
    List<Label> projects = List();
    for (Map<String, dynamic> item in result) {
      var myProject = Label.fromMap(item);
      projects.add(myProject);
    }
    return projects;
  }
}
