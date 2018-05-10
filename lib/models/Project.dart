import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class Project {
  static final tblProject = "projects";
  static final dbId = "id";
  static final dbName = "name";
  static final dbColorCode = "colorCode";
  static final dbColorName = "colorName";

  int id, colorValue;
  String name, colorName;

  Project.create(this.name, this.colorValue, this.colorName);

  Project.update({@required this.id, name, colorCode = "", colorName = ""}) {
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

  Project.getInbox()
      : this.update(
            id: 1,
            name: "Inbox",
            colorName: "Grey",
            colorCode: Colors.grey.value);

  Project.fromMap(Map<String, dynamic> map)
      : this.update(
            id: map[dbId],
            name: map[dbName],
            colorCode: map[dbColorCode],
            colorName: map[dbColorName]);
}
