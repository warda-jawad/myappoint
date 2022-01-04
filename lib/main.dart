import 'package:flutter/material.dart';
import 'package:myappoint/app/app.dart';
import 'package:myappoint/injection.dart';

Future<void> main() async {
  await initGetIt();
  runApp(AppPage());
}
