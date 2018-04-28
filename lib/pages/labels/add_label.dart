import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/db/AppDatabase.dart';
import 'package:flutter_app/models/Label.dart';
import 'package:flutter_app/models/Project.dart';
import 'package:flutter_app/utils/color_utils.dart';

class AddLabel extends StatefulWidget {
  @override
  _AddLabelState createState() => new _AddLabelState();
}

class _AddLabelState extends State<AddLabel> {
  ColorPalette currentSelectedPalette =
      new ColorPalette("Grey", Colors.grey.value);

  String labelName = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Add Label"),
      ),
      floatingActionButton: new FloatingActionButton(
          child: new Icon(
            Icons.send,
            color: Colors.white,
          ),
          onPressed: () {
            if (labelName != "") {
              var label = Label.create(
                  labelName,
                  currentSelectedPalette.colorValue,
                  currentSelectedPalette.colorName);
              AppDatabase.get().updateLabels(label).then((value) {
                Navigator.pop(context, true);
              });
            }
          }),
      body: new ListView(
        children: <Widget>[
          new Padding(
            padding: const EdgeInsets.all(8.0),
            child: new TextField(
              decoration: new InputDecoration(hintText: "Label Name"),
              maxLength: 20,
              onChanged: (value) {
                setState(() {
                  labelName = value;
                });
              },
            ),
          ),
          new Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: new ExpansionTile(
              initiallyExpanded: false,
              leading: new Icon(
                Icons.label,
                size: 16.0,
                color: new Color(currentSelectedPalette.colorValue),
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
        leading: new Icon(
          Icons.label,
          size: 16.0,
          color: new Color(colors.colorValue),
        ),
        title: new Text(colors.colorName),
        onTap: () {
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
