import 'package:flutter/material.dart';
import 'package:flutter_application_learning/toDo_app/Auth_page/Auth_page.dart';
import 'package:flutter_application_learning/todo_app/homepage.dart';
import 'package:flutter_application_learning/todo_app/provider_/task_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_learning/todo_app/provider_/username_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskProvider()),
        ChangeNotifierProvider(create: (_) => UsernameProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthPage(),
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
    );
  }
}
