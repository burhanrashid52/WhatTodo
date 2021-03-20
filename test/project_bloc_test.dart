import 'package:flutter_app/pages/projects/project.dart';
import 'package:flutter_app/pages/projects/project_bloc.dart';
import 'package:flutter_app/pages/projects/project_db.dart';
import 'package:flutter_app/utils/color_utils.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'test_data.dart';

class MockProjectDb extends Mock implements ProjectDB {}

class FakeProjectDb extends Fake implements ProjectDB {
  var isInboxVisible = false;
  List<Project> projectList = List.empty(growable: true);
  late Project lastProjectCreated;

  @override
  Future<List<Project>> getProjects({bool isInboxVisible = true}) async {
    this.isInboxVisible = isInboxVisible;
    if (isInboxVisible) {
      if (!projectList.contains(testProject1)) {
        projectList.add(testProject1);
      }
    }
    if (!projectList.contains(testProject2)) {
      projectList.add(testProject2);
    }
    if (!projectList.contains(testProject3)) {
      projectList.add(testProject3);
    }
    return Future.value(projectList);
  }

  @override
  Future insertOrReplace(Project project) async {
    lastProjectCreated = project;
    projectList.add(project);
    return Future.value();
  }

  void addProjectForRefresh(Project project) {
    projectList.add(project);
  }
}

void main() {
  test("Show inbox in the project list test", () async {
    final FakeProjectDb fakeProjectDb = FakeProjectDb();

    final ProjectBloc projectBloc = ProjectBloc(fakeProjectDb);
    expect(fakeProjectDb.isInboxVisible, false);
    await expectLater(
        projectBloc.projects,
        emitsInOrder([
          [testProject2, testProject3],
        ]));
  });

  test("Don't show inbox in the project list test", () async {
    final FakeProjectDb fakeProjectDb = FakeProjectDb();
    final ProjectBloc projectBlocWithInbox =
        ProjectBloc(fakeProjectDb, isInboxVisible: true);
    expect(fakeProjectDb.isInboxVisible, true);
    await expectLater(
        projectBlocWithInbox.projects,
        emitsInOrder([
          [testProject1, testProject2, testProject3],
        ]));
  });

  test("Create Project in the project db test", () async {
    final FakeProjectDb fakeProjectDb = FakeProjectDb();

    final ProjectBloc projectBloc = ProjectBloc(fakeProjectDb);
    projectBloc.createProject(testProject4);

    expect(fakeProjectDb.lastProjectCreated, testProject4);
    await expectLater(
        projectBloc.projects,
        emitsInOrder([
          [testProject2, testProject3, testProject4],
        ]));
  });

  test("Update Project color palette  test", () async {
    final FakeProjectDb fakeProjectDb = FakeProjectDb();
    final ProjectBloc projectBloc = ProjectBloc(fakeProjectDb);
    expect(
        projectBloc.colorSelection,
        emitsInOrder(
          [
            colorsPalettes[0],
            colorsPalettes[1],
            colorsPalettes[2],
          ],
        ));
    projectBloc.updateColorSelection(colorsPalettes[0]);
    projectBloc.updateColorSelection(colorsPalettes[1]);
    projectBloc.updateColorSelection(colorsPalettes[2]);
  });

  test("Refresh Project list test", () async {
    final FakeProjectDb fakeProjectDb = FakeProjectDb();
    final ProjectBloc projectBloc = ProjectBloc(fakeProjectDb);
    await expectLater(
        projectBloc.projects,
        emitsInOrder([
          [testProject2, testProject3],
        ]));

    fakeProjectDb.insertOrReplace(testProject4);
    projectBloc.refresh();
    await expectLater(
        projectBloc.projects,
        emitsInOrder([
          [testProject2, testProject3, testProject4],
        ]));
  });
}
