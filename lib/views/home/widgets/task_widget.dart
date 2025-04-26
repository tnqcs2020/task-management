import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_management/extensions/space_exs.dart';
import 'package:task_management/models/task_model.dart';
import 'package:task_management/utils/auth_services.dart';
import 'package:task_management/views/home/components/in_progress_circle.dart';
import 'package:task_management/views/tasks/task_views.dart';

class TaskWidget extends StatelessWidget {
  TaskWidget({super.key, required this.task, this.isMore = true});
  final TaskModel task;
  final isLoading = false.obs;
  final bool isMore;

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
      height: 65,
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
            height: 50,
            width: 30,
            child: InProgressCircle(
              percent:
                  task.listWork!.isNotEmpty ? percentWork(task.listWork!) : 0.0,
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
                  overflow: TextOverflow.ellipsis,
                ),
                if (task.isFinished == 0)
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/bullseye-arrow.svg',
                        height: 15,
                        width: 15,
                        colorFilter: const ColorFilter.mode(
                          Colors.red,
                          BlendMode.srcIn,
                        ),
                      ),
                      5.w,
                      Text(
                        DateFormat(
                          "dd-MM-yyyy",
                        ).format(DateTime.parse(task.deadline!)).toString(),
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                if (task.isFinished == 1)
                  Row(
                    children: [
                      Icon(Icons.send, color: Colors.red, size: 15),
                      5.w,
                      Text(
                        DateFormat(
                          "dd-MM-yyyy",
                        ).format(DateTime.parse(task.doneAt!)).toString(),
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                if (task.isFinished == 2)
                  Row(
                    children: [
                      Icon(
                        Icons.warning_amber_rounded,
                        color: Colors.orange,
                        size: 20,
                      ),
                      5.w,
                      Text(
                        "Đã trễ ${AuthServices.calculateOverdueDays(task.deadline!)} ngày",
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          if (isMore)
            SizedBox(
              width: 50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  PopupMenuButton<String>(
                    icon: Icon(Icons.more_vert),
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    menuPadding: EdgeInsets.only(),
                    elevation: 3,
                    onSelected: (value) async {
                      if (value == 'done') {
                        showCupertinoDialog<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return CupertinoAlertDialog(
                              title: Text('Xác nhận hoàn thành'),
                              content: Text(
                                'Bạn muốn chuyển công việc sang trạng thái hoàn thành?',
                              ),
                              actions: <Widget>[
                                CupertinoDialogAction(
                                  isDefaultAction: true,
                                  child: Text('Hủy'),
                                  onPressed: () {
                                    Navigator.of(context).pop(); // Đóng dialog
                                  },
                                ),
                                CupertinoDialogAction(
                                  isDestructiveAction: true,
                                  child: Text('Chuyển'),
                                  onPressed: () async {
                                    Navigator.of(context).pop();
                                    EasyLoading.show(
                                      status: 'Đang cập nhật...',
                                    );
                                    try {
                                      await AuthServices.markDone(true, task);
                                      EasyLoading.dismiss();
                                      EasyLoading.showSuccess(
                                        "Đã đánh dấu hoàn thành!",
                                      );
                                    } catch (e) {
                                      EasyLoading.dismiss();
                                      EasyLoading.showError('Có lỗi xảy ra!');
                                    }
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      } else if (value == "none-done") {
                        showCupertinoDialog<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return CupertinoAlertDialog(
                              title: Text('Xác nhận đang làm'),
                              content: Text(
                                'Bạn muốn chuyển công việc sang trạng thái đang làm?',
                              ),
                              actions: <Widget>[
                                CupertinoDialogAction(
                                  isDefaultAction: true,
                                  child: Text('Hủy'),
                                  onPressed: () {
                                    Navigator.of(context).pop(); // Đóng dialog
                                  },
                                ),
                                CupertinoDialogAction(
                                  isDestructiveAction: true,
                                  child: Text('Chuyển'),
                                  onPressed: () async {
                                    Navigator.of(context).pop();
                                    EasyLoading.show(
                                      status: 'Đang cập nhật...',
                                    );
                                    try {
                                      await AuthServices.markDone(false, task);
                                      EasyLoading.dismiss();
                                      EasyLoading.showSuccess(
                                        "Đã bỏ hoàn thành!",
                                      );
                                    } catch (e) {
                                      EasyLoading.dismiss();
                                      EasyLoading.showError('Có lỗi xảy ra!');
                                    }
                                  },
                                ),
                              ],
                            );
                          },
                        );
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
                                  onPressed: () async {
                                    Navigator.of(context).pop();
                                    EasyLoading.show(status: 'Đang xoá...');
                                    try {
                                      if (AuthServices.userCtrl.tasks.length ==
                                          1) {
                                        AuthServices.userCtrl.tasks.value = [];
                                      }
                                      await AuthServices.deleteTask(
                                        task.createdBy!,
                                        task.taskID!,
                                      );
                                      EasyLoading.dismiss();
                                      EasyLoading.showSuccess('Đã xoá!');
                                    } catch (e) {
                                      EasyLoading.dismiss();
                                      EasyLoading.showError('Có lỗi xảy ra!');
                                    }
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
