import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new ListView.builder(
      itemBuilder: (BuildContext context, int index) => new Text("Number"),
      itemCount: 100,
    ));
  }
}

class ChatModel {
  final String name;
  final String message;
  final String avatarUrl;
  final String time;
}
