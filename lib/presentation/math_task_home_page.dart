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
  final List<String> _history = [];
  String _resultMessage = '';
  final _formKey = GlobalKey<FormState>();

  void _generateTask() {
    setState(() {
      _currentTask = MathTaskService.generateTask(_operation);
      _controller.clear();
      _resultMessage = '';
    });
  }

  void _checkAnswer() {
    if (_formKey.currentState?.validate() != true) {
      return;
    }

    final userAnswer = double.parse(_controller.text);
    final isCorrect = _currentTask!.checkAnswer(userAnswer);

    setState(() {
      _resultMessage = isCorrect ? 'Richtig!' : 'Falsch! Die richtige Antwort ist ${_currentTask!.answer}.';
      _history.insert(0, '${_currentTask!.getTaskString()} = $userAnswer (${isCorrect ? 'Richtig' : 'Falsch'})');
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mathe Aufgaben Generator',
        style: TextStyle(fontFamily: 'PermanentMarker'),
        ),
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
                style: TextStyle(fontSize: 24, fontFamily: 'PermanentMarker'),
              ),
            Form(
              key: _formKey,
              child: TextFormField(
                controller: _controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Deine Antwort',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Bitte gib eine gültige Zahl ein.';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Bitte gib eine gültige Zahl ein.';
                  }
                  return null;
                },
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
            Expanded(
              child: ListView.builder(
                itemCount: _history.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      _history[index],
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'PermanentMarker', // Benutzerdefinierte Schriftart
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}