part of 'update_tasks_bloc.dart';

@freezed
class UpdateTasksState with _$UpdateTasksState {
  const factory UpdateTasksState.initial() = _Initial;
  const factory UpdateTasksState.updating() = _Updating;
  const factory UpdateTasksState.updated() = _Updated;
}
