import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myappoint/screens/homePage/home_page.dart';
import 'package:showcaseview/showcaseview.dart';

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
      theme: ThemeData(
        primaryColor: const Color(0xff906269),
        textTheme: const TextTheme(
          bodyText1: TextStyle(
            fontSize: 30,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.none,
          ),
          bodyText2: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.normal,
            decoration: TextDecoration.none,
          ),
        ),
      ),
      home: Scaffold(
        backgroundColor: const Color(0xff58a2a7),
        body: ShowCaseWidget(
          onStart: (index, key) {
            log('onStart: $index, $key');
          },
          onComplete: (index, key) {
            log('onComplete: $index, $key');
          },
          blurValue: 1,
          builder: Builder(builder: (context) => HomePage()),
          autoPlay: false,
          autoPlayDelay: const Duration(seconds: 3),
          autoPlayLockEnable: false,
        ),
      ),
    );
  }
}
