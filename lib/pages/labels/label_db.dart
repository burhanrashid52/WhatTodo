import 'package:flutter_app/pages/labels/label.dart';
import 'package:sqflite/sqflite.dart';
import 'package:vyuh_core/runtime/platform/vyuh_platform.dart';

LabelDB get labelDbStore => vyuh.di.get<LabelDB>();

class LabelDB {
  LabelDB(this._dbStore);

  final Database _dbStore;

  Future<bool> isLabelExits(Label label) async {
    var db = _dbStore;
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
    var db = _dbStore;
    await db.transaction((Transaction txn) async {
      await txn.rawInsert('INSERT OR REPLACE INTO '
          '${Label.tblLabel}(${Label.dbName},${Label.dbColorCode},${Label.dbColorName})'
          ' VALUES("${label.name}", ${label.colorValue}, "${label.colorName}")');
    });
  }

  Future<List<Label>> getLabels() async {
    var db = _dbStore;
    var result = await db.rawQuery('SELECT * FROM ${Label.tblLabel}');
    List<Label> labels = [];
    for (Map<String, dynamic> item in result) {
      var myLabels = Label.fromMap(item);
      labels.add(myLabels);
    }
    return labels;
  }

  Future deleteLabel(int labelId) async {
    var db = _dbStore;
    await db.transaction((Transaction txn) async {
      await txn.rawDelete(
          'DELETE FROM ${Label.tblLabel} WHERE ${Label.dbId}==$labelId;');
    });
  }
}
