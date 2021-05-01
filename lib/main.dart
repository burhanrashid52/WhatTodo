import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/bloc_provider.dart';
import 'package:flutter_app/pages/about/about_us.dart';
import 'package:flutter_app/pages/home/home.dart';
import 'package:flutter_app/pages/home/home_bloc.dart';
import 'package:flutter_app/pages/home/side_drawer.dart';
import 'package:flutter_app/pages/projects/project_widget.dart';
import 'package:flutter_app/pages/tasks/add_task.dart';
import 'package:flutter_app/pages/tasks/task_completed/task_complted.dart';
import 'package:flutter_app/utils/extension.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          accentColor: Colors.orange,
          primaryColor: const Color(0xFFDE4435),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: BlocProvider(
          bloc: HomeBloc(),
          child: AdaptiveHomePage(),
        ));
  }
}

class AdaptiveHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isWiderScreen = context.isWiderScreen();
    HomeBloc homeBloc = BlocProvider.of(context);
    return isWiderScreen
        ? Row(
            children: [
              Expanded(
                child: StreamBuilder<SCREEN>(
                    stream: homeBloc.screens,
                    builder: (context, snapshot) {
                      return SideDrawer();
                    }),
                flex: 2,
              ),
              SizedBox(
                width: 0.5,
              ),
              Expanded(
                child: StreamBuilder<SCREEN>(
                    stream: homeBloc.screens,
                    builder: (context, snapshot) {
                      if (snapshot.data != null) {
                        // ignore: missing_enum_constant_in_switch
                        switch (snapshot.data) {
                          case SCREEN.ABOUT:
                            return AboutUsScreen();
                          case SCREEN.ADD_TASK:
                            return AddTaskProvider();
                          case SCREEN.COMPLETED_TASK:
                            return TaskCompletedPage();
                          case SCREEN.ADD_PROJECT:
                            return AddProjectPage();
                          case SCREEN.HOME:
                            return HomePage();
                        }
                      }
                      return HomePage();
                    }),
                flex: 5,
              )
            ],
          )
        : HomePage();
  }
}
