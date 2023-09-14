import 'package:flutter/material.dart';
import 'package:kpi/features/kpi/domain/task.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final List<Widget> children;

  const TaskCard({
    super.key,
    required this.task,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return LongPressDraggable<int>(
      data: task.id,
      feedback: Material(
        elevation: 3,
        child: Container(
          padding: const EdgeInsets.all(10),
          width: 400,
          child: Text(
            task.name,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ),
      ),
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.all(10),
        child: Container(
          padding: const EdgeInsets.all(10),
          width: 400,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ...children,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
