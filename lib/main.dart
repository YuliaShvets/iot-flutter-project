import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController textController = TextEditingController();
  int _counter = 0;
  bool isError = false;
  bool isCharizardMode = false; // To track if Charizard mode is active

  void _changeValue() {
    setState(() {
      isError = false;
      final enteredValue = textController.text.trim();
      if (enteredValue.isNotEmpty) {
        final parsedValue = int.tryParse(enteredValue);
        if (parsedValue != null) {
          _counter += parsedValue;
        } else if (enteredValue == 'Avada Kedavra') {
          _counter = 0;
        } else if (enteredValue == 'Draconifors') {
          // Activate Charizard mode
          isCharizardMode = true;
        } else {
          isError = true;
        }
      }
      textController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: const Text('Magic App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: isCharizardMode
            ? InkWell(
          onDoubleTap: () {
            // Deactivate Charizard mode
            setState(() {
              isCharizardMode = false;
            });
          },
          child: Image.asset('assets/image.png'), // Provide the path to your Charizard image
        )
            : Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                TextField(
                  controller: textController,
                  decoration: const InputDecoration(
                    hintText: 'Enter value',
                  ),
                ),
                ElevatedButton(
                  onPressed: _changeValue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  child: const Text(
                    'Change Value',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            Text(
              'Total: $_counter',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Visibility(
              visible: isError,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: const Text(
                  "Can't convert string to number :)",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
