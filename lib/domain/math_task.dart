class MathTask {
  final int num1;
  final int num2;
  final double answer;
  final String operation;

  MathTask({
    required this.num1,
    required this.num2,
    required this.answer,
    required this.operation,
  });

  String getTaskString() {
    return '$num1 ${_operationSymbol(operation)} $num2';
  }

  bool checkAnswer(double userAnswer) {
    return userAnswer == answer;
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