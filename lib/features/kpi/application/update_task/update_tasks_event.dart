part of 'update_tasks_bloc.dart';

@freezed
class UpdateTasksEvent with _$UpdateTasksEvent {
  const factory UpdateTasksEvent.update() = _Update;
}
