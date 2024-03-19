import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:iot_flutter_project/object/task.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Task> tasks = [
    Task(name: 'Task 1'),
    Task(name: 'Task 2'),
    Task(name: 'Task 3'),
    Task(name: 'Task 4'),
  ];

  late Connectivity _connectivity;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  bool _isConnected = true;

  @override
  void initState() {
    super.initState();
    _connectivity = Connectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
          setState(() {
            _isConnected = (result != ConnectivityResult.none);
          });
        });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.sizeOf(context);
    final double screenWidth = screenSize.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Tracker'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showAddTaskDialog,
          ),
        ],
      ),
      body: _isConnected
          ? ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(tasks[index].name),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              child: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            onDismissed: (direction) {
              setState(() {
                tasks.removeAt(index);
              });
            },
            child: ListTile(
              title: TextFormField(
                initialValue: tasks[index].name,
                onChanged: (value) {
                  setState(() {
                    tasks[index].name = value;
                  });
                },
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Task Name',
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.03,
                    vertical: 10,
                  ),
                ),
              ),
              trailing: Checkbox(
                value: tasks[index].completed,
                onChanged: (value) {
                  setState(() {
                    tasks[index].completed = value ?? false;
                  });
                },
              ),
            ),
          );
        },
      )
          : const Center(
        child: Text(
          'No Internet Connection',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/profile');
        },
        child: const Icon(Icons.person),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  void _showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newTaskName = '';
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
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                _addTask(Task(name: newTaskName));
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _addTask(Task task) {
    setState(() {
      tasks.add(task);
    });
  }
}
