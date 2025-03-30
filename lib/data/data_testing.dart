import 'package:task_management/models/task_model.dart';
import 'package:task_management/models/user_model.dart';

List<UserModel> sampleUsers = [
  UserModel(username: "tnquang201", password: "Quang@123", name: "Nhựt Quang"),
  UserModel(username: "admin", password: "admin@123", name: "Admin"),
];
List<TaskModel> sampleTasks = [
  TaskModel(
    title: "Học Flutter",
    description: "Hoàn thành khóa học Flutter cơ bản.",
    createdAt: "2025-03-20",
    deadline: "2025-03-30",
    isFinished: 0,
    imgUrl: "https://example.com/flutter.png",
    listWork: [
      WorkModel(
        title: "Xem bài giảng",
        description: "Xem video hướng dẫn",
        isFinished: 0,
      ),
      WorkModel(
        title: "Làm bài tập",
        description: "Thực hành code theo bài giảng",
        isFinished: 0,
      ),
    ],
  ),
  TaskModel(
    title: "Đọc sách Clean Code",
    description: "Đọc xong chương đầu tiên của sách Clean Code.",
    createdAt: "2025-03-22",
    deadline: "2025-04-05",
    isFinished: 0,
    imgUrl: "https://example.com/cleancode.png",
    listWork: [
      WorkModel(
        title: "Chương 1",
        description: "Hoàn thành chương đầu tiên",
        isFinished: 0,
      ),
      WorkModel(
        title: "Ghi chú",
        description: "Ghi lại các điểm quan trọng",
        isFinished: 0,
      ),
    ],
  ),
  TaskModel(
    title: "Xây dựng API với FastAPI",
    description: "Tạo API backend cho ứng dụng To-Do.",
    createdAt: "2025-03-25",
    deadline: "2025-04-10",
    isFinished: 0,
    imgUrl: "https://example.com/fastapi.png",
    listWork: [
      WorkModel(
        title: "Cài đặt FastAPI",
        description: "Cấu hình môi trường",
        isFinished: 1,
      ),
      WorkModel(
        title: "Viết API CRUD",
        description: "Xây dựng API cho To-Do",
        isFinished: 0,
      ),
    ],
  ),
  TaskModel(
    title: "Tập thể dục buổi sáng",
    description: "Tập thể dục 30 phút mỗi sáng.",
    createdAt: "2025-03-27",
    deadline: "2025-04-15",
    isFinished: 1,
    imgUrl: "https://example.com/workout.png",
    listWork: [
      WorkModel(title: "Chạy bộ", description: "Chạy bộ 2km", isFinished: 1),
      WorkModel(
        title: "Hít đất",
        description: "Thực hiện 20 lần hít đất",
        isFinished: 1,
      ),
    ],
  ),
  TaskModel(
    title: "Học về Redis",
    description: "Nắm vững cách sử dụng Redis để lưu trữ dữ liệu.",
    createdAt: "2025-03-29",
    deadline: "2025-04-20",
    isFinished: 0,
    imgUrl: "https://example.com/redis.png",
    listWork: [
      WorkModel(
        title: "Cài đặt Redis",
        description: "Cấu hình Redis trên máy",
        isFinished: 1,
      ),
      WorkModel(
        title: "Học Redis Streams",
        description: "Tìm hiểu về Redis Streams",
        isFinished: 0,
      ),
    ],
  ),
];
