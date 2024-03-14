import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> tasks = ['Task 1', 'Task 2', 'Task 3', 'Task 4'];
  List<bool> taskCompleted = [false, false, false, false];

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
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(tasks[index]),
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
                taskCompleted.removeAt(index);
              });
            },
            child: ListTile(
              title: TextFormField(
                initialValue: tasks[index],
                onChanged: (value) {
                  tasks[index] = value;
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
                value: taskCompleted[index],
                onChanged: (value) {
                  _toggleTaskCompletion(index, value);
                },
              ),
            ),
          );
        },
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
                _addTask(newTaskName);
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _addTask(String newTaskName) {
    setState(() {
      tasks.add(newTaskName);
      taskCompleted.add(false);
    });
  }

  void _toggleTaskCompletion(int index, bool? value) {
    setState(() {
      taskCompleted[index] = value ?? false;
    });
  }
}
