import 'package:flutter/material.dart';

class TaskLocation {
  TaskLocation.create({
    @required this.id,
    @required this.location_name,
    @required this.taskId,
    @required this.address,
    @required this.lat,
    @required this.lng,
  });

  TaskLocation.update({
    @required this.id,
    @required this.location_name,
    @required this.taskId,
    @required this.address,
    @required this.lat,
    @required this.lng,
  });

  TaskLocation.fromMap(Map<String, dynamic> map)
      : this.update(
          id: map[dbId],
          location_name: map[dbLocationName],
          taskId: map[dbTaskID],
          address: map[dbAddress],
          lat: map[dbLat],
          lng: map[dbLng],
        );

  static final tblTaskLocation = "TaskLocation";
  static final dbId = "id";
  static final dbLocationName = "location_name";
  static final dbLat = "lat";
  static final dbLng = "lng";
  static final dbAddress = "address";
  static final dbTaskID = "taskId";

  String location_name, address;
  int id, lng, taskId, lat;

  @override
  bool operator ==(o) => o is TaskLocation && o.id == id;
}

final CREATE_LOCATION_TABLE_QUERY =
    "CREATE TABLE ${TaskLocation.tblTaskLocation} ("
    "${TaskLocation.dbId} INTEGER PRIMARY KEY AUTOINCREMENT,"
    "${TaskLocation.dbLocationName} TEXT,"
    "${TaskLocation.dbAddress} TEXT,"
    "${TaskLocation.dbLat} DOUBLE,"
    "${TaskLocation.dbLng} DOUBLE);";

final DROP_LOCATION_TABLE_QUERY = "DROP TABLE ${TaskLocation.tblTaskLocation}";
