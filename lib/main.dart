import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/bloc_provider.dart';
import 'package:flutter_app/pages/home/home.dart';
import 'package:flutter_app/pages/home/home_bloc.dart';
import 'package:flutter_app/pages/home/side_drawer.dart';

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
  AdaptiveHomePage();

  @override
  Widget build(BuildContext context) {
    bool isDesktop = MediaQuery.of(context).size.width > 600;
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
                child: HomePage(),
                flex: 5,
              ),
            ],
          )
        : HomePage();
  }
}
