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
