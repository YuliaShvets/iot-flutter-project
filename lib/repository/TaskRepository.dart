import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:iot_flutter_project/object/task.dart';

class TaskRepository {
  static Future<List<Task>> fetchTasks() async {
    try {
      final response = await http.get(Uri.parse('http://10.0.2.2:8080/task'));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
        return data
            .map<Task>((json) => Task.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Failed to fetch tasks');
      }
    } catch (e) {
      return [];
    }
  }

  static Future<void> addTask(String taskName) async {
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8080/task'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'name': taskName,
        }),
      );
      if (response.statusCode == 201) {
      } else {
        throw Exception('Failed to add task');
      }
    } catch (e) {
      print('Error adding task: $e');
    }
  }

  static Future<void> deleteTask(String id) async {
    try {
      final response =
          await http.delete(Uri.parse('http://10.0.2.2:8080/task/$id'));
      if (response.statusCode == 200) {
      } else {
        throw Exception('Failed to delete task');
      }
    } catch (e) {
      print('Error deleting task: $e');
    }
  }

}
