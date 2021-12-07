import 'package:flutter/material.dart';

class AppPage extends StatefulWidget {
  const AppPage({
    Key? key,
  }) : super(key: key);

  @override
  _AppPageState createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("My Appointment"),
        ),
        body: Container(
          child: Text(""),
        ),
      ),
    );
  }
}
