import 'package:flutter/material.dart';
import 'package:mathe_app/presentation/math_task_home_page.dart';


void main() {
  runApp(MathTaskGeneratorApp());
}

class MathTaskGeneratorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mathe Aufgaben Generator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.lightBlue,
      ),
      home: MathTaskHomePage(),
    );
  }
}