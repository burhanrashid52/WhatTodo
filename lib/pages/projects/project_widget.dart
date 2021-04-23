import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/bloc_provider.dart';
import 'package:flutter_app/pages/home/home_bloc.dart';
import 'package:flutter_app/pages/projects/add_project.dart';
import 'package:flutter_app/pages/projects/project.dart';
import 'package:flutter_app/pages/projects/project_bloc.dart';
import 'package:flutter_app/pages/projects/project_db.dart';
import 'package:flutter_app/pages/tasks/bloc/task_bloc.dart';
import 'package:flutter_app/utils/keys.dart';

class ProjectPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ProjectBloc projectBloc = BlocProvider.of<ProjectBloc>(context);
    return StreamBuilder<List<Project>>(
      stream: projectBloc.projects,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ProjectExpansionTileWidget(snapshot.data!);
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}

class ProjectExpansionTileWidget extends StatelessWidget {
  final List<Project> _projects;

  ProjectExpansionTileWidget(this._projects);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      key: ValueKey(SideDrawerKeys.DRAWER_PROJECTS),
      leading: Icon(Icons.book),
      title: Text("Projects",
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),
      children: buildProjects(context),
    );
  }

  List<Widget> buildProjects(BuildContext context) {
    List<Widget> projectWidgetList = [];
    _projects.forEach((project) => projectWidgetList.add(ProjectRow(project)));
    projectWidgetList.add(ListTile(
      key: ValueKey(SideDrawerKeys.ADD_PROJECT),
      leading: Icon(Icons.add),
      title: Text("Add Project"),
      onTap: () async {
        Navigator.pop(context);
        ProjectBloc projectBloc = BlocProvider.of<ProjectBloc>(context);
        Widget addProject = BlocProvider(
          bloc: ProjectBloc(ProjectDB.get()),
          child: AddProject(),
        );
        await Navigator.push(
            context,
            MaterialPageRoute<bool>(
              builder: (context) => addProject,
            ));
        projectBloc.refresh();
      },
    ));
    return projectWidgetList;
  }
}

class ProjectRow extends StatefulWidget {
  final Project project;

  ProjectRow(this.project);

  @override
  _ProjectRowState createState() => _ProjectRowState();
}

class _ProjectRowState extends State<ProjectRow> {
  var projectDb = ProjectDB.get();

  @override
  Widget build(BuildContext context) {
    HomeBloc homeBloc = BlocProvider.of(context);
    return ListTile(
      key: ValueKey("tile_${widget.project.name}_${widget.project.id}"),
      onTap: () {
        homeBloc.applyFilter(
            widget.project.name, Filter.byProject(widget.project.id!));
        Navigator.pop(context);
      },
      leading: Container(
        child: Icon(
          Icons.library_books_rounded,
          color: Color(widget.project.colorValue),
        ),
        key: ValueKey("space_${widget.project.name}_${widget.project.id}"),
        width: 24.0,
        height: 24.0,
      ),
      title: Text(
        widget.project.name,
        key: ValueKey("${widget.project.name}_${widget.project.id}"),
      ),
      trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            return _showMyDialog1(widget.project.id);
          }),
    );
  }

  _showMyDialog1(int? id) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Text(
              'Alert',
              style: TextStyle(color: Colors.red),
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure want to delete this project? '),
                Text(
                    'This will also delete the project associated with this project'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                projectDb.deleteProject(id);
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
