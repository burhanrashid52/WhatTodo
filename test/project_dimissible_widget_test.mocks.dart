// Mocks generated by Mockito 5.3.2 from annotations
// in flutter_app/test/project_dimissible_widget_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:flutter_app/pages/projects/project.dart' as _i4;
import 'package:flutter_app/pages/projects/project_db.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [ProjectDB].
///
/// See the documentation for Mockito's code generation for more information.
class MockProjectDB extends _i1.Mock implements _i2.ProjectDB {
  MockProjectDB() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<bool> projectExists(_i4.Project? project) => (super.noSuchMethod(
        Invocation.method(
          #projectExists,
          [project],
        ),
        returnValue: _i3.Future<bool>.value(false),
      ) as _i3.Future<bool>);
  @override
  _i3.Future<List<_i4.Project>> getProjects({bool? isInboxVisible = true}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getProjects,
          [],
          {#isInboxVisible: isInboxVisible},
        ),
        returnValue: _i3.Future<List<_i4.Project>>.value(<_i4.Project>[]),
      ) as _i3.Future<List<_i4.Project>>);
  @override
  _i3.Future<dynamic> insertOrReplace(_i4.Project? project) =>
      (super.noSuchMethod(
        Invocation.method(
          #insertOrReplace,
          [project],
        ),
        returnValue: _i3.Future<dynamic>.value(),
      ) as _i3.Future<dynamic>);
  @override
  _i3.Future<dynamic> deleteProject(int? projectID) => (super.noSuchMethod(
        Invocation.method(
          #deleteProject,
          [projectID],
        ),
        returnValue: _i3.Future<dynamic>.value(),
      ) as _i3.Future<dynamic>);
}