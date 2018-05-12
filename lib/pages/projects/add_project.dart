import 'package:flutter/material.dart';
import 'package:flutter_app/db/AppDatabase.dart';
import 'package:flutter_app/models/Project.dart';
import 'package:flutter_app/utils/collapsable_expand_tile.dart';
import 'package:flutter_app/utils/color_utils.dart';

class AddProject extends StatefulWidget {
  @override
  _AddProjectState createState() => new _AddProjectState();
}

class _AddProjectState extends State<AddProject> {
  ColorPalette currentSelectedPalette =
      new ColorPalette("Grey", Colors.grey.value);

  final expansionTile = new GlobalKey<CollapsibleExpansionTileState>();
  GlobalKey<FormState> _formState = new GlobalKey<FormState>();

  String projectName = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Add Project"),
      ),
      floatingActionButton: new FloatingActionButton(
          child: new Icon(
            Icons.send,
            color: Colors.white,
          ),
          onPressed: () {
            if (_formState.currentState.validate()) {
              _formState.currentState.save();
              var project = Project.create(
                  projectName,
                  currentSelectedPalette.colorValue,
                  currentSelectedPalette.colorName);
              AppDatabase.get().updateProject(project).then((value) {
                Navigator.pop(context, true);
              });
            }
          }),
      body: new ListView(
        children: <Widget>[
          new Form(
            child: new Padding(
              padding: const EdgeInsets.all(8.0),
              child: new TextFormField(
                decoration: new InputDecoration(hintText: "Project Name"),
                maxLength: 20,
                validator: (value) {
                  return value.isEmpty ? "Project name cannot be empty" : null;
                },
                onSaved: (value) {
                  projectName = value;
                },
              ),
            ),
            key: _formState,
          ),
          new Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: new CollapsibleExpansionTile(
              key: expansionTile,
              leading: new Container(
                width: 12.0,
                height: 12.0,
                child: new CircleAvatar(
                  backgroundColor: new Color(currentSelectedPalette.colorValue),
                ),
              ),
              title: new Text(currentSelectedPalette.colorName),
              children: buildMaterialColors(),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> buildMaterialColors() {
    List<Widget> projectWidgetList = new List();
    colorsPalettes.forEach((colors) {
      projectWidgetList.add(new ListTile(
        leading: new Container(
          width: 12.0,
          height: 12.0,
          child: new CircleAvatar(
            backgroundColor: new Color(colors.colorValue),
          ),
        ),
        title: new Text(colors.colorName),
        onTap: () {
          expansionTile.currentState.collapse();
          setState(() {
            currentSelectedPalette =
                new ColorPalette(colors.colorName, colors.colorValue);
          });
        },
      ));
    });
    return projectWidgetList;
  }
}
