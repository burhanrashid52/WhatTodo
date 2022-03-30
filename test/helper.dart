import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

extension WidgetWrapperExtension on Widget {
  Widget wrapWithMaterialApp({List<NavigatorObserver> navigatorObservers}) {
    return MaterialApp(
      home: this,
      navigatorObservers: [...?navigatorObservers],
    );
  }

  Widget wrapWithProviderScope({List<Override> overrides}) {
    return ProviderScope(
      child: this,
      overrides: [...?overrides],
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
