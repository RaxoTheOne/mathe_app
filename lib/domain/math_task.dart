class MathTask {
  final int num1;
  final int num2;
  final String operation;
  double? answer;

  MathTask({
    required this.num1,
    required this.num2,
    required this.operation,
    this.answer,
  }) {
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
        answer = num1 / num2;
        break;
    }
  }

  String getOperationSymbol() {
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

  String getTaskString() {
    return '$num1 ${getOperationSymbol()} $num2';
  }

  bool checkAnswer(double userAnswer) {
    return userAnswer == answer;
  }
}
