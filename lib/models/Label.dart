import 'package:meta/meta.dart';

class Label {
  static final tblLabel = "labels";
  static final dbId = "id";
  static final dbName = "name";
  static final dbColorCode = "colorCode";
  static final dbColorName = "colorName";

  int id, colorValue;
  String name, colorName;

  Label.create(this.name, this.colorValue, this.colorName);

  Label.update({@required this.id, name = "", colorCode = "", colorName = ""}) {
    if (name != "") {
      this.name = name;
    }
    if (colorCode != "") {
      this.colorValue = colorCode;
    }
    if (colorName != "") {
      this.colorName = colorName;
    }
  }

  bool operator ==(o) => o is Label && o.id == id;

  Label.fromMap(Map<String, dynamic> map)
      : this.update(
            id: map[dbId],
            name: map[dbName],
            colorCode: map[dbColorCode],
            colorName: map[dbColorName]);
}
