import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/bloc_provider.dart';
import 'package:flutter_app/db/app_db.dart';
import 'package:flutter_app/pages/home/home_bloc.dart';
import 'package:flutter_app/pages/labels/add_label.dart';
import 'package:flutter_app/pages/labels/label.dart';
import 'package:flutter_app/pages/labels/label_bloc.dart';
import 'package:flutter_app/pages/labels/label_db.dart';
import 'package:flutter_app/pages/tasks/bloc/task_bloc.dart';
import 'package:flutter_app/utils/keys.dart';

class LabelPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LabelBloc labelBloc = BlocProvider.of(context);
    return StreamBuilder<List<Label>>(
      stream: labelBloc.labels,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return LabelExpansionTileWidget(snapshot.data!);
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}

class LabelExpansionTileWidget extends StatelessWidget {
  final List<Label> _labels;

  LabelExpansionTileWidget(this._labels);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      key: ValueKey(SideDrawerKeys.DRAWER_LABELS),
      leading: Icon(Icons.label_outline),
      title: Text("Labels",
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),
      children: buildLabels(context),
    );
  }

  List<Widget> buildLabels(BuildContext context) {
    LabelBloc _labelBloc = BlocProvider.of(context);
    List<Widget> projectWidgetList = [];
    _labels.forEach((label) => projectWidgetList.add(LabelRow(label)));
    projectWidgetList.add(ListTile(
        leading: Icon(Icons.add),
        title: Text(
          "Add Label",
          key: ValueKey(SideDrawerKeys.ADD_LABEL),
        ),
        onTap: () async {
          Navigator.pop(context);

          var blocLabelProvider = BlocProvider(
            bloc: LabelBloc(LabelDB.get()),
            child: AddLabel(),
          );

          await Navigator.push(context,
              MaterialPageRoute<bool>(builder: (context) => blocLabelProvider));

          _labelBloc.refresh();
        }));
    return projectWidgetList;
  }
}

class LabelRow extends StatefulWidget {
  final Label label;

  LabelRow(this.label);

  @override
  _LabelRowState createState() => _LabelRowState();
}

class _LabelRowState extends State<LabelRow> {
  late AppDatabase db;

  var labelDB = LabelDB.get();

  @override
  Widget build(BuildContext context) {
    HomeBloc homeBloc = BlocProvider.of(context);
    return ListTile(
      key: ValueKey("tile_${widget.label.name}_${widget.label.id}"),
      onTap: () {
        homeBloc.applyFilter(
            "@ ${widget.label.name}", Filter.byLabel(widget.label.name));
        Navigator.pop(context);
      },
      leading: Container(
        child: Icon(
          Icons.label,
          size: 20,
          color: Color(widget.label.colorValue),
        ),
        width: 24.0,
        height: 24.0,
        key: ValueKey("space_${widget.label.name}_${widget.label.id}"),
      ),
      title: Text(
        "@ ${widget.label.name}",
        key: ValueKey("${widget.label.name}_${widget.label.id}"),
      ),
      trailing: IconButton(
        onPressed: () {
          _showMyDialog1(widget.label.id);
        },
        icon: Icon(
          Icons.delete,
          size: 20.0,
          key: ValueKey("icon_${widget.label.name}_${widget.label.id}"),
          color: Colors.grey[500],
        ),
      ),
    );
  }

  _showMyDialog1(int? id) async {
    LabelBloc _labelBloc = BlocProvider.of(context);
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Text(
              'Alert',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure want to delete this label? '),
                Text(
                    'This will also delete the project associated with this label'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                _labelBloc.del(id);
                _labelBloc.refresh();
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
