import 'package:flutter/material.dart';
import 'package:mathe_app/domain/use_cases/generate_task_service.dart';
import 'package:provider/provider.dart';
import 'package:mathe_app/ui/view_models/math_task_view_model.dart';
import 'package:mathe_app/domain/use_cases/check_answer_use_case.dart';
import 'package:mathe_app/ui/math_task_home_page.dart';

void main() {
  runApp(MathTaskGeneratorApp());
}

class MathTaskGeneratorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MathTaskViewModel(
            GenerateTaskUseCase(),
            CheckAnswerUseCase(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Mathe Aufgaben Generator',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.lightBlue,
        ),
        home: MathTaskHomePage(),
      ),
    );
  }
}