import 'package:flutter_app/models/priority.dart';
import 'package:flutter_app/pages/tasks/models/tasks.dart';
import 'package:flutter_app/pages/tasks/task_db.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:flutter_app/main.dart' as app;

Future<void> main() async {
  // ignore: missing_return
  Future<String> dataHandler(String msg) async {
    var taskDB = TaskDB.get();
    print(msg);
    switch (msg) {
      case "addTask":
        var task = Tasks.create(
          title: "Test Tile",
          priority: Status.PRIORITY_1,
          projectId: 1,
        );
        await taskDB.updateTask(task);
        break;
      case "clearTask":
        taskDB.deleteTask(1);
        break;
    }
  }

  // This line enables the extension.
  enableFlutterDriverExtension(handler: dataHandler);

  // Call the `main()` function of the app, or call `runApp` with
  // any widget you are interested in testing.
  app.main();
}
