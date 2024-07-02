import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mathe_app/ui/view_models/math_task_view_model.dart';

class MathTaskHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MathTaskViewModel>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text(
          'Mathe Aufgaben Generator',
          style: TextStyle(fontFamily: 'PermanentMarker'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              value: viewModel.operation,
              onChanged: (String? newValue) {
                viewModel.setOperation(newValue!);
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
              onPressed: viewModel.generateTask,
              child: Text('Aufgabe Generieren'),
            ),
            if (viewModel.currentTask != null)
              AnimatedSwitcher(
                duration: Duration(seconds: 1),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return ScaleTransition(
                    scale: animation,
                    child: child,
                  );
                },
                child: Column(
                  key: ValueKey<String>(viewModel.currentTask!.getTaskString()),
                  children: [
                    Text(
                      viewModel.currentTask!.num1.toString(),
                      style: TextStyle(fontSize: 48, fontFamily: 'PermanentMarker'),
                    ),
                    Text(
                      viewModel.currentTask!.getOperationSymbol(),
                      style: TextStyle(fontSize: 48, fontFamily: 'PermanentMarker'),
                    ),
                    Text(
                      viewModel.currentTask!.num2.toString(),
                      style: TextStyle(fontSize: 48, fontFamily: 'PermanentMarker'),
                    ),
                  ],
                ),
              ),
            Form(
              key: viewModel.formKey,
              child: TextFormField(
                controller: viewModel.controller,
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
              onPressed: () {
                if (viewModel.formKey.currentState?.validate() ?? false) {
                  viewModel.checkAnswer(viewModel.controller.text);
                }
              },
              child: Text('Antwort Überprüfen'),
            ),
            Text(
              viewModel.resultMessage,
              style: TextStyle(fontSize: 18, color: Colors.red),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: viewModel.history.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      viewModel.history[index],
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'PermanentMarker',
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
