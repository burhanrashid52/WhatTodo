class TaskLabels {
  static final tblTaskLabel = "taskLabel";
  static final dbId = "id";
  static final dbTaskId = "taskId";
  static final dbLabelId = "labelId";

  int id, taskId, labelId;

  TaskLabels.create(this.taskId, this.labelId);

  TaskLabels.update({this.id, this.taskId, this.labelId});

  TaskLabels.fromMap(Map<String, dynamic> map)
      : this.update(
            id: map[dbId], taskId: map[dbTaskId], labelId: map[dbLabelId]);
}
