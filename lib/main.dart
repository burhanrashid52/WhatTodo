import 'package:flutter/material.dart';
import 'package:flutter_app/home.dart';
import 'package:flutter_app/taskpages/add_task.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: <String, WidgetBuilder>{
          '/addTask': (BuildContext context) => new AddTaskScreen(),
        },
        theme: new ThemeData(
            accentColor: Colors.orange, primaryColor: const Color(0xFFDE4435)),
        home: new HomeScreen());
  }
}
