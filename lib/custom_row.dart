import 'package:flutter/material.dart';
import 'dummy_data.dart';

class MyCustomRow extends StatelessWidget {
  final ChatModel chatModel;

  MyCustomRow(this.chatModel);

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new AspectRatio(aspectRatio: 16/9,child:new Image.network(chatModel.avatarUrl,fit: BoxFit.cover)),
        new Text(chatModel.name),
        new Text(chatModel.message)
      ],
    );
  }
}
