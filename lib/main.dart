import 'package:flutter/material.dart';
import 'add_task.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
          accentColor: Colors.black, primaryColor: const Color(0xFFDE4435)),
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("Title"),
        ),
        body: new Center(child: new Text("Center")),
        floatingActionButton: new FloatingActionButton(
          child: new Icon(Icons.add),
          backgroundColor: Colors.orange,
          onPressed: () {
            print("Clicked");
            Navigator.push(
              context,
              new MaterialPageRoute(builder: (context) => new AddTaskScreen()),
            );
          },
        ),
        drawer: new Drawer(
          child: new ListView(
            padding: const EdgeInsets.all(16.0),
            children: <Widget>[new DrawerHeader(child: new CircleAvatar())],
          ),
        ),
      ),
    );
  }
}
