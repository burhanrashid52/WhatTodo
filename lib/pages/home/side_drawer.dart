import 'package:flutter/material.dart';
import 'package:flutter_app/db/AppDatabase.dart';
import 'package:flutter_app/models/Label.dart';
import 'package:flutter_app/models/Project.dart';
import 'package:flutter_app/pages/labels/add_label.dart';
import 'package:flutter_app/pages/projects/add_project.dart';

class SideDrawer extends StatefulWidget {
  @override
  _SideDrawerState createState() => new _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  final List<Project> projectList = new List();
  final List<Label> labelList = new List();

  @override
  void initState() {
    super.initState();
    updateProjects();
    updateLabels();
  }

  void updateProjects() {
    AppDatabase.get().getProjects().then((projects) {
      if (projects != null) {
        setState(() {
          projectList.clear();
          projectList.addAll(projects);
        });
      }
    });
  }

  void updateLabels() {
    AppDatabase.get().getLabels().then((projects) {
      if (projects != null) {
        setState(() {
          labelList.clear();
          labelList.addAll(projects);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            accountName: new Text("Burhanuddin Rashid"),
            accountEmail: new Text("burhanrashid52@gmail.com"),
            currentAccountPicture: new CircleAvatar(
              backgroundColor: Theme.of(context).accentColor,
              child: new Text("B", style: new TextStyle(color: Colors.white)),
            ),
          ),
          new ListTile(
            leading: new Icon(Icons.inbox),
            title: new Text("Inbox"),
          ),
          new ListTile(
            leading: new Icon(Icons.calendar_today),
            title: new Text("Today"),
          ),
          buildExpansionTile(Icons.book, "Projects"),
          buildExpansionTile(Icons.label, "Labels")
        ],
      ),
    );
  }

  ExpansionTile buildExpansionTile(IconData icon, String projectName) {
    return new ExpansionTile(
      leading: new Icon(icon),
      title: new Text(projectName,
          style: new TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),
      children: projectName == "Projects" ? buildProjects() : buildLabels(),
    );
  }

  List<Widget> buildProjects() {
    List<Widget> projectWidgetList = new List();
    projectList
        .forEach((project) => projectWidgetList.add(new ProjectRow(project)));
    projectWidgetList.add(new ListTile(
      leading: new Icon(Icons.add),
      title: new Text("Add Project"),
      onTap: () async {
        Navigator.pop(context);
        bool isDataChanged = await Navigator.push(
            context,
            new MaterialPageRoute<bool>(
                builder: (context) => new AddProject()));

        if (isDataChanged) {
          updateProjects();
        }
      },
    ));
    return projectWidgetList;
  }

  List<Widget> buildLabels() {
    List<Widget> projectWidgetList = new List();
    labelList.forEach((label) => projectWidgetList.add(new LabelRow(label)));
    projectWidgetList.add(new ListTile(
        leading: new Icon(Icons.add),
        title: new Text("Add Label"),
        onTap: () async {
          Navigator.pop(context);
          bool isDataChanged = await Navigator.push(
              context,
              new MaterialPageRoute<bool>(
                  builder: (context) => new AddLabel()));

          if (isDataChanged) {
            updateLabels();
          }
        }));
    return projectWidgetList;
  }
}

class ProjectRow extends StatelessWidget {
  final Project project;

  ProjectRow(this.project);

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      onTap: () {
        AppDatabase.get().deleteProject(project.id).then((value) {
          print("Success :" + value);
          if (value != null) {
          }
        });
      },
      leading: new Container(
        width: 24.0,
        height: 24.0,
      ),
      title: new Text(project.name),
      trailing: Container(
        height: 10.0,
        width: 10.0,
        child: new CircleAvatar(
          backgroundColor: new Color(project.colorValue),
        ),
      ),
    );
  }
}

class LabelRow extends StatelessWidget {
  final Label label;

  LabelRow(this.label);

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      onTap: () {},
      leading: new Container(
        width: 24.0,
        height: 24.0,
      ),
      title: new Text("@ ${label.name}"),
      trailing: Container(
        height: 10.0,
        width: 10.0,
        child: new Icon(
          Icons.label,
          size: 16.0,
          color: new Color(label.colorValue),
        ),
      ),
    );
  }
}
