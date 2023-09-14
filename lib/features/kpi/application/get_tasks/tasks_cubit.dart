import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kpi/features/common/domain/failures.dart';
import 'package:kpi/features/kpi/domain/i_task_repository.dart';
import 'package:kpi/features/kpi/domain/task.dart';

part 'tasks_state.dart';
part 'tasks_cubit.freezed.dart';

@singleton
class TasksCubit extends Cubit<TasksState> {
  final ITaskRepository _repository;

  TasksCubit(this._repository) : super(const TasksState.initial());

  Future<void> getTasks() async {
    emit(const TasksState.loadInProgress());
    final failureOrTasks = await _repository.getTasks();

    emit(
      failureOrTasks.fold(
        (f) => TasksState.loadFailure(f),
        (tasks) => TasksState.loadSuccess(tasks),
      ),
    );
  }

  void updateTask(Task task) async {
    state.maybeWhen(
      loadSuccess: (tasks) async {
        final data = tasks.map((e) {
          return e.id == task.id
              ? e.copyWith(
                  parentId: task.parentId,
                  order: task.order,
                )
              : e;
        }).toList();
        emit(TasksState.loadSuccess(data));
      },
      orElse: () {},
    );
  }
}
