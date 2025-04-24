class TaskModel {
  String? title;
  String? description;
  String? createdAt;
  String? deadline;
  int? isFinished;
  String? createdBy;
  String? doneAt;
  String? taskID;
  List<WorkModel>? listWork;

  TaskModel({
    this.title,
    this.description,
    this.createdAt,
    this.deadline,
    this.isFinished,
    this.createdBy,
    this.doneAt,
    this.taskID,
    this.listWork,
  });

  TaskModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    createdAt = json['created_at'];
    deadline = json['deadline'];
    isFinished = json['is_finished'];
    createdBy = json['created_by'];
    doneAt = json['done_at'];
    taskID = json['task_id'];
    if (json['list_work'] != null) {
      listWork = <WorkModel>[];
      json['list_work'].forEach((v) {
        listWork!.add(WorkModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['created_at'] = createdAt;
    data['deadline'] = deadline;
    data['is_finished'] = isFinished;
    data['created_by'] = createdBy;
    data['done_at'] = doneAt;
    data['task_id'] = taskID;
    if (listWork != null) {
      data['list_work'] = listWork!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WorkModel {
  String? title;
  int? isFinished;

  WorkModel({this.title, this.isFinished});

  WorkModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    isFinished = json['is_finished'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['is_finished'] = isFinished;
    return data;
  }
}
