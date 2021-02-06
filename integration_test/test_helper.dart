import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

extension TestFinder on CommonFinders {
  Finder byValueKey(String key) {
    return find.byKey(ValueKey(key));
  }
}
