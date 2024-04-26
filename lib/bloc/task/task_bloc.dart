import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iot_flutter_project/bloc/task/task_events.dart';
import 'package:iot_flutter_project/bloc/task/task_states.dart';

import 'package:iot_flutter_project/repository/task_repository.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository _taskRepository;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  TaskBloc(this._taskRepository) : super(TasksLoadInProgress()) {
    on<LoadTasks>(_onLoadTasks);
    on<AddTask>(_onAddTask);
    on<DeleteTask>(_onDeleteTask);
    on<UpdateConnectivity>(_onUpdateConnectivity);

    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      add(UpdateConnectivity(result != ConnectivityResult.none));
    });
  }

  @override
  Future<void> close() {
    _connectivitySubscription.cancel();
    return super.close();
  }

  Future<void> _onLoadTasks(LoadTasks event, Emitter<TaskState> emit) async {
    try {
      final tasks = await _taskRepository.fetchTasks();
      emit(TasksLoadSuccess(tasks));
    } catch (e) {
      emit(TasksLoadFailure(e.toString()));
    }
  }

  Future<void> _onAddTask(AddTask event, Emitter<TaskState> emit) async {
    await _taskRepository.addTask(event.taskName);
    add(LoadTasks());
  }

  Future<void> _onDeleteTask(DeleteTask event, Emitter<TaskState> emit) async {
    await _taskRepository.deleteTask(event.id);
    add(LoadTasks());
  }

  void _onUpdateConnectivity(UpdateConnectivity event, Emitter<TaskState> emit) {
    if (state is TasksLoadSuccess) {
      final currentState = state as TasksLoadSuccess;
      emit(TasksLoadSuccess(currentState.tasks, isConnected: event.isConnected));
    }
  }
}
