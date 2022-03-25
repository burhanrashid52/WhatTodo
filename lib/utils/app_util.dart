import 'package:flutter/material.dart';
import 'package:flutter_app/utils/app_constant.dart';
import 'package:url_launcher/url_launcher.dart';

showSnackbar(
  BuildContext context,
  String message, {
  MaterialColor materialColor,
}) {
  if (message.isEmpty) return;
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: materialColor,
    ),
  );
}

launchURL(String url) async {
  if (url.isEmpty) return;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class NoTaskFound extends StatelessWidget {
  const NoTaskFound({
    Key key,
    @required this.message,
  }) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: TextStyle(
          fontSize: FONT_MEDIUM,
          color: Colors.black,
        ),
      ),
    );
  }
}
