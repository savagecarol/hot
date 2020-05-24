import 'package:flutter/material.dart';
import 'package:hot/splashscreen.dart';
import './src/pages/index.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'hot',
      theme: ThemeData.dark(),
//        primarySwatch: Colors.blue,
//      ),
      home: Splasher(),
    );
  }
}
