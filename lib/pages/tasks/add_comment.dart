import 'dart:async';

import 'package:flutter/material.dart';

class AddCommentDialog extends StatefulWidget {
  @override
  _AddCommentDialogState createState() => new _AddCommentDialogState();
}

class _AddCommentDialogState extends State<AddCommentDialog> {
  @override
  Widget build(BuildContext context) {
    return new Container();
  }
}

Future<String> showCommentDialog(BuildContext context) async {
  return await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return new AlertDialog(
          content: new TextField(),
          actions: <Widget>[
            new FlatButton(
                onPressed: () {
                  Navigator.pop(context,"");
                },
                child: new Text("CANCEL",
                    style:
                        new TextStyle(color: Theme.of(context).accentColor))),
            new FlatButton(
                onPressed:() {},
                child: new Text("SAVE",
                    style: new TextStyle(color: Theme.of(context).accentColor)))
          ],
        );
      });
}
