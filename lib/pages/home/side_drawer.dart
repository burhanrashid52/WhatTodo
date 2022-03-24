import 'package:flutter/material.dart';
import 'package:flutter_app/db/AppDatabase.dart';
import 'package:flutter_app/models/Label.dart';
import 'package:flutter_app/models/Project.dart';
import 'package:flutter_app/pages/about/about_us.dart';
import 'package:flutter_app/pages/labels/add_label.dart';
import 'package:flutter_app/pages/projects/add_project.dart';

class SideDrawer extends StatefulWidget {
  ProjectSelection projectSelection;
  LabelSelection labelSelection;
  DateSelection dateSelection;

  SideDrawer({
    AppDatabase appDatabase,
    this.projectSelection,
    this.labelSelection,
    this.dateSelection,
  }) : this.appDatabase = appDatabase ?? AppDatabase.get();

  final AppDatabase appDatabase;

  @override
  _SideDrawerState createState() =>
      _SideDrawerState(projectSelection, labelSelection, dateSelection);
}

class _SideDrawerState extends State<SideDrawer> {
  final List<Project> projectList = List();
  final List<Label> labelList = List();
  ProjectSelection projectSelectionListener;
  LabelSelection labelSelectionListener;
  DateSelection dateSelectionListener;

  _SideDrawerState(this.projectSelectionListener, this.labelSelectionListener,
      this.dateSelectionListener);

  @override
  void initState() {
    super.initState();
    updateProjects();
    updateLabels();
  }

  AppDatabase get database => widget.appDatabase;

  void updateProjects() {
    database.getProjects(isInboxVisible: false).then((projects) {
      if (projects != null) {
        setState(() {
          projectList.clear();
          projectList.addAll(projects);
        });
      }
    });
  }

  void updateLabels() {
    database.getLabels().then((projects) {
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
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("Burhanuddin Rashid"),
            accountEmail: Text("burhanrashid5253@gmail.com"),
            otherAccountsPictures: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.info,
                    color: Colors.white,
                    size: 36.0,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<bool>(
                          builder: (context) => AboutUsScreen()),
                    );
                  })
            ],
            currentAccountPicture: CircleAvatar(
              backgroundColor: Theme.of(context).accentColor,
              backgroundImage: AssetImage("assets/profile_pic.jpg"),
            ),
          ),
          ListTile(
              leading: Icon(Icons.inbox),
              title: Text("Inbox"),
              onTap: () {
                if (projectSelectionListener != null) {
                  var project = Project.getInbox();
                  projectSelectionListener(project);
                  Navigator.pop(context);
                }
              }),
          ListTile(
              onTap: () {
                var dateTime = DateTime.now();
                var taskStartTime =
                    DateTime(dateTime.year, dateTime.month, dateTime.day)
                        .millisecondsSinceEpoch;
                var taskEndTime = DateTime(
                        dateTime.year, dateTime.month, dateTime.day, 23, 59)
                    .millisecondsSinceEpoch;

                if (dateSelectionListener != null) {
                  dateSelectionListener(taskStartTime, taskEndTime);
                }
                Navigator.pop(context);
              },
              leading: Icon(Icons.calendar_today),
              title: Text("Today")),
          ListTile(
            onTap: () {
              var dateTime = DateTime.now();
              var taskStartTime =
                  DateTime(dateTime.year, dateTime.month, dateTime.day)
                      .millisecondsSinceEpoch;
              var taskEndTime = DateTime(
                      dateTime.year, dateTime.month, dateTime.day + 7, 23, 59)
                  .millisecondsSinceEpoch;

              if (dateSelectionListener != null) {
                dateSelectionListener(taskStartTime, taskEndTime);
              }
              Navigator.pop(context);
            },
            leading: Icon(Icons.calendar_today),
            title: Text("Next 7 Days"),
          ),
          buildExpansionTile(Icons.book, "Projects"),
          buildExpansionTile(Icons.label, "Labels")
        ],
      ),
    );
  }

  ExpansionTile buildExpansionTile(IconData icon, String projectName) {
    return ExpansionTile(
      leading: Icon(icon),
      title: Text(projectName,
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),
      children: projectName == "Projects" ? buildProjects() : buildLabels(),
    );
  }

  List<Widget> buildProjects() {
    List<Widget> projectWidgetList = List();
    projectList.forEach((project) => projectWidgetList.add(ProjectRow(
          project,
          projectSelection: (selectedProject) {
            projectSelectionListener(selectedProject);
            Navigator.pop(context);
          },
        )));
    projectWidgetList.add(ListTile(
      leading: Icon(Icons.add),
      title: Text("Add Project"),
      onTap: () async {
        Navigator.pop(context);
        bool isDataChanged = await Navigator.push(
            context,
            MaterialPageRoute<bool>(
                builder: (context) => AddProject()));

        if (isDataChanged) {
          updateProjects();
        }
      },
    ));
    return projectWidgetList;
  }

  List<Widget> buildLabels() {
    List<Widget> projectWidgetList = List();
    labelList.forEach((label) =>
        projectWidgetList.add(LabelRow(label, labelSelection: (label) {
          labelSelectionListener(label);
          Navigator.pop(context);
        })));
    projectWidgetList.add(ListTile(
        leading: Icon(Icons.add),
        title: Text("Add Label"),
        onTap: () async {
          Navigator.pop(context);
          bool isDataChanged = await Navigator.push(
              context,
              MaterialPageRoute<bool>(
                  builder: (context) => AddLabel()));

          if (isDataChanged) {
            updateLabels();
          }
        }));
    return projectWidgetList;
  }
}

class ProjectRow extends StatelessWidget {
  final Project project;
  final ProjectSelection projectSelection;

  ProjectRow(this.project, {this.projectSelection});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        if (projectSelection != null) {
          projectSelection(project);
        }
      },
      leading: Container(
        width: 24.0,
        height: 24.0,
      ),
      title: Text(project.name),
      trailing: Container(
        height: 10.0,
        width: 10.0,
        child: CircleAvatar(
          backgroundColor: Color(project.colorValue),
        ),
      ),
    );
  }
}

class LabelRow extends StatelessWidget {
  final Label label;
  final LabelSelection labelSelection;

  LabelRow(this.label, {this.labelSelection});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        if (labelSelection != null) {
          labelSelection(label);
        }
      },
      leading: Container(
        width: 24.0,
        height: 24.0,
      ),
      title: Text("@ ${label.name}"),
      trailing: Container(
        height: 10.0,
        width: 10.0,
        child: Icon(
          Icons.label,
          size: 16.0,
          color: Color(label.colorValue),
        ),
      ),
    );
  }
}

typedef void ProjectSelection(Project project);
typedef void LabelSelection(Label label);
typedef void DateSelection(int startDate, int endDate);
