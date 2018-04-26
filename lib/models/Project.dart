import 'package:meta/meta.dart';

class Project {
  static final tblProject = "projects";
  static final dbId = "id";
  static final dbName = "name";
  static final dbColorCode = "colorCode";
  static final dbColorName = "colorName";

  int id;
  String name, colorCode, colorName;

  Project.create(this.name, this.colorCode, this.colorName);

  Project.update(
      {@required this.id, name = "", colorCode = "", colorName = ""}) {
    if (name != "") {
      this.name = name;
    }
    if (colorCode != "") {
      this.colorCode = colorCode;
    }
    if (colorName != "") {
      this.colorCode = colorCode;
    }
  }

  Project.fromMap(Map<String, dynamic> map) {
    Project.update(
        id: map[dbId],
        name: map[dbName],
        colorCode: map[dbColorCode],
        colorName: map[dbColorName]);
  }
}
