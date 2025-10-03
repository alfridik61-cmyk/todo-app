import 'package:flutter/material.dart';
import 'package:flutter_application_learning/toDo_app/Auth_page/Auth_page.dart';
import 'package:flutter_application_learning/todo_app/homepage.dart';
import 'package:flutter_application_learning/todo_app/provider_/task_provider.dart';
import 'package:flutter_application_learning/todo_app/widget_pages/profilepage.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_learning/todo_app/provider_/username_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('access_token');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskProvider()),
        ChangeNotifierProvider(create: (_) => UsernameProvider()),
      ],
      child: MyApp(initialToken: token),
    ),
  );
}

class MyApp extends StatelessWidget {
  final String? initialToken;
  const MyApp({super.key, this.initialToken});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: Profilepage(),
      home: initialToken != null ? Profilepage() : const AuthPage(),
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
    );
  }
}
