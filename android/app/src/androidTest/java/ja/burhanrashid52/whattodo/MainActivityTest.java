package ja.burhanrashid52.whattodo;

import androidx.test.rule.ActivityTestRule;
import ja.burhanrashid52.whattodo.MainActivity;
import dev.flutter.plugins.integration_test.FlutterTestRunner;
import org.junit.Rule;
import org.junit.runner.RunWith;

@RunWith(FlutterTestRunner.class)
public class MainActivityTest {
    @Rule
    public ActivityTestRule<MainActivity> rule = new ActivityTestRule<>(MainActivity.class, true, false);
}
