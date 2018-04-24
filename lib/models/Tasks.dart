import 'package:meta/meta.dart';

class Tasks {
  static final tblTask = "Tasks";
  static final dbId = "id";
  static final dbTitle = "title";
  static final dbDescription = "description";
  static final dbScheduleDate = "scheduleDate";

  String title, description;
  int id, scheduleDate;

  Tasks(
      {@required this.id,
      @required this.title,
      this.description = "",
      this.scheduleDate = -1}) {
    if (this.scheduleDate == -1) {
      this.scheduleDate = new DateTime.now().millisecondsSinceEpoch;
    }
  }

  Tasks.fromMap(Map<String, dynamic> map)
      : this(
          id: map[dbId],
          title: map[dbTitle],
          description: map[dbDescription],
          scheduleDate: map[dbScheduleDate],
        );
}
