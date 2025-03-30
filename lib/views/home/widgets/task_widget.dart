import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:task_management/models/task_model.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({super.key, required this.task});
  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      child: Container(
        height: 80,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              offset: Offset(0, 9),
              blurRadius: 20,
              spreadRadius: 1,
            ),
          ],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: 25,
              width: 25,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: task.isFinished == 1 ? Colors.red : Colors.green,
                  width: 4,
                ), // Border.all
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  task.title!,
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
