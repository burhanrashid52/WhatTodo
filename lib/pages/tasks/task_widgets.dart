import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/task_bloc.dart';
import 'package:flutter_app/bloc/bloc_provider.dart';
import 'package:flutter_app/pages/tasks/models/tasks.dart';
import 'package:flutter_app/pages/tasks/row_task.dart';
import 'package:flutter_app/utils/app_util.dart';

class TasksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TaskBloc _tasksBloc = BlocProvider.of(context);
    return StreamBuilder<List<Tasks>>(
      stream: _tasksBloc.tasks,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _buildTaskList(snapshot.data);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _buildTaskList(List<Tasks> list) {
    return new Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: list.length == 0
          ? MessageInCenterWidget("No Task Added")
          : new Container(
              child: new ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return new Dismissible(
                        key: new ObjectKey(list[index]),
                        onDismissed: (DismissDirection direction) {
                          var taskID = list[index].id;
                          final TaskBloc _tasksBloc =
                              BlocProvider.of<TaskBloc>(context);
                          String message = "";
                          if (direction == DismissDirection.endToStart) {
                            _tasksBloc.updateStatus(
                                taskID, TaskStatus.COMPLETE);
                            message = "Task completed";
                          } else {
                            _tasksBloc.delete(taskID);
                            message = "Task deleted";
                          }
                          SnackBar snackbar =
                              SnackBar(content: new Text(message));
                          Scaffold.of(context).showSnackBar(snackbar);
                        },
                        background: new Container(
                          color: Colors.red,
                          child: new ListTile(
                            leading:
                                new Icon(Icons.delete, color: Colors.white),
                          ),
                        ),
                        secondaryBackground: new Container(
                          color: Colors.green,
                          child: new ListTile(
                            trailing:
                                new Icon(Icons.check, color: Colors.white),
                          ),
                        ),
                        child: new TaskRow(list[index]));
                  }),
            ),
    );
  }
}
