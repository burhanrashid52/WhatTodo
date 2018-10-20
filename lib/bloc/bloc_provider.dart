import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/task_bloc.dart';

abstract class BlocBase {
  void dispose();
}

class BlocProvider<T extends BlocBase> extends StatefulWidget {
  BlocProvider({
    Key key,
    @required this.child,
    @required this.bloc,
  }) : super(key: key);

  final T bloc;
  final Widget child;

  @override
  _BlocProviderState<T> createState() => _BlocProviderState<T>();

  static T of<T extends BlocBase>(BuildContext context) {
    final type = _typeOf<BlocProvider<T>>();
    BlocProvider<T> provider = context.ancestorWidgetOfExactType(type);
    return provider.bloc;
  }

  static Type _typeOf<T>() => T;
}

class _BlocProviderState<T> extends State<BlocProvider<BlocBase>> {
  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

/*class BlocProvider<T extends BlocBase> extends InheritedWidget {
  final T bloc;
  final Widget child;

  BlocProvider({
    Key key,
    @required this.child,
    @required this.bloc,
  }) : super(key: key);

  static T of<T extends BlocBase>(BuildContext context) {
    final type = _typeOf<BlocProvider<T>>();
    return (context.inheritFromWidgetOfExactType(type) as BlocProvider).bloc;
  }

  static Type _typeOf<T>() => T;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }
}*/

/*class TaskProvider extends InheritedWidget {
  final TasksBloc bloc;
  final Widget child;

  TaskProvider({
    Key key,
    @required this.child,
    @required this.bloc,
  }) : super(key: key, child: child);

  static TasksBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(TaskProvider) as TaskProvider)
        .bloc;
  }

  static Type _typeOf<T>() => T;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }
}*/
