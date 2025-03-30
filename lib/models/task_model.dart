class TaskModel {
  String? title;
  String? description;
  String? createdAt;
  String? deadline;
  int? isFinished;
  String? imgUrl;
  List<WorkModel>? listWork;

  TaskModel({
    this.title,
    this.description,
    this.createdAt,
    this.deadline,
    this.isFinished,
    this.imgUrl,
    this.listWork,
  });

  TaskModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    createdAt = json['created_at'];
    deadline = json['deadline'];
    isFinished = json['is_finished'];
    imgUrl = json['img_url'];
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
    data['img_url'] = imgUrl;
    if (listWork != null) {
      data['list_work'] = listWork!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WorkModel {
  String? title;
  String? description;
  int? isFinished;

  WorkModel({this.title, this.description, this.isFinished});

  WorkModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    isFinished = json['is_finished'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['is_finished'] = isFinished;
    return data;
  }
}
