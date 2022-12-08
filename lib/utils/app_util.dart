import 'package:flutter/material.dart';
import 'package:flutter_app/utils/app_constant.dart';
import 'package:flutter_app/utils/keys.dart';
import 'package:flutter_app/utils/widgets_util.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:url_launcher/url_launcher.dart';

import 'color_utils.dart';

showSnackbar(context, String message, {MaterialColor? materialColor}) {
  if (message.isEmpty) return;
  // Find the Scaffold in the Widget tree and use it to show a SnackBar
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: materialColor));
}

launchURL(String url) async {
  if (url.isEmpty) return;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class MessageInCenterWidget extends StatelessWidget {
  final String _message;

  MessageInCenterWidget(this._message);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(_message,
          key: ValueKey(HomePageKeys.MESSAGE_IN_CENTER),
          style: TextStyle(fontSize: FONT_MEDIUM, color: Colors.black)),
    );
  }
}

bool confirmAlert(
  BuildContext context, {
  Function()? onConfirm,
  Function()? onCancel,
  String title = 'CONFIRMATION',
  String desc =
      'You are about de delete an entire project. Everything that depends on it will be deleted as well.',
}) {
  var confirm = false;
  Alert(
    style: alertStyle,
    context: context,
    type: AlertType.none,
    title: title,
    desc: desc,
    buttons: [
      DialogButton(
        color: priorityColor[0],
        child: Text(
          "Confirm",
          style: TextStyle(color: Colors.white, fontSize: FONT_SIZE_LABEL),
        ),
        radius: BorderRadius.all(Radius.zero),
        onPressed: () {
          confirm = true;
          if (onConfirm != null) {
            onConfirm();
          }
          Navigator.pop(context);
        },
      ),
      DialogButton(
        color: priorityColor[1],
        child: Text(
          "Cancel",
          style: TextStyle(color: Colors.white, fontSize: FONT_SIZE_LABEL),
        ),
        radius: BorderRadius.all(Radius.zero),
        onPressed: () {
          confirm = false;
          if (onCancel != null) {
            onCancel();
          }
          Navigator.pop(context);
        },
      )
    ],
  ).show();
  return confirm;
}
