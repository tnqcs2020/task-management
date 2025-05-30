import 'package:flutter/material.dart';
import 'package:task_management/utils/app_colors.dart';
import 'package:task_management/views/tasks/task_views.dart';

class FloatBtn extends StatelessWidget {
  const FloatBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 25, bottom: 35),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TaskView(isModified: true)),
          );
        },
        child: Material(
          borderRadius: BorderRadius.circular(35),
          elevation: 2,
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(35),
            ),
            child: Center(child: Icon(Icons.add, color: Colors.white)),
          ),
        ),
      ),
    );
  }
}
