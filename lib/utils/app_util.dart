import 'package:flutter/material.dart';
import 'package:flutter_app/utils/app_constant.dart';
import 'package:url_launcher/url_launcher.dart';

showSnackbar(GlobalKey<ScaffoldState> scaffoldState, String message,
    {MaterialColor materialColor}) {
  if (message.isEmpty) return;
  // Find the Scaffold in the Widget tree and use it to show a SnackBar
  scaffoldState.currentState.showSnackBar(
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
          style: TextStyle(fontSize: FONT_MEDIUM, color: Colors.black)),
    );
  }
}
