import 'package:flutter/material.dart';
import 'package:flutter_app/db/AppDatabase.dart';
import 'package:flutter_app/models/Project.dart';
import 'package:flutter_app/pages/projects/add_project.dart';

class SideDrawer extends StatefulWidget {
  @override
  _SideDrawerState createState() => new _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  final List<Project> projectList = new List();

  @override
  void initState() {
    super.initState();
    AppDatabase.get().getProjects().then((projects) {
      if (projects != null) {
        setState(() {
          projectList.clear();
          projectList.addAll(projects);
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
      onTap: () {
        Navigator.pop(context);
        Navigator.push(context,
            new MaterialPageRoute(builder: (context) => new AddProject()));
      },
    ));
    return projectWidgetList;
  }

  List<Widget> buildLabels() {
    List<Widget> projectWidgetList = new List();
    projectList
        .forEach((project) => projectWidgetList.add(new ProjectRow(project)));
    projectWidgetList.add(new ListTile(
      leading: new Icon(Icons.add),
      title: new Text("Add Label"),
    ));
    return projectWidgetList;
  }
}

class ProjectRow extends StatelessWidget {
  final Project project;

  ProjectRow(this.project);

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      onTap: () {},
      leading: new Container(
        width: 24.0,
        height: 24.0,
      ),
      title: new Text(project.name),
      trailing: Container(
        height: 10.0,
        width: 10.0,
        child: new CircleAvatar(),
      ),
    );
  }
}
