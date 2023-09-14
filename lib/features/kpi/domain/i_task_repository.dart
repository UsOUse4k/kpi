import 'package:dartz/dartz.dart' hide Task;
import 'package:kpi/features/common/domain/failures.dart';
import 'package:kpi/features/kpi/domain/task.dart';

abstract class ITaskRepository {
  Future<Either<Failure, List<Task>>> getTasks();

  Future<Either<Failure, void>> updateTask(Task updatedTask);
}
