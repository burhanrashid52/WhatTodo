import 'package:flutter_app/pages/labels/label.dart';
import 'package:flutter_app/pages/labels/label_bloc.dart';
import 'package:flutter_app/pages/labels/label_db.dart';
import 'package:flutter_app/utils/color_utils.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'test_data.dart';

void main() {
  test("Show label in the label list test", () async {
    final FakeLabelDb fakeLabelDb = FakeLabelDb();

    final LabelBloc labelBloc = LabelBloc(fakeLabelDb);
    await expectLater(
        labelBloc.labels,
        emitsInOrder([
          [testLabel1, testLabel2],
        ]));
  });

  test("Add label if not exist in the label db test", () async {
    final FakeLabelDb fakeLabelDb = FakeLabelDb();
    final LabelBloc labelBloc = LabelBloc(fakeLabelDb);

    expect(labelBloc.labelsExist, emitsInOrder([false]));
    labelBloc.checkIfLabelExist(testLabel3);

    await expectLater(
        labelBloc.labels,
        emitsInOrder([
          [testLabel1, testLabel2, testLabel3],
        ]));
  });

  test("Don't Add label if exist in the label db test", () async {
    final FakeLabelDb fakeLabelDb = FakeLabelDb();
    final LabelBloc labelBloc = LabelBloc(fakeLabelDb);

    expect(labelBloc.labelsExist, emitsInOrder([true]));
    labelBloc.checkIfLabelExist(testLabel1);

    await expectLater(
        labelBloc.labels,
        emitsInOrder([
          [testLabel1, testLabel2],
        ]));
  });

  test("Update Label color palette  test", () async {
    final FakeLabelDb fakeLabelDb = FakeLabelDb();
    final LabelBloc labelBloc = LabelBloc(fakeLabelDb);
    expect(
        labelBloc.colorSelection,
        emitsInOrder(
          [
            colorsPalettes[0],
            colorsPalettes[1],
            colorsPalettes[2],
          ],
        ));
    labelBloc.updateColorSelection(colorsPalettes[0]);
    labelBloc.updateColorSelection(colorsPalettes[1]);
    labelBloc.updateColorSelection(colorsPalettes[2]);
  });

  test("Refresh Label list test", () async {
    final FakeLabelDb fakeLabelDb = FakeLabelDb();
    final LabelBloc labelBloc = LabelBloc(fakeLabelDb);
    await expectLater(
        labelBloc.labels,
        emitsInOrder([
          [testLabel1, testLabel2],
        ]));

    fakeLabelDb.isLabelExits(testLabel3);
    labelBloc.refresh();
    await expectLater(
        labelBloc.labels,
        emitsInOrder([
          [testLabel1, testLabel2],
          [testLabel1, testLabel2, testLabel3],
        ]));
  });
}

class FakeLabelDb extends Fake implements LabelDB {
  List<Label> labelList = List.empty(growable: true);

  @override
  Future<List<Label>> getLabels() async {
    if (!labelList.contains(testLabel1)) {
      labelList.add(testLabel1);
    }
    if (!labelList.contains(testLabel2)) {
      labelList.add(testLabel2);
    }
    return Future.value(labelList);
  }

  @override
  Future<bool> isLabelExits(Label label) async {
    var isExist = labelList.contains(label);
    if (!isExist) {
      labelList.add(label);
    }
    return Future.value(isExist);
  }
}
