import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iot_flutter_project/bloc/task/task_bloc.dart';
import 'package:iot_flutter_project/bloc/user/profile_bloc.dart';
import 'package:iot_flutter_project/pages/home_page.dart';
import 'package:iot_flutter_project/pages/login_page.dart';
import 'package:iot_flutter_project/pages/profile_page.dart';
import 'package:iot_flutter_project/pages/registration_page.dart';
import 'package:iot_flutter_project/repository/impl/task_repository_impl.dart';
import 'package:iot_flutter_project/repository/local_storage_repository.dart';
import 'package:iot_flutter_project/repository/task_repository.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final TaskRepository taskRepository = TaskRepositoryImpl();
    final LocalStorageRepository localStorageRepository =
    LocalStorageRepository();

    return MultiBlocProvider(
      providers: [
        BlocProvider<TaskBloc>(
          create: (BuildContext context) => TaskBloc(taskRepository),
        ),
        BlocProvider<ProfileBloc>(
          create: (BuildContext context) =>
              ProfileBloc(localStorageRepository: localStorageRepository),
        ),
      ],
      child: MaterialApp(
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
      ),
    );
  }
}
