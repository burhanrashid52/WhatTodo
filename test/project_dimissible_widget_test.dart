import 'package:flutter/foundation.dart';
import 'package:flutter_app/bloc/bloc_provider.dart';
import 'package:flutter_app/pages/home/home_bloc.dart';
import 'package:flutter_app/pages/projects/project_bloc.dart';
import 'package:flutter_app/pages/projects/project_db.dart';
import 'package:flutter_app/pages/projects/project_widget.dart';
import 'package:flutter_app/utils/keys.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'add_task_widget_test.mocks.dart';
import 'test_data.dart';
import 'test_helpers.dart';

@GenerateMocks([ProjectDB])
main() {
  testWidgets("Swipe left to delete project", (tester) async {
    final mockProjectDb = MockProjectDB();

    when(mockProjectDb.getProjects(isInboxVisible: false)).thenAnswer(
        (_) => Future.value([testProject1, testProject2, testProject3]));
    when(mockProjectDb.deleteProject(any)).thenAnswer((_) => Future.value());

    final projectBloc = ProjectBloc(mockProjectDb);
    final homeBloc = HomeBloc();

    final wrapMaterialAppWithBlock =
        BlocProvider(child: ProjectPage(), bloc: projectBloc)
            .wrapScaffoldWithBloc(homeBloc);
    await tester.pumpWidget(wrapMaterialAppWithBlock);
    projectBloc.refresh();
    await tester.pump();

    await tester.tap(find.byKey(ValueKey(SideDrawerKeys.DRAWER_PROJECTS)));
    await tester.pumpAndSettle();

    await tester.drag(
        find.byKey(ValueKey("swipe_${testProject1.name}_${testProject1.id}")),
        Offset(400, 0));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(ValueKey(DialogKeys.CONFIRM_BUTTON)));
    await tester.pumpAndSettle();

    when(mockProjectDb.getProjects(isInboxVisible: false))
        .thenAnswer((_) => Future.value([testProject2, testProject3]));
    projectBloc.refresh();
    await tester.pumpAndSettle();

    expect(find.byType(ProjectRow), findsNWidgets(2));
    expect(
        find.byKey(ValueKey("swipe_${testProject1.name}_${testProject1.id}")),
        findsNothing);
    expect(
        find.byKey(ValueKey("swipe_${testProject2.name}_${testProject2.id}")),
        findsOneWidget);
    expect(
        find.byKey(ValueKey("swipe_${testProject3.name}_${testProject3.id}")),
        findsOneWidget);
    expect(verify(mockProjectDb.deleteProject(captureAny)).captured.single,
        testProject1.id);
  });
}
