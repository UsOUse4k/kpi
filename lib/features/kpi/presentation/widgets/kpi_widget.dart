import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kpi/features/kpi/application/get_tasks/tasks_cubit.dart';
import 'package:kpi/features/kpi/domain/task.dart';
import 'package:kpi/features/kpi/presentation/widgets/task_card.dart';

class KPIWidget extends StatefulWidget {
  final List<Task> tasks;
  final int parentId;

  const KPIWidget({
    Key? key,
    required this.tasks,
    this.parentId = 0,
  }) : super(key: key);

  @override
  State<KPIWidget> createState() => _KPIWidgetState();
}

class _KPIWidgetState extends State<KPIWidget> {
  late List<Task> _tasks;

  @override
  void initState() {
    super.initState();
    _tasks = widget.tasks;
  }

  @override
  Widget build(BuildContext context) {
    final currentParentTask =
        _tasks.firstWhere((task) => task.parentId == widget.parentId);
    final columns = buildColumns(_tasks, currentParentTask.id);

    return DragTarget<int>(
      builder: (context, candidateData, rejectedData) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ReorderableListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: columns.length,
                  itemBuilder: (context, index) {
                    return columns[index];
                  },
                  onReorder: (oldIndex, newIndex) {
                    _handleTaskReorder(
                        currentParentTask.id, oldIndex, newIndex);
                  },
                ),
              ],
            ),
          ),
        );
      },
      onAccept: (taskId) {
        _handleTaskDrag(taskId, currentParentTask.id);
      },
      onWillAccept: (taskId) {
        return !_isSameParent(taskId!, currentParentTask.id);
      },
    );
  }

  List<Widget> buildColumns(List<Task> tasks, int parentTaskId) {
    final columns = <Widget>[];

    for (final task in tasks) {
      if (task.parentId == parentTaskId) {
        final nestedTasks = buildColumns(tasks, task.id);

        columns.add(
          buildTaskColumn(task, nestedTasks),
        );
      }
    }

    return columns;
  }

  Widget buildTaskColumn(Task task, List<Widget> nestedTasks) {
    return DragTarget<int>(
      key: ValueKey(task.id),
      builder: (context, candidateData, rejectedData) {
        return TaskCard(
          task: task,
          children: [
            if (nestedTasks.length > 1)
              ReorderableListView.builder(
                shrinkWrap: true,
                itemCount: nestedTasks.length,
                itemBuilder: (context, index) {
                  return nestedTasks[index];
                },
                onReorder: (oldIndex, newIndex) {
                  _handleTaskReorder(task.id, oldIndex, newIndex);
                },
              )
            else
              ...nestedTasks,
          ],
        );
      },
      onAccept: (taskId) {
        _handleTaskDrag(taskId, task.id);
      },
      onWillAccept: (taskId) {
        final taskToMove = _tasks.firstWhere((task) => task.id == taskId);

        return isTaskValidForDrop(taskToMove, task.id);
      },
    );
  }

  void _handleTaskDrag(int taskId, int newParentId) {
    setState(() {
      final taskToMove =
          _tasks.removeAt(_tasks.indexWhere((task) => task.id == taskId));
      final updatedTask = taskToMove.copyWith(
        parentId: newParentId,
        order: 1,
      );
      _tasks.insert(0, updatedTask);

      final newParentChildTasks =
          _tasks.where((task) => task.parentId == newParentId).toList();
      _updateChildTaskOrders(newParentChildTasks);

      final previousParentChildTasks =
          _tasks.where((task) => task.parentId == taskToMove.parentId).toList();
      _updateChildTaskOrders(previousParentChildTasks);

      context.read<TasksCubit>().updateTask(updatedTask);
    });
  }

  void _handleTaskReorder(int parentId, int oldOrder, int newOrder) {
    setState(() {
      final childTasks =
          _tasks.where((task) => task.parentId == parentId).toList();

      if (newOrder > oldOrder) {
        newOrder -= 1;
      }

      final taskToReorder = childTasks[oldOrder];
      final taskAtNewOrder = childTasks[newOrder];

      final updatedTaskToReorder =
          taskToReorder.copyWith(order: taskAtNewOrder.order);

      childTasks.removeAt(oldOrder);
      childTasks.insert(newOrder, updatedTaskToReorder);

      _tasks.removeWhere((task) => task.id == updatedTaskToReorder.id);
      _tasks.add(updatedTaskToReorder);

      _updateChildTaskOrders(childTasks);
    });
  }

  void _updateChildTaskOrders(List<Task> childrenToUpdate) {
    for (int i = 0; i < childrenToUpdate.length; i++) {
      final child = childrenToUpdate[i];
      final updatedChild = child.copyWith(order: i + 1);
      final index = _tasks.indexWhere((task) => task.id == child.id);
      _tasks[index] = updatedChild;

      context.read<TasksCubit>().updateTask(updatedChild);
    }

    _tasks.sort((a, b) => a.order.compareTo(b.order));
  }

  bool _isSameParent(int taskId, int newParentId) {
    final taskToMove = _tasks.firstWhere((task) => task.id == taskId);
    return taskToMove.parentId == newParentId;
  }

  bool _isDescendant(int taskId, int parentId) {
    int parent = parentId;
    while (parent != 0) {
      if (parent == taskId) {
        return true;
      }
      parent = _tasks.firstWhere((task) => task.id == parent).parentId;
    }
    return false;
  }

  bool isTaskValidForDrop(Task taskToMove, int newParentId) {
    final isNotSelf = taskToMove.id != newParentId;
    final isNotSameParent = !_isSameParent(taskToMove.id, newParentId);
    final isNotDescendant = !_isDescendant(taskToMove.id, newParentId);
    return isNotSelf && isNotSameParent && isNotDescendant;
  }
}
