import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/bloc_provider.dart';
import 'package:flutter_app/db/label_db.dart';
import 'package:flutter_app/models/label.dart';
import 'package:flutter_app/pages/home/side_drawer.dart';
import 'package:flutter_app/pages/labels/add_label.dart';
import 'package:flutter_app/pages/labels/label_bloc.dart';

class LabelPage extends StatelessWidget {
  final LabelSelection labelSelection;

  LabelPage(this.labelSelection);

  @override
  Widget build(BuildContext context) {
    LabelBloc _labelBloc = BlocProvider.of(context);
    return StreamBuilder<List<Label>>(
      stream: _labelBloc.labels,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return buildExpansionTile(context, snapshot.data);
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  ExpansionTile buildExpansionTile(BuildContext context, List<Label> labels) {
    return ExpansionTile(
      leading: Icon(Icons.label),
      title: Text("Labels",
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),
      children: buildLabels(context, labels),
    );
  }

  List<Widget> buildLabels(BuildContext context, List<Label> labelList) {
    List<Widget> projectWidgetList = List();
    labelList.forEach((label) =>
        projectWidgetList.add(LabelRow(label, labelSelection: (label) {
          labelSelection(label);
          Navigator.pop(context);
        })));
    projectWidgetList.add(ListTile(
        leading: Icon(Icons.add),
        title: Text("Add Label"),
        onTap: () async {
          Navigator.pop(context);

          var blocLabelProvider = BlocProvider(
            bloc: LabelBloc(LabelDB.get()),
            child: AddLabel(),
          );

          await Navigator.push(context,
              MaterialPageRoute<bool>(builder: (context) => blocLabelProvider));

          LabelBloc _labelBloc = BlocProvider.of(context);
          _labelBloc.refresh();
        }));
    return projectWidgetList;
  }
}
