import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MathTaskGeneratorApp());
}

class MathTaskGeneratorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Math Task Generator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MathTaskHomePage(),
    );
  }
}

class MathTaskHomePage extends StatefulWidget {
  @override
  _MathTaskHomePageState createState() => _MathTaskHomePageState();
}

class _MathTaskHomePageState extends State<MathTaskHomePage> {
  String _operation = 'Addition';
  int? _num1;
  int? _num2;
  double? _answer;
  final TextEditingController _controller = TextEditingController();
  String _resultMessage = '';

  void _generateTask() {
    final random = Random();
    _num1 = random.nextInt(100) + 1;
    _num2 = random.nextInt(100) + 1;

    setState(() {
      switch (_operation) {
        case 'Addition':
          _answer = (_num1! + _num2!).toDouble();
          break;
        case 'Subtraktion':
          _answer = (_num1! - _num2!).toDouble();
          break;
        case 'Multiplikation':
          _answer = (_num1! * _num2!).toDouble();
          break;
        case 'Division':
          _num1 = _num1! * _num2!;
          _answer = _num1! / _num2!;
          break;
      }
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
      if (userAnswer == _answer) {
        _resultMessage = 'Richtig!';
      } else {
        _resultMessage = 'Falsch! Die richtige Antwort ist $_answer.';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Math Task Generator'),
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
            if (_num1 != null && _num2 != null)
              Text(
                '$_num1 ${_operationSymbol(_operation)} $_num2',
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

  String _operationSymbol(String operation) {
    switch (operation) {
      case 'Addition':
        return '+';
      case 'Subtraktion':
        return '-';
      case 'Multiplikation':
        return '*';
      case 'Division':
        return '/';
      default:
        return '';
    }
  }
}
