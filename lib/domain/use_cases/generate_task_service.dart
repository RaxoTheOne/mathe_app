import 'package:mathe_app/domain/math_task.dart';
import 'package:mathe_app/domain/math_task_service.dart';

class GenerateTaskUseCase {
  MathTask call(String operation) {
    return MathTaskService.generateTask(operation);
  }
}
