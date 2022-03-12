import 'package:flutter/material.dart';

extension WidgetWrapperExtension on Widget {
  Widget wrapWithMaterialApp() {
    return MaterialApp(
      home: this,
    );
  }
}
