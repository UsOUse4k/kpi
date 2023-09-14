import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kpi/features/kpi/application/get_tasks/tasks_cubit.dart';
import 'package:kpi/features/kpi/domain/task.dart';
import 'package:kpi/features/kpi/presentation/widgets/kpi_widget.dart';

class KPIPage extends StatelessWidget {
  const KPIPage({super.key});

  static const int _parentId = 0;

  List<Task> generateTasks(List<Task> tasks) {
    final Map<int, Task> tasksById = {};

    for (final task in tasks) {
      tasksById[task.id] = task;

      if (!tasksById.containsKey(task.parentId)) {
        final parentTask = Task(
          id: task.parentId,
          parentId: _parentId,
          order: 1,
          name: 'Parent Task',
        );

        tasksById[parentTask.id] = parentTask;
      }
    }

    tasksById.remove(0);

    return tasksById.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<TasksCubit, TasksState>(
          builder: (context, state) {
            return state.maybeMap(
              loadSuccess: (state) {
                final tasks = generateTasks(state.tasks);

                return KPIWidget(
                  tasks: tasks,
                  parentId: _parentId,
                );
              },
              orElse: () {
                return const SizedBox.shrink();
              },
            );
          },
        ),
      ),
    );
  }
}
