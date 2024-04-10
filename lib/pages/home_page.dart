import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:iot_flutter_project/bloc/task/task_bloc.dart';
import 'package:iot_flutter_project/bloc/task/task_events.dart';
import 'package:iot_flutter_project/bloc/task/task_states.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Tracker'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddTaskDialog(context),
          ),
        ],
      ),
      body: BlocConsumer<TaskBloc, TaskState>(
        listener: (context, state) {
          if (state is TasksLoadFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        builder: (context, state) {
          if (state is TasksLoadInProgress) {
            return const CircularProgressIndicator();
          } else if (state is TasksLoadSuccess) {
            return ListView.builder(
              itemCount: state.tasks.length,
              itemBuilder: (context, index) {
                final task = state.tasks[index];
                return Dismissible(
                  key: Key(task.id.toString()),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    BlocProvider.of<TaskBloc>(context).add(DeleteTask(task.id));
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  child: ListTile(
                    title: Text(task.name),
                    trailing: Checkbox(
                      value: task.completed,
                      onChanged: (bool? newValue) {
                      },
                    ),
                  ),
                );
              },
            );
          } else if (state is TasksLoadFailure) {
            return Center(
              child: Text('Error: ${state.error}'),
            );
          } else {
            return const Center(
              child: Text('No data available'),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/profile');
        },
        child: const Icon(Icons.person),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    String newTaskName = '';
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Task'),
          content: TextFormField(
            onChanged: (value) {
              newTaskName = value;
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Task Name',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                BlocProvider.of<TaskBloc>(context).add(AddTask(newTaskName));
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
