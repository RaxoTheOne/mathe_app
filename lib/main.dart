import 'package:flutter/material.dart';
import 'package:mathe_app/presentation/math_task_home_page.dart';


void main() {
  runApp(MathTaskGeneratorApp());
}

class MathTaskGeneratorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mathe Aufgaben Generator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MathTaskHomePage(),
    );
  }
}