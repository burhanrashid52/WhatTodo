import 'package:flutter/widgets.dart';

extension NavigatorExt on BuildContext {
  void safePop() {
    if (Navigator.of(this).canPop()) {
      Navigator.pop(this, true);
    }
  }

  bool isDesktop() {
    return MediaQuery.of(this).size.width > 600;
  }
}
