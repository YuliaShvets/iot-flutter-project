import 'package:iot_flutter_project/object/task.dart';

abstract class TaskRepository {
  Future<List<Task>> fetchTasks();

  Future<void> addTask(String taskName);

  Future<void> deleteTask(String id);
}
