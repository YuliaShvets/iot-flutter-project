import 'package:flutter/material.dart';
import 'package:iot_flutter_project/pages/home_page.dart';
import 'package:iot_flutter_project/pages/login_page.dart';
import 'package:iot_flutter_project/pages/profile_page.dart';
import 'package:iot_flutter_project/pages/registration_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/registration': (context) => const RegistrationPage(),
        '/home': (context) => const HomePage(),
        '/profile': (context) => const ProfilePage(),
      },
    );
  }
}
