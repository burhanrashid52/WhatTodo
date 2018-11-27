import 'package:flutter_app/models/priority.dart';
import 'package:meta/meta.dart';

class Tasks {
  static final tblTask = "Tasks";
  static final dbId = "id";
  static final dbTitle = "title";
  static final dbComment = "comment";
  static final dbDueDate = "dueDate";
  static final dbPriority = "priority";
  static final dbStatus = "status";
  static final dbProjectID = "projectId";

  String title, comment, projectName;
  int id, dueDate, projectId, projectColor;
  Status priority;
  TaskStatus tasksStatus;
  List<String> labelList = List();

  Tasks.create(
      {@required this.title,
      @required this.projectId,
      this.comment = "",
      this.dueDate = -1,
      this.priority = Status.PRIORITY_4}) {
    if (this.dueDate == -1) {
      this.dueDate = DateTime.now().millisecondsSinceEpoch;
    }
    this.tasksStatus = TaskStatus.PENDING;
  }

  bool operator ==(o) => o is Tasks && o.id == id;

  Tasks.update(
      {@required this.id,
      @required this.title,
      @required this.projectId,
      this.comment = "",
      this.dueDate =-1,
      this.priority = Status.PRIORITY_4,
      this.tasksStatus = TaskStatus.PENDING}) {
    if (this.dueDate == -1) {
      this.dueDate = DateTime.now().millisecondsSinceEpoch;
    }
  }

  Tasks.fromMap(Map<String, dynamic> map)
      : this.update(
          id: map[dbId],
          title: map[dbTitle],
          projectId: map[dbProjectID],
          comment: map[dbComment],
          dueDate: map[dbDueDate],
          priority: Status.values[map[dbPriority]],
          tasksStatus: TaskStatus.values[map[dbStatus]],
        );
}

enum TaskStatus {
  PENDING,
  COMPLETE,
}
