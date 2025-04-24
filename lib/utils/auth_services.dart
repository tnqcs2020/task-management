import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_management/models/task_model.dart';
import 'package:task_management/utils/http_services.dart';
import 'package:task_management/utils/user_controller.dart';

class AuthServices {
  static final userCtrl = Get.put(UserController());
  static final String todayFormat =
      DateFormat("yyyy-MM-dd").format(DateTime.now()).toString();

  static int calculateOverdueDays(String deadlineString) {
    final deadlineDate = DateTime.parse(deadlineString);
    final endOfDeadline = DateTime(
      deadlineDate.year,
      deadlineDate.month,
      deadlineDate.day,
      23,
      59,
      59,
    );

    final now = DateTime.now();

    if (now.isAfter(endOfDeadline)) {
      final today = DateTime(now.year, now.month, now.day);
      final overdueDate = DateTime(
        deadlineDate.year,
        deadlineDate.month,
        deadlineDate.day,
      );
      return today.difference(overdueDate).inDays;
    }

    return 0;
  }

  static checkOverdue() {
    userCtrl.tasks.forEach((element) {
      TaskModel task = element;
      if (calculateOverdueDays(task.deadline!) > 0 && task.isFinished == 0) {
        task.isFinished = 2;
        updateTask(task);
      }
    });
  }

  static getTasks() async {
    HttpServices httpServices = HttpServices();
    final result = await httpServices.getTasks(userCtrl.username.value);
    if (result['success'] && result['data'].isNotEmpty) {
      final List<dynamic> jsonData = result['data'];
      final List<TaskModel> tasks =
          jsonData
              .map((json) => TaskModel.fromJson(json as Map<String, dynamic>))
              .toList();
      tasks.sort((a, b) => a.title!.compareTo(b.title!));
      userCtrl.tasks.value = tasks;
    }
  }

  static addTask(TaskModel newTask) async {
    HttpServices httpServices = HttpServices();
    final result = await httpServices.addTask(newTask);
    if (result['success']) {
      await getTasks();
    }
  }

  static updateTask(TaskModel task) async {
    HttpServices httpServices = HttpServices();
    final result = await httpServices.updateTask(task);
    if (result['success']) {
      await getTasks();
    }
  }

  static markDone(bool isMarkDone, TaskModel task) async {
    if (isMarkDone == true) {
      task.isFinished = 1;
      task.doneAt = todayFormat;
    } else {
      task.isFinished = 0;
      task.doneAt = "";
    }
    HttpServices httpServices = HttpServices();
    final result = await httpServices.updateTask(task);
    if (result['success']) {
      await getTasks();
    }
  }

  static deleteTask(String taskID) async {
    HttpServices httpServices = HttpServices();
    final result = await httpServices.deleteTask(
      userCtrl.username.value,
      taskID,
    );
    if (result['success']) {
      await getTasks();
    }
  }
}
