import 'package:flutter/material.dart';

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
