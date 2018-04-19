import 'package:flutter/material.dart';

class UserChatScreen extends StatelessWidget {
  final String name;

  UserChatScreen(this.name);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Second Screen"),
      ),
      body: new Center(
        child: new RaisedButton(
            child: new Text(name),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
    );
  }
}
