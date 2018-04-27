import 'package:flutter/material.dart';

class AddProject extends StatefulWidget {
  @override
  _AddProjectState createState() => new _AddProjectState();
}

class _AddProjectState extends State<AddProject> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Add Project"),
      ),
    );
  }
}
