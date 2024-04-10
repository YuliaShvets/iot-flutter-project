import '../../object/task.dart';

abstract class TaskState {}

class TasksLoadInProgress extends TaskState {}

class TasksLoadSuccess extends TaskState {
  final List<Task> tasks;
  final bool isConnected;
  TasksLoadSuccess(this.tasks, {this.isConnected = true});
}

class TasksLoadFailure extends TaskState {
  final String error;
  TasksLoadFailure(this.error);
}
