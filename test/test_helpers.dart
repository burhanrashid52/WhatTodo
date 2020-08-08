import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

extension TestWrapMaterialApp on Widget {
  Widget wrapMaterialApp() {
    return MaterialApp(
      home: this,
    );
  }

  Widget wrapScaffold() {
    return MaterialApp(
      home: Scaffold(
        body: this,
      ),
    );
  }
}

extension TestContainer on Container {
  Color getBorderLeftColor() {
    final boxDecoration = this.decoration as BoxDecoration;
    final border = boxDecoration.border as Border;
    return border.left.color;
  }
}
