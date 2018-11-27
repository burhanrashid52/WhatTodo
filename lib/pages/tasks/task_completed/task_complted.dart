import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/bloc_provider.dart';
import 'package:flutter_app/pages/tasks/bloc/task_bloc.dart';
import 'package:flutter_app/pages/tasks/models/tasks.dart';
import 'package:flutter_app/pages/tasks/task_db.dart';
import 'package:flutter_app/pages/tasks/task_completed/row_task_completed.dart';

class TaskCompletedPage extends StatelessWidget {
  final TaskBloc _taskBloc = TaskBloc(TaskDB.get());

  @override
  Widget build(BuildContext context) {
    _taskBloc.filterByStatus(TaskStatus.COMPLETE);
    return BlocProvider(
      bloc: _taskBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Task Completed"),
        ),
        body: StreamBuilder(
            stream: _taskBloc.tasks,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                          key: ObjectKey(snapshot.data[index]),
                          direction: DismissDirection.endToStart,
                          background: Container(),
                          onDismissed: (DismissDirection directions) {
                            if (directions == DismissDirection.endToStart) {
                              var taskID = snapshot.data[index].id;
                              _taskBloc.updateStatus(
                                  taskID, TaskStatus.PENDING);
                              SnackBar snackbar =
                                  SnackBar(content: Text("Task Undo"));
                              Scaffold.of(context).showSnackBar(snackbar);
                            }
                          },
                          secondaryBackground: Container(
                            color: Colors.grey,
                            child: ListTile(
                              trailing: Text("UNDO",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                          child: TaskCompletedRow(snapshot.data[index]));
                    });
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}
