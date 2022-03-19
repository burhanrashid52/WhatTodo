import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

extension WidgetWrapperExtension on Widget {
  Widget wrapWithMaterialApp() {
    return MaterialApp(
      home: this,
    );
  }

  Widget wrapToSizeForGoldenTest(Size size) {
    return Center(
      child: SizedBox.fromSize(
        size: size,
        child: RepaintBoundary(
          child: this,
        ),
      ),
    );
  }
}

extension WidgetTesterExtension on WidgetTester {
  Future<int> tapAndSettle(Finder finder) async {
    await tap(finder);
    return pumpAndSettle();
  }
}
