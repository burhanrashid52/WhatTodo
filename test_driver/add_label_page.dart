import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/bloc_provider.dart';
import 'package:flutter_app/models/priority.dart';
import 'package:flutter_app/pages/labels/label.dart';
import 'package:flutter_app/pages/labels/label_db.dart';
import 'package:flutter_app/pages/projects/project.dart';
import 'package:flutter_app/pages/projects/project_db.dart';
import 'package:flutter_app/pages/tasks/add_task.dart';
import 'package:flutter_app/pages/tasks/bloc/add_task_bloc.dart';
import 'package:flutter_app/pages/tasks/models/tasks.dart';
import 'package:flutter_app/pages/tasks/task_db.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:flutter_app/main.dart' as app;
import 'package:test/test.dart';

Future<void> main() async {
  // This line enables the extension.
  enableFlutterDriverExtension();

  // Call the `main()` function of the app, or call `runApp` with
  // any widget you are interested in testing.
  app.main();
}
