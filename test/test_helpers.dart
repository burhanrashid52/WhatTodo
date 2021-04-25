import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/bloc/bloc_provider.dart';
import 'package:flutter_app/pages/home/home_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

extension TestWrapMaterialApp on Widget {
  Widget wrapMaterialApp() {
    return MaterialApp(
      home: this,
    );
  }

  Widget wrapMaterialAppWithBloc<T extends BlocBase>(T myBloc) {
    return MaterialApp(
      home: BlocProvider(
        bloc: HomeBloc(),
        child: BlocProvider(bloc: myBloc, child: this),
      ),
    );
  }

  Widget wrapWithScaffold() {
    return MaterialApp(
      home: Scaffold(
        body: this,
      ),
    );
  }

  Widget wrapScaffoldWithBloc<T extends BlocBase>(T myBloc) {
    return MaterialApp(
      home: Scaffold(
        body: BlocProvider(bloc: myBloc, child: this),
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

extension TestWidgetFinder<T> on WidgetTester {
  T findWidgetByKey<T extends Widget>(String key) {
    var findKey = find.byKey(ValueKey(key));
    return this.firstWidget(findKey) as T;
  }
}
