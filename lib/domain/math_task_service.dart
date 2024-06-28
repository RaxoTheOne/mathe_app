import 'dart:math';
import 'math_task.dart';

class MathTaskService {
  static MathTask generateTask(String operation) {
    final random = Random();
    int num1 = random.nextInt(100) + 1;
    int num2 = random.nextInt(100) + 1;
    double answer;

    switch (operation) {
      case 'Addition':
        answer = (num1 + num2).toDouble();
        break;
      case 'Subtraktion':
        answer = (num1 - num2).toDouble();
        break;
      case 'Multiplikation':
        answer = (num1 * num2).toDouble();
        break;
      case 'Division':
        num1 = num1 * num2;
        answer = num1 / num2;
        break;
      default:
        throw Exception('Unknown operation');
    }

    return MathTask(
      num1: num1,
      num2: num2,
      answer: answer,
      operation: operation,
    );
  }
}