import 'package:flutter/material.dart';
import 'package:task_management/utils/app_colors.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to Task View to see Task Details
      },
      child: AnimatedContainer(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.primaryColor.withValues(alpha: .1),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .1),
              offset: Offset(0, 4),
              blurRadius: 10,
            ),
          ],
        ),
        duration: Duration(milliseconds: 600),
        child: ListTile(
          // Check Icon
          leading: GestureDetector(
            onTap: () {},
            child: AnimatedContainer(
              duration: Duration(milliseconds: 600),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey, width: .8),
              ),
              child: Icon(Icons.check, color: Colors.white),
            ),
          ),
          // Task Title
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5, top: 3),
            child: Text(
              "Done",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                // decoration: TextDecoration.lineThrough
              ),
            ),
          ),
          // Task Description
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Description",
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w300,
                  // decoration: TextDecoration.lineThrough
                ),
              ),

              // Date of Task
              Align(
                alignment: Alignment.centerRight,

                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10, top: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Date",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      Text(
                        "SubDate",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
