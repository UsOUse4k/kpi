import 'package:freezed_annotation/freezed_annotation.dart';

part 'task.freezed.dart';

@freezed
class Task with _$Task {
  const Task._();

  const factory Task({
    required int id,
    required int parentId,
    required int order,
    required String name,
  }) = _Task;
}
