import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/bloc_provider.dart';
import 'package:flutter_app/pages/home/home_bloc.dart';
import 'package:flutter_app/pages/labels/label.dart';
import 'package:flutter_app/pages/labels/label_bloc.dart';
import 'package:flutter_app/pages/labels/label_db.dart';
import 'package:flutter_app/pages/labels/label_widget.dart';
import 'package:flutter_app/utils/keys.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'add_task_widget_test.mocks.dart';
import 'test_data.dart';
import 'test_helpers.dart';

@GenerateMocks([LabelDB])
main() {
  testWidgets("Swipe left/right to delete label", (tester) async {
    final mockLabelDb = MockLabelDB();

    when(mockLabelDb.getLabels())
        .thenAnswer((_) => Future.value([testLabel1, testLabel2, testLabel3]));
    when(mockLabelDb.deleteLabel(any)).thenAnswer((_) => Future.value());

    final labelBloc = LabelBloc(mockLabelDb);
    final homeBloc = HomeBloc();

    final wrapMaterialAppWithBlock =
        BlocProvider(child: LabelPage(), bloc: labelBloc)
            .wrapScaffoldWithBloc(homeBloc);
    await tester.pumpWidget(wrapMaterialAppWithBlock);
    labelBloc.refresh();
    await tester.pump();

    await tester.tap(find.byKey(ValueKey(SideDrawerKeys.DRAWER_LABELS)));
    await tester.pumpAndSettle();

    await tester.drag(
        find.byKey(ValueKey("swipe_${testLabel1.name}_${testLabel1.id}")),
        Offset(400, 0));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(ValueKey(DialogKeys.CONFIRM_BUTTON)));
    await tester.pumpAndSettle();

    when(mockLabelDb.getLabels())
        .thenAnswer((_) => Future.value([testLabel2, testLabel3]));
    labelBloc.refresh();
    await tester.pumpAndSettle();

    expect(find.byType(LabelRow), findsNWidgets(2));
    expect(find.byKey(ValueKey("swipe_${testLabel1.name}_${testLabel1.id}")),
        findsNothing);
    expect(find.byKey(ValueKey("swipe_${testLabel2.name}_${testLabel2.id}")),
        findsOneWidget);
    expect(find.byKey(ValueKey("swipe_${testLabel3.name}_${testLabel3.id}")),
        findsOneWidget);
    expect(verify(mockLabelDb.deleteLabel(captureAny)).captured.single,
        testLabel1.id);
  });
}
