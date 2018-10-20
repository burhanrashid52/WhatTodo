import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/bloc_provider.dart';
import 'package:flutter_app/models/project.dart';
import 'package:flutter_app/pages/home/side_drawer.dart';
import 'package:flutter_app/pages/projects/add_project.dart';
import 'package:flutter_app/pages/projects/project_bloc.dart';

class ProjectPage extends StatelessWidget {
  final ProjectSelection projectSelection;

  ProjectPage(this.projectSelection);

  @override
  Widget build(BuildContext context) {
    ProjectBloc _projectBloc = BlocProvider.of<ProjectBloc>(context);
    return LayoutBuilder(
      builder: (buildContext, _) => StreamBuilder<List<Project>>(
            stream: _projectBloc.projects,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return buildExpansionTile(buildContext, snapshot.data);
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
    );
  }

  ExpansionTile buildExpansionTile(
      BuildContext context, List<Project> projects) {
    return new ExpansionTile(
      leading: new Icon(Icons.book),
      title: new Text("Projects",
          style: new TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),
      children: buildProjects(context, projects),
    );
  }

  List<Widget> buildProjects(BuildContext context, List<Project> projectList) {
    List<Widget> projectWidgetList = new List();
    projectList.forEach((project) => projectWidgetList.add(new ProjectRow(
          project,
          projectSelection: (selectedProject) {
            projectSelection(selectedProject);
            Navigator.pop(context);
          },
        )));
    projectWidgetList.add(new ListTile(
      leading: new Icon(Icons.add),
      title: new Text("Add Project"),
      onTap: () {
        Navigator.pop(context);
        ProjectBloc _projectBloc = BlocProvider.of<ProjectBloc>(context);
        Widget addProject = BlocProvider(
          bloc: _projectBloc,
          child: AddProject(),
        );
        Navigator.push(
            context,
            new MaterialPageRoute<bool>(
              builder: (context) => addProject,
            ));
      },
    ));
    return projectWidgetList;
  }
}
