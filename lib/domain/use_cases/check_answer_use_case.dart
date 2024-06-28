import 'package:mathe_app/domain/math_task.dart';

class CheckAnswerUseCase {
  String call(MathTask task, double userAnswer) {
    final isCorrect = task.checkAnswer(userAnswer);
    return isCorrect ? 'Richtig!' : 'Falsch! Die richtige Antwort ist ${task.answer}.';
  }
}