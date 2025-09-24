import 'package:flutter/material.dart';
import 'package:flutter_application_learning/todo_app/task.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TaskProvider with ChangeNotifier {
  final List<Task> _tasks = [];
  List<Task> get tasks => _tasks;

  Future<void> saveData(Task task) async {
    final url = Uri.parse("http://192.168.1.64:3000/tasks");

    Map<String, dynamic> data = task.tomap();
    data.remove("id");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );
    if (response.statusCode == 201) {
      _tasks.add(Task.fromMap(jsonDecode(response.body)));
      notifyListeners();
    } else {
      throw Exception("Failed to add task");
    }
  }

  // to load data
  Future<void> fetchTasks() async {
    final url = Uri.parse("http://192.168.1.64:3000/tasks");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List decoded = jsonDecode(response.body);
      _tasks.clear();
      _tasks.addAll(decoded.map((map) => Task.fromMap(map)).toList());
      notifyListeners();
    } else {
      throw Exception("Failed to Load task:${response.statusCode}");
    }
  }

  //to remove data
  Future<void> removeTasks(Task task) async {
    final url = Uri.parse("http://192.168.1.64:3000/tasks/${task.id}");
    final response = await http.delete(url);
    if (response.statusCode == 200) {
      _tasks.remove(task);
      notifyListeners();
    } else {
      throw Exception("Failed to Delete");
    }
  }

  Future<void> updateTask(Task task) async {
    final url = Uri.parse("http://192.168.1.64:3000/tasks/${task.id}");
    final response = await http.put(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(task.tomap()),
    );
    if (response.statusCode == 200) {
      await fetchTasks();
    } else {
      throw Exception("Failed to update Task");
    }
  }
}
