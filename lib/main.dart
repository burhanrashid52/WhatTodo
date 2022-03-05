import 'package:flutter/material.dart';
import 'package:flutter_app/pages/home/home.dart';
import 'package:flutter_app/pages/tasks/add_task.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFFDE4435);
    final theme = ThemeData(
      primaryColor: primaryColor,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/addTask': (BuildContext context) => new AddTaskScreen(),
      },
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          secondary: Colors.orange,
          primary: primaryColor,
        ),
      ),
      home: new HomeScreen(),
    );
  }
}
