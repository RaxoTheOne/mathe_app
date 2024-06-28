import 'package:flutter/material.dart';
import 'package:mathe_app/domain/math_task.dart';
import 'package:mathe_app/domain/use_cases/generate_task_service.dart';
import 'package:mathe_app/domain/use_cases/check_answer_use_case.dart';

class MathTaskViewModel extends ChangeNotifier {
  final GenerateTaskUseCase _generateTaskUseCase;
  final CheckAnswerUseCase _checkAnswerUseCase;

  MathTaskViewModel(this._generateTaskUseCase, this._checkAnswerUseCase);

  String _operation = 'Addition';
  MathTask? _currentTask;
  String _resultMessage = '';
  final List<String> _history = [];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();

  String get operation => _operation;
  MathTask? get currentTask => _currentTask;
  String get resultMessage => _resultMessage;
  List<String> get history => _history;
  GlobalKey<FormState> get formKey => _formKey;
  TextEditingController get controller => _controller;

  void setOperation(String operation) {
    _operation = operation;
    notifyListeners();
  }

  void generateTask() {
    _currentTask = _generateTaskUseCase(_operation);
    _resultMessage = '';
    _controller.clear();
    notifyListeners();
  }

  void checkAnswer(String userAnswer) {
    final double? answer = double.tryParse(userAnswer);
    if (answer == null) {
      _resultMessage = 'Bitte gib eine gültige Zahl ein.';
      notifyListeners();
      return;
    }

    _resultMessage = _checkAnswerUseCase(_currentTask!, answer);
    _history.insert(0, '${_currentTask!.getTaskString()} = $answer (${_resultMessage == 'Richtig!' ? 'Richtig' : 'Falsch'})');
    _controller.clear();
    notifyListeners();
  }
}