import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myappoint/screens/homePage/home_page.dart';

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
    return const MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xff58a2a7),
        body: HomePage(),
      ),
    );
  }
}
