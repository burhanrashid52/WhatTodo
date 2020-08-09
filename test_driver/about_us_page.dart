import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/pages/about/about_us.dart';
import 'package:flutter_driver/driver_extension.dart';

Future<void> main() async {
  // This line enables the extension.
  enableFlutterDriverExtension();

  // Call the `main()` function of the app, or call `runApp` with
  // any widget you are interested in testing.
  runApp(MaterialApp(
    home: AboutUsScreen(),
  ));
}
