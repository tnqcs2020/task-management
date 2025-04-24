import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:task_management/models/task_model.dart';

class HttpServices {
  final String baseUrl = "https://todo-list-caohoc.up.railway.app";
  final Map<String, String> headers = {"Content-Type": "application/json"};

  Future<Map<String, dynamic>> login(String username, String password) async {
    final url = Uri.parse('$baseUrl/login');
    final body = jsonEncode({"username": username, "password": password});

    try {
      final response = await http.post(url, headers: headers, body: body);
      final json = jsonDecode(response.body);

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204) {
        return {
          "success": true,
          "username": json["username"],
          "name": json["name"],
        };
      } else {
        return {"success": false};
      }
    } catch (e) {
      return {"success": false};
    }
  }

  Future<Map<String, dynamic>> register(
    String username,
    String password,
    String name,
  ) async {
    final url = Uri.parse('$baseUrl/register');
    final body = jsonEncode({
      "username": username,
      "password": password,
      "name": name,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);
      final json = jsonDecode(response.body);

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204) {
        return {
          "success": true,
          "username": json["username"],
          "name": json["name"],
        };
      } else {
        return {"success": false};
      }
    } catch (e) {
      return {"success": false, "message": "An error occurred: $e"};
    }
  }

  Future<Map<String, dynamic>> addTask(TaskModel task) async {
    final url = Uri.parse('$baseUrl/add-task');
    final body = jsonEncode({
      "username": task.createdBy,
      "task": task.toJson(),
    });
    try {
      final response = await http.post(url, headers: headers, body: body);
      final json = jsonDecode(response.body);
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204) {
        return {"success": true, "data": json['task']};
      } else {
        return {"success": false};
      }
    } catch (e) {
      return {"success": false, "message": "Error: $e"};
    }
  }

  Future<Map<String, dynamic>> getTasks(String username) async {
    final url = Uri.parse('$baseUrl/tasks');
    final body = jsonEncode({"username": username});

    try {
      final response = await http.post(url, headers: headers, body: body);
      final json = jsonDecode(response.body);
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204) {
        return {
          "success": true,
          "message": "Tasks retrieved",
          "data": json["tasks"],
        };
      } else {
        return {
          "success": false,
          "message": "Failed to get tasks",
          "data": json["tasks"],
        };
      }
    } catch (e) {
      return {"success": false, "message": "An error occurred: $e"};
    }
  }

  Future<Map<String, dynamic>> deleteTask(
    String username,
    String taskId,
  ) async {
    final url = Uri.parse('$baseUrl/delete-task');
    final body = jsonEncode({"username": username, "task_id": taskId});

    try {
      final response = await http.delete(url, headers: headers, body: body);
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204) {
        return {"success": true};
      } else {
        return {"success": false};
      }
    } catch (e) {
      return {"success": false};
    }
  }

  Future<Map<String, dynamic>> updateTask(TaskModel task) async {
    final url = Uri.parse('$baseUrl/update-task');
    final body = jsonEncode({
      "username": task.createdBy,
      "task": task.toJson(),
      "task_id": task.taskID,
    });
    try {
      final response = await http.put(url, headers: headers, body: body);
      final json = jsonDecode(response.body);
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204) {
        return {"success": true, "data": json['task']};
      } else {
        return {"success": false};
      }
    } catch (e) {
      return {"success": false, "message": "Error: $e"};
    }
  }
}
