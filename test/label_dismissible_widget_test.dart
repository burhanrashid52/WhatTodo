import 'package:flutter/material.dart';
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
    //TODO: Test immediately the LabelRow
    final mockLabelDb = MockLabelDB();

    when(mockLabelDb.getLabels())
        .thenAnswer((_) => Future.value([testLabel1, testLabel2, testLabel3]));

    when(mockLabelDb.deleteLabel(any)).thenAnswer((_) => Future.value());

    var labelBloc = LabelBloc(mockLabelDb);

    final wrapMaterialAppWithBlock =
        LabelPage().wrapScaffoldWithBloc(labelBloc);
    await tester.pumpWidget(wrapMaterialAppWithBlock);
    labelBloc.refresh();

    await tester.pump();

    // Swipe the item to dismiss it.
    await tester.ensureVisible(find.byType(ExpansionTile));
    await tester.tap(find.byKey(ValueKey(SideDrawerKeys.DRAWER_LABELS)));
    /*await tester.drag(
        find.byKey(ValueKey("swipe_${testLabel1.name}_${testLabel1.id}")),
        Offset(500.0, 0.0));

    when(mockLabelDb.getLabels())
        .thenAnswer((_) => Future.value([testLabel2, testLabel3]));

    await tester.pumpAndSettle();

    expect(find.byType(LabelRow), findsNWidgets(2));
    expect(find.text(testLabel1.name), findsNothing);
    expect(find.text(testLabel2.name), findsOneWidget);
    expect(find.text(testLabel3.name), findsOneWidget);
    expect(verify(mockLabelDb.deleteLabel(captureAny)).captured.single,
        testLabel1.id);*/
  });
}
