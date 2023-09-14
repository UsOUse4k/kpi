import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kpi/features/kpi/domain/task.dart';

part 'task_rm.freezed.dart';
part 'task_rm.g.dart';

@freezed
class TaskRM with _$TaskRM {
  const TaskRM._();

  const factory TaskRM({
    @JsonKey(name: "indicator_to_mo_id") required int indicatorToMoId,
    @JsonKey(name: "parent_id") required int parentId,
    required int order,
    required String name,
  }) = _TaskRM;

  Task toDomain() {
    return Task(
      id: indicatorToMoId,
      parentId: parentId,
      order: order,
      name: name,
    );
  }

  factory TaskRM.fromJson(Map<String, dynamic> json) =>
      _$TaskRMFromJson(json);
}
