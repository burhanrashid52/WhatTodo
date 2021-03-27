import 'package:integration_test/integration_test.dart';
import 'about_us_page_test.dart' as about;
import 'add_label_page_test.dart' as label;
import 'add_project_page_test.dart' as project;
import 'add_task_page_test.dart' as tasks;
import 'completed_tasks_page_test.dart' as tasks_completed;
import 'home_page_test.dart' as home;
import 'whattodo_tests.dart' as whattodo;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  whattodo.main();
  home.main();
  tasks.main();
  tasks_completed.main();
  project.main();
  label.main();
  about.main();
}
