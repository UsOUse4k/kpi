part of 'tasks_cubit.dart';

@freezed
class TasksState with _$TasksState {
  const factory TasksState.initial() = _Initial;
  const factory TasksState.loadInProgress() = _LoadInProgress;
  const factory TasksState.loadSuccess(List<Task> tasks) = _LoadSuccess;
  const factory TasksState.loadFailure(Failure failure) = _LoadFailure;
}
