import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/bloc_provider.dart';
import 'package:flutter_app/pages/home/home_bloc.dart';
import 'package:flutter_app/pages/projects/project.dart';
import 'package:flutter_app/pages/projects/project_bloc.dart';
import 'package:flutter_app/utils/collapsable_expand_tile.dart';
import 'package:flutter_app/utils/color_utils.dart';
import 'package:flutter_app/utils/keys.dart';
import 'package:flutter_app/utils/extension.dart';
import 'package:flutter_app/utils/app_util.dart';

class AddProject extends StatelessWidget {
  final expansionTile = GlobalKey<CollapsibleExpansionTileState>();
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ProjectBloc _projectBloc = BlocProvider.of(context);
    late ColorPalette currentSelectedPalette;
    String projectName = "";

    scheduleMicrotask(() {
      _projectBloc.projectExist.listen((exists) {
        if (exists) {
          showSnackbar(context, "Project already exists");
        } else {
          context.safePop();
          if (context.isWiderScreen()) {
            context.bloc<HomeBloc>().updateScreen(SCREEN.HOME);
          }
        }
      });
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Project",
          key: ValueKey(AddProjectKeys.TITLE_ADD_PROJECT),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          key: ValueKey(AddProjectKeys.ADD_PROJECT_BUTTON),
          child: Icon(
            Icons.send,
            color: Colors.white,
          ),
          onPressed: () {
            if (_formState.currentState!.validate()) {
              _formState.currentState!.save();
              var project = Project.create(
                projectName,
                currentSelectedPalette.colorValue,
                currentSelectedPalette.colorName,
              );
              _projectBloc.createOrExists(project);
            }
          }),
      body: ListView(
        children: <Widget>[
          Form(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                key: ValueKey(AddProjectKeys.TEXT_FORM_PROJECT_NAME),
                decoration: InputDecoration(hintText: "Project Name"),
                maxLength: 20,
                validator: (value) {
                  return value!.isEmpty ? "Project name cannot be empty" : null;
                },
                onSaved: (value) {
                  projectName = value!;
                },
              ),
            ),
            key: _formState,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: StreamBuilder<ColorPalette>(
              stream: _projectBloc.colorSelection,
              initialData: ColorPalette("Grey", Colors.grey.value),
              builder: (context, snapshot) {
                currentSelectedPalette = snapshot.data!;
                return CollapsibleExpansionTile(
                  key: expansionTile,
                  leading: Container(
                    width: 12.0,
                    height: 12.0,
                    child: CircleAvatar(
                      backgroundColor: Color(snapshot.data!.colorValue),
                    ),
                  ),
                  title: Text(snapshot.data!.colorName),
                  children: buildMaterialColors(_projectBloc),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  List<Widget> buildMaterialColors(ProjectBloc projectBloc) {
    List<Widget> projectWidgetList = [];
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
          expansionTile.currentState!.collapse();
          projectBloc.updateColorSelection(
            ColorPalette(colors.colorName, colors.colorValue),
          );
        },
      ));
    });
    return projectWidgetList;
  }
}
