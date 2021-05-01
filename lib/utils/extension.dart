import 'package:flutter/widgets.dart';
import 'package:flutter_app/bloc/bloc_provider.dart';
import 'package:flutter_app/pages/home/home_bloc.dart';

extension NavigatorExt on BuildContext {
  void safePop() {
    if (Navigator.of(this).canPop()) {
      Navigator.pop(this, true);
    }
  }

  bool isWiderScreen() {
    return MediaQuery.of(this).size.width > 600;
  }
}

extension BlocExt on BuildContext {
  T bloc<T>() {
    return BlocProvider.of(this) as T;
  }
}
