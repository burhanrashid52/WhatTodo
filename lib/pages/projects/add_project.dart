import 'package:flutter/material.dart';
import 'package:flutter_app/db/AppDatabase.dart';
import 'package:flutter_app/models/Project.dart';
import 'package:flutter_app/utils/collapsable_expand_tile.dart';
import 'package:flutter_app/utils/color_utils.dart';

class AddProject extends StatefulWidget {
  @override
  _AddProjectState createState() => _AddProjectState();
}

class _AddProjectState extends State<AddProject> {
  ColorPalette currentSelectedPalette =
      ColorPalette("Grey", Colors.grey.value);

  final expansionTile = GlobalKey<CollapsibleExpansionTileState>();
  GlobalKey<FormState> _formState = GlobalKey<FormState>();

  String projectName = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Project"),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(
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
      body: ListView(
        children: <Widget>[
          Form(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(hintText: "Project Name"),
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
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: CollapsibleExpansionTile(
              key: expansionTile,
              leading: Container(
                width: 12.0,
                height: 12.0,
                child: CircleAvatar(
                  backgroundColor: Color(currentSelectedPalette.colorValue),
                ),
              ),
              title: Text(currentSelectedPalette.colorName),
              children: buildMaterialColors(),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> buildMaterialColors() {
    List<Widget> projectWidgetList = List();
    colorsPalettes.forEach((colors) {
      projectWidgetList.add(ListTile(
        leading: Container(
          width: 12.0,
          height: 12.0,
          child: CircleAvatar(
            backgroundColor: Color(colors.colorValue),
          ),
        ),
        title: Text(colors.colorName),
        onTap: () {
          expansionTile.currentState.collapse();
          setState(() {
            currentSelectedPalette =
                ColorPalette(colors.colorName, colors.colorValue);
          });
        },
      ));
    });
    return projectWidgetList;
  }
}
