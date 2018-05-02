import 'package:meta/meta.dart';
import 'Priority.dart';

class Tasks {
  static final tblTask = "Tasks";
  static final dbId = "id";
  static final dbTitle = "title";
  static final dbComment = "comment";
  static final dbDueDate = "dueDate";
  static final dbPriority = "priority";
  static final dbProjectID = "projectId";

  String title, comment, projectName;
  int id, dueDate, projectId, projectColor;
  Status priority;
  List<String> labelList = new List();

  Tasks.create(
      {@required this.title,
      @required this.projectId,
      this.comment = "",
      this.dueDate = -1,
      this.priority = Status.PRIORITY_4}) {
    if (this.dueDate == -1) {
      this.dueDate = new DateTime.now().millisecondsSinceEpoch;
    }
  }

  Tasks.update(
      {@required this.id,
      @required this.title,
      @required this.projectId,
      this.comment = "",
      this.dueDate = -1,
      this.priority = Status.PRIORITY_4}) {
    if (this.dueDate == -1) {
      this.dueDate = new DateTime.now().millisecondsSinceEpoch;
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
        );
}
