import 'package:flutter/material.dart';
import 'package:mathe_app/domain/math_task.dart';
import 'package:mathe_app/domain/math_task_service.dart';

class MathTaskHomePage extends StatefulWidget {
  @override
  _MathTaskHomePageState createState() => _MathTaskHomePageState();
}

class _MathTaskHomePageState extends State<MathTaskHomePage> {
  String _operation = 'Addition';
  MathTask? _currentTask;
  final TextEditingController _controller = TextEditingController();
  String _resultMessage = '';

  void _generateTask() {
    setState(() {
      _currentTask = MathTaskService.generateTask(_operation);
    });
  }

  void _checkAnswer() {
    final userAnswer = double.tryParse(_controller.text);
    if (userAnswer == null) {
      setState(() {
        _resultMessage = 'Bitte gib eine gültige Zahl ein.';
      });
      return;
    }

    setState(() {
      if (_currentTask != null && _currentTask!.checkAnswer(userAnswer)) {
        _resultMessage = 'Richtig!';
      } else {
        _resultMessage = 'Falsch! Die richtige Antwort ist ${_currentTask!.answer}.';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mathe Aufgaben Generator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              value: _operation,
              onChanged: (String? newValue) {
                setState(() {
                  _operation = newValue!;
                });
              },
              items: <String>[
                'Addition',
                'Subtraktion',
                'Multiplikation',
                'Division'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            ElevatedButton(
              onPressed: _generateTask,
              child: Text('Aufgabe Generieren'),
            ),
            if (_currentTask != null)
              Text(
                _currentTask!.getTaskString(),
                style: TextStyle(fontSize: 24),
              ),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Deine Antwort',
              ),
            ),
            ElevatedButton(
              onPressed: _checkAnswer,
              child: Text('Antwort Überprüfen'),
            ),
            Text(
              _resultMessage,
              style: TextStyle(fontSize: 18, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}