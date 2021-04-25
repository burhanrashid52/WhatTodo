import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/bloc_provider.dart';
import 'package:flutter_app/pages/about/about_us.dart';
import 'package:flutter_app/pages/home/home.dart';
import 'package:flutter_app/pages/home/home_bloc.dart';
import 'package:flutter_app/pages/home/side_drawer.dart';
import 'package:flutter_app/utils/extension.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            accentColor: Colors.orange, primaryColor: const Color(0xFFDE4435)),
        home: BlocProvider(
          bloc: HomeBloc(),
          child: AdaptiveHomePage(),
        ));
  }
}

class AdaptiveHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isDesktop = context.isDesktop();
    HomeBloc homeBloc = BlocProvider.of(context);
    return isDesktop
        ? Row(
            children: [
              Expanded(
                child: SideDrawer(),
                flex: 2,
              ),
              SizedBox(
                width: 0.5,
              ),
              Expanded(
                child: StreamBuilder<SCREEN?>(
                    stream: homeBloc.screens,
                    builder: (context, snapshot) {
                      if (snapshot.data != null) {
                        // ignore: missing_enum_constant_in_switch
                        switch (snapshot.data) {
                          case SCREEN.ABOUT:
                            return AboutUsScreen();
                          case SCREEN.ADD_TASK:
                          // TODO: Handle this case.
                            break;
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
