import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_management/utils/auth_services.dart';
import 'package:task_management/views/home/widgets/task_widget.dart';
import 'package:task_management/views/tasks/task_views.dart';

class OverdueTask extends StatefulWidget {
  const OverdueTask({super.key});

  @override
  State<OverdueTask> createState() => _OverdueTaskState();
}

class _OverdueTaskState extends State<OverdueTask> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () =>
          AuthServices.userCtrl.setGroupDateOverdue().isNotEmpty
              ? CustomScrollView(
                slivers:
                    AuthServices.userCtrl.setGroupDateOverdue().map((date) {
                      final tasks =
                          AuthServices.userCtrl.setTasksByDateOverdue()[date]!;
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
                          delegate: SliverChildBuilderDelegate((
                            context,
                            index,
                          ) {
                            final task = tasks[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => TaskView(
                                            task: task,
                                            isModified: false,
                                          ),
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
              )
              : Padding(
                padding: const EdgeInsets.only(top: 200),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 150,
                      height: 150,
                      child: SvgPicture.asset('assets/images/no-data.svg'),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Không có dữ liệu!",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
    );
  }
}
