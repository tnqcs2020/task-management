import 'package:get/get.dart';
import 'package:task_management/models/task_model.dart';

class UserController extends GetxController {
  // Reactive user data
  var username = ''.obs;
  var name = ''.obs;
  RxList<TaskModel> tasks = <TaskModel>[].obs;
  RxMap<DateTime, List<TaskModel>> tasksByDateDone =
      <DateTime, List<TaskModel>>{}.obs;
  RxList<DateTime> groupDateDone = <DateTime>[].obs;
  RxMap<DateTime, List<TaskModel>> tasksByDateOverdue =
      <DateTime, List<TaskModel>>{}.obs;
  RxList<DateTime> groupDateOverdue = <DateTime>[].obs;
  Rx<bool> isModified = false.obs;
  Rx<bool> isLoading = true.obs;

  // Set user data
  void setUser(String u, String n) {
    username.value = u;
    name.value = n;
  }

  RxMap<DateTime, List<TaskModel>> setTasksByDateDone() {
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
    tasksByDateDone.value = grouped;
    return tasksByDateDone;
  }

  RxList<DateTime> setGroupDateDone() {
    groupDateDone.value =
        setTasksByDateDone()().keys.toList()..sort((a, b) => b.compareTo(a));
    return groupDateDone;
  }

  RxMap<DateTime, List<TaskModel>> setTasksByDateOverdue() {
    Map<DateTime, List<TaskModel>> grouped = {};
    for (var task in tasks) {
      if (task.deadline == null) continue;
      DateTime deadline = DateTime.parse(task.deadline!);
      DateTime dateOnly = DateTime(deadline.year, deadline.month, deadline.day);
      if (task.isFinished == 2) {
        if (!grouped.containsKey(dateOnly)) {
          grouped[dateOnly] = [];
        }

        grouped[dateOnly]!.add(task);
      }
    }
    tasksByDateOverdue.value = grouped;
    return tasksByDateOverdue;
  }

  RxList<DateTime> setGroupDateOverdue() {
    groupDateOverdue.value =
        setTasksByDateOverdue().keys.toList()..sort((a, b) => b.compareTo(a));
    return groupDateOverdue;
  }

  // Clear user data (e.g. on logout)
  clearUser() {
    username.value = '';
    name.value = '';
    tasks.value = [];
    tasksByDateDone.value = {};
    groupDateDone.value = [];
    tasksByDateOverdue.value = {};
    groupDateOverdue.value = [];
    isModified.value = false;
    isLoading.value = true;
  }
}
