abstract class TaskEvent {}

class LoadTasks extends TaskEvent {}

class AddTask extends TaskEvent {
  final String taskName;
  AddTask(this.taskName);
}

class DeleteTask extends TaskEvent {
  final String id;
  DeleteTask(this.id);
}

class UpdateConnectivity extends TaskEvent {
  final bool isConnected;
  UpdateConnectivity(this.isConnected);
}
