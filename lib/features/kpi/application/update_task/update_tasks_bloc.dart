import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kpi/features/kpi/application/get_tasks/tasks_cubit.dart';
import 'package:kpi/features/kpi/domain/i_task_repository.dart';
import 'package:kpi/features/kpi/domain/task.dart';

part 'update_tasks_event.dart';
part 'update_tasks_state.dart';
part 'update_tasks_bloc.freezed.dart';

@singleton
class UpdateTasksBloc extends Bloc<UpdateTasksEvent, UpdateTasksState> {
  final TasksCubit _cubit;
  final ITaskRepository _repository;
  late StreamSubscription<TasksState> _subscription;
  late TasksState _previousCubitState;
  final _updateQueue = <Task>[];
  Timer? _updateTimer;

  UpdateTasksBloc(this._cubit, this._repository)
      : super(const UpdateTasksState.initial()) {
    _previousCubitState = _cubit.state;

    _subscription = _cubit.stream.listen(_handleCubitStateChange);

    on<UpdateTasksEvent>(
      _handleUpdateTasksEvent,
      transformer: sequential(),
    );
  }

  void _handleCubitStateChange(TasksState currentState) {
    if (currentState != _previousCubitState) {
      final updatedTask = _findUpdatedTask(currentState);

      if (updatedTask != null) {
        _addToUpdateQueue(updatedTask);
        _resetUpdateTimer();
      }
    }

    _previousCubitState = currentState;
  }

  Task? _findUpdatedTask(TasksState currentState) {
    return currentState.maybeMap(
      loadSuccess: (currentState) {
        return _previousCubitState.maybeMap(
          loadSuccess: (previousState) {
            final Map<int, Task> previousTasksMap =
                Map.fromIterable(previousState.tasks, key: (task) => task.id);

            for (final currentTask in currentState.tasks) {
              final previousTask = previousTasksMap[currentTask.id];

              final isUpdatedTask =
                  previousTask != null && currentTask != previousTask;

              if (isUpdatedTask) {
                return currentTask;
              }
            }

            return null;
          },
          orElse: () => null,
        );
      },
      orElse: () => null,
    );
  }

  void _handleUpdateTasksEvent(
      UpdateTasksEvent event, Emitter<UpdateTasksState> emit) async {
    await event.map(
      update: (event) async {
        emit(const UpdateTasksState.updating());

        await _processUpdateQueue();

        emit(const UpdateTasksState.updated());
      },
    );
  }

  void _addToUpdateQueue(Task taskToUpdate) {
    _updateQueue.add(taskToUpdate);
  }

  void _resetUpdateTimer() {
    _updateTimer?.cancel();
    _updateTimer = Timer(const Duration(seconds: 1),
        _executeUpdates); // Настроить "duration" в экземпляре "Timer" значение как необходимо
  }

  void _executeUpdates() {
    add(const UpdateTasksEvent.update());
  }

  Future<void> _processUpdateQueue() async {
    while (_updateQueue.isNotEmpty) {
      final taskToUpdate = _updateQueue.removeAt(0);
      await _repository.updateTask(taskToUpdate);
    }
  }

  @override
  Future<void> close() async {
    _updateTimer?.cancel();
    await _subscription.cancel();

    return super.close();
  }
}
