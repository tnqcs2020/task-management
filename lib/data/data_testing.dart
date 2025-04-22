import 'package:task_management/models/task_model.dart';

List<TaskModel> sampleTasks = [
  TaskModel(
    title: "Học Flutter",
    description: "Hoàn thành khóa học Flutter cơ bản.",
    createdAt: "2025-03-20",
    deadline: "2025-04-01",
    isFinished: 2,
    createdBy: "tnquang",
    listWork: [
      WorkModel(title: "Xem bài giảng", isFinished: 0),
      WorkModel(title: "Làm bài tập", isFinished: 0),
    ],
  ),
  TaskModel(
    title: "Đọc sách Clean Code",
    description: "Đọc xong chương đầu tiên của sách Clean Code.",
    createdAt: "2025-03-22",
    deadline: "2025-04-21",
    isFinished: 0,
    createdBy: "tnquang",
    listWork: [
      WorkModel(title: "Chương 1", isFinished: 0),
      WorkModel(title: "Ghi chú", isFinished: 1),
    ],
  ),
  TaskModel(
    title: "Xây dựng API với FastAPI",
    description: "Tạo API backend cho ứng dụng To-Do.",
    createdAt: "2025-03-25",
    deadline: "2025-04-10",
    isFinished: 0,
    createdBy: "tnquang",
    listWork: [
      WorkModel(title: "Cài đặt FastAPI", isFinished: 1),
      WorkModel(title: "Viết API CRUD", isFinished: 0),
    ],
  ),
  TaskModel(
    title: "Tập thể dục buổi sáng",
    description: "Tập thể dục 30 phút mỗi sáng.",
    createdAt: "2025-03-27",
    deadline: "2025-04-15",
    isFinished: 1,
    createdBy: "tnquang",
    listWork: [
      WorkModel(title: "Chạy bộ", isFinished: 1),
      WorkModel(title: "Hít đất", isFinished: 1),
    ],
  ),
  TaskModel(
    title: "Học về Redis 1",
    description: "Nắm vững cách sử dụng Redis để lưu trữ dữ liệu.",
    createdAt: "2025-03-29",
    deadline: "2025-04-20",
    isFinished: 0,
    createdBy: "tnquang",
    listWork: [
      WorkModel(title: "Cài đặt Redis", isFinished: 1),
      WorkModel(title: "Học Redis Streams", isFinished: 0),
    ],
  ),
  TaskModel(
    title: "Học về Redis 2",
    description: "Nắm vững cách sử dụng Redis để lưu trữ dữ liệu.",
    createdAt: "2025-03-29",
    deadline: "2025-04-20",
    isFinished: 0,
    createdBy: "tnquang",
    listWork: [
      WorkModel(title: "Cài đặt Redis", isFinished: 1),
      WorkModel(title: "Học Redis Streams", isFinished: 0),
    ],
  ),
  TaskModel(
    title: "Học về Redis 3",
    description: "Nắm vững cách sử dụng Redis để lưu trữ dữ liệu.",
    createdAt: "2025-03-29",
    deadline: "2025-04-20",
    isFinished: 0,
    createdBy: "tnquang",
    listWork: [
      WorkModel(title: "Cài đặt Redis", isFinished: 1),
      WorkModel(title: "Học Redis Streams", isFinished: 0),
    ],
  ),
  TaskModel(
    title: "Học về Redis 4",
    description: "Nắm vững cách sử dụng Redis để lưu trữ dữ liệu.",
    createdAt: "2025-03-29",
    deadline: "2025-04-20",
    isFinished: 0,
    createdBy: "tnquang",
    listWork: [
      WorkModel(title: "Cài đặt Redis", isFinished: 1),
      WorkModel(title: "Học Redis Streams", isFinished: 0),
    ],
  ),
  TaskModel(
    title: "Học về Redis 5",
    description: "Nắm vững cách sử dụng Redis để lưu trữ dữ liệu.",
    createdAt: "2025-03-29",
    deadline: "2025-04-20",
    isFinished: 0,
    createdBy: "tnquang",
    listWork: [
      WorkModel(title: "Cài đặt Redis", isFinished: 1),
      WorkModel(title: "Học Redis Streams", isFinished: 0),
    ],
  ),
];
