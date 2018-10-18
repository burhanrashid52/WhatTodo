import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/application_bloc.dart';
import 'package:flutter_app/bloc/bloc_provider.dart';
import 'package:flutter_app/db/AppDatabase.dart';
import 'package:flutter_app/models/Tasks.dart';
import 'package:flutter_app/pages/tasks/row_task.dart';
import 'package:flutter_app/utils/app_util.dart';

class TasksPage extends StatefulWidget {
  @override
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  @override
  Widget build(BuildContext context) {
    final TasksBloc _tasksBloc = BlocProvider.of<TasksBloc>(context);
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
                          setState(() {
                            list.removeAt(index);
                          });
                          if (direction == DismissDirection.endToStart) {
                            AppDatabase.get()
                                .updateTaskStatus(taskID, TaskStatus.COMPLETE)
                                .then((value) {
                              /* showSnackbar(
                                  widget.scaffoldHomeState, "Task mark as completed",
                                  materialColor: Colors.green);*/
                            });
                          } else {
                            AppDatabase.get().deleteTask(taskID).then((value) {
                              /*showSnackbar(_scaffoldHomeState, "Task Deleted",
                                  materialColor: Colors.red);*/
                            });
                          }
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
