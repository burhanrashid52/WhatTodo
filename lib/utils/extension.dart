import 'package:flutter/material.dart';
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

  adaptiveNavigate(SCREEN screen, Widget widget) async {
    final homeBloc = bloc<HomeBloc>();
    if (isWiderScreen()) {
      homeBloc.updateScreen(screen);
    } else {
      await Navigator.push(
        this,
        MaterialPageRoute<bool>(builder: (context) => widget),
      );
    }
  }
}

extension BlocExt on BuildContext {
  T bloc<T extends BlocBase>() {
    return BlocProvider.of(this);
  }
}
