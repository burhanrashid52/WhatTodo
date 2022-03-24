import 'dart:async';

import 'package:flutter/material.dart';

class AddCommentDialog extends StatefulWidget {
  @override
  _AddCommentDialogState createState() => _AddCommentDialogState();
}

class _AddCommentDialogState extends State<AddCommentDialog> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

Future<String> showCommentDialog(BuildContext context) async {
  return await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: TextField(),
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  Navigator.pop(context,"");
                },
                child: Text("CANCEL",
                    style:
                        TextStyle(color: Theme.of(context).accentColor))),
            FlatButton(
                onPressed:() {},
                child: Text("SAVE",
                    style: TextStyle(color: Theme.of(context).accentColor)))
          ],
        );
      });
}
