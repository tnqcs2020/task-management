import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:intl/intl.dart';
import 'package:task_management/data/data_testing.dart';
import 'package:task_management/models/task_model.dart';
import 'package:task_management/views/home/widgets/task_widget.dart';
import 'package:task_management/views/tasks/task_views.dart';

class DoneTask extends StatefulWidget {
  const DoneTask({super.key});

  @override
  State<DoneTask> createState() => _DoneTaskState();
}

class _DoneTaskState extends State<DoneTask> {
  Map<DateTime, List<TaskModel>> groupTasksByDate(List<TaskModel> tasks) {
    Map<DateTime, List<TaskModel>> grouped = {};
    for (var task in tasks) {
      if (task.deadline == null) continue;
      DateTime deadline = DateTime.parse(task.deadline!);
      DateTime dateOnly = DateTime(deadline.year, deadline.month, deadline.day);
      if (task.isFinished == 1) {
        if (!grouped.containsKey(dateOnly)) {
          grouped[dateOnly] = [];
        }

        grouped[dateOnly]!.add(task);
      }
    }
    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    final groupedTasks = groupTasksByDate(sampleTasks);
    final sortedDates =
        groupedTasks.keys.toList()..sort((a, b) => b.compareTo(a));
    return CustomScrollView(
      slivers:
          sortedDates.map((date) {
            final tasks = groupedTasks[date]!;
            return SliverStickyHeader(
              header: Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                alignment: Alignment.centerLeft,
                child: Text(
                  DateFormat.yMMMMd("vi").format(date),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final task = tasks[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) =>
                                    TaskView(task: task, isModified: false),
                          ),
                        );
                      },
                      child: TaskWidget(task: task),
                    ),
                  );
                }, childCount: tasks.length),
              ),
            );
          }).toList(),
    );
  }
}
