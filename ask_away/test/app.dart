import 'package:flutter/material.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:ask_away/main.dart' as app;

Future<void> main() async {
// This line enables the extension.
  enableFlutterDriverExtension();
  runApp(app.MyApp());
}