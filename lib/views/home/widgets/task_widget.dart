import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_management/models/task_model.dart';
import 'package:task_management/views/home/components/in_progress_circle.dart';
import 'package:task_management/views/tasks/task_views.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({super.key, required this.task});
  final TaskModel task;

  double percentWork(List<WorkModel> listWork) {
    int done = 0;
    listWork.forEach((element) {
      if (element.isFinished! == 1) {
        done += 1;
      }
    });
    return done / listWork.length;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
            margin: EdgeInsets.symmetric(horizontal: 25),
            height: 50,
            width: 30,
            child: InProgressCircle(
              percent: percentWork(task.listWork!),
              isFinished: task.isFinished!,
            ),
          ),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  task.title!,
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 5),
            width: 50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // IconButton(
                //   iconSize: 25,
                //   onPressed: () {},
                //   icon: Icon(Icons.more_vert),
                // ),
                PopupMenuButton<String>(
                  icon: Icon(Icons.more_vert),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      12,
                    ), // Apply border radius
                  ),
                  menuPadding: EdgeInsets.only(),
                  elevation: 3,
                  onSelected: (value) {
                    if (value == 'done') {
                      // TODO: danh dau hoan thanh
                    } else if (value == "none-done") {
                      // TODO: chuyen sang dang thuc hien
                    } else if (value == 'modified') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) =>
                                  TaskView(task: task, isModified: true),
                        ),
                      );
                    } else {
                      // xoa task
                      showCupertinoDialog<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return CupertinoAlertDialog(
                            title: Text('Xác nhận xoá'),
                            content: Text(
                              'Bạn có chắc chắn muốn xoá công việc này không?',
                            ),
                            actions: <Widget>[
                              CupertinoDialogAction(
                                isDefaultAction: true,
                                child: Text('Huỷ'),
                                onPressed: () {
                                  Navigator.of(context).pop(); // Đóng dialog
                                },
                              ),
                              CupertinoDialogAction(
                                isDestructiveAction: true,
                                child: Text('Xoá'),
                                onPressed: () {
                                  Navigator.of(context).pop(); // Đóng dialog
                                  // TODO: Gọi hàm xoá tại đây
                                  print('Đã xoá!');
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  itemBuilder:
                      (context) => [
                        if (task.isFinished == 0)
                          PopupMenuItem(
                            value: 'done',
                            child: Text('Đánh dấu hoàn thành'),
                          ),
                        if (task.isFinished == 1)
                          PopupMenuItem(
                            value: 'none-done',
                            child: Text('Bỏ hoàn thành'),
                          ),
                        PopupMenuItem(
                          value: 'modified',
                          child: Text('Chỉnh sửa'),
                        ),
                        PopupMenuItem(value: 'delete', child: Text('Xoá')),
                      ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
