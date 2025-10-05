import 'package:flutter/material.dart';
import 'package:flutter_application_learning/todo_app/Auth_page/Auth_page.dart';
import 'package:flutter_application_learning/todo_app/dialog_pages/showdialog.dart';
import 'package:flutter_application_learning/todo_app/provider_/username_provider.dart';
import 'package:flutter_application_learning/todo_app/task.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_learning/todo_app/user_data/userData.dart';
import 'package:flutter_application_learning/todo_app/widget_pages/profilepage.dart';
import 'widget_pages/stats_item.dart';
import 'widget_pages/task_item.dart';
import 'package:flutter_application_learning/todo_app/provider_/task_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Task> tasks = [];
  bool isSwitched = false;

  @override
  void initState() {
    super.initState();
    Provider.of<TaskProvider>(context, listen: false).fetchTasks();
  }

  void _showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Alertdialogadd(
          saveTask: (Task newTask) => Provider.of<TaskProvider>(
            context,
            listen: false,
          ).saveData(newTask),
        );
      },
    );
  }

  void removeList(Task task) {
    showDialog(
      context: context,
      builder: (context) {
        return Alertdialogdelete(
          taskDelete: () => Provider.of<TaskProvider>(
            context,
            listen: false,
          ).removeTasks(task),
        );
      },
    );
  }

  void change_username() {
    final TextEditingController _usernameController = TextEditingController();
    final _formkey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Change Username "),
          content: Form(
            key: _formkey,
            child: TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: "Task Name"),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "please enter the username";
                }
                return null;
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                if (_formkey.currentState?.validate() ?? false) {
                  final newName = _usernameController.text.trim();
                  if (newName.isNotEmpty) {
                    Provider.of<UsernameProvider>(
                      context,
                      listen: false,
                    ).setUsername(newName);
                  }
                  Navigator.pop(context);
                }
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final taskprovider = Provider.of<TaskProvider>(context);
    final usernameprovider = Provider.of<UsernameProvider>(context);

    final tasks = taskprovider.tasks;
    final username = usernameprovider.username;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          IconButton(icon: Icon(Icons.notifications), onPressed: () {}),
          SizedBox(width: 0),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _showAddTaskDialog();
            },
          ),
          SizedBox(width: 2),
        ],

        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(
              child: Text(
                "Hello $username,",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Profilepage()),
                );
              },
            ),
            Text(
              "You have work today",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  StatsItem(
                    items: "Today",
                    icon: Icons.lock_clock_rounded,
                    numbers: "6",
                    color: const Color.fromARGB(255, 137, 170, 232),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2),
                    child: SizedBox(width: 12),
                  ),
                  StatsItem(
                    items: "Scheduled",
                    icon: Icons.timer,
                    numbers: "5",
                    color: const Color.fromARGB(255, 239, 239, 141),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  StatsItem(
                    items: "All",
                    icon: Icons.recycling_rounded,
                    numbers: "14",
                    color: const Color.fromARGB(255, 190, 243, 217),
                  ),
                  SizedBox(width: 12),
                  StatsItem(
                    items: "Overdue",
                    icon: Icons.timer,
                    numbers: "3",
                    color: const Color.fromARGB(255, 228, 167, 187),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      "Today's Task",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Switch(
                      value: isSwitched,
                      activeThumbColor: CupertinoColors.activeGreen,
                      onChanged: (bool value) {
                        setState(() {
                          isSwitched = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              // Align(
              //   alignment: Alignment.centerLeft,
              //   child: Padding(
              //     padding: const EdgeInsets.all(10),
              //     child: Text(
              //       "Today's Task",
              //       style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              //     ),
              //   ),
              // ),
              if (tasks.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Center(child: Text("NO NEW TASK")),
                ),
              ListView.builder(
                itemCount: tasks.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return TaskItems(
                    task: task,
                    onDelete: removeList,
                    onUpdate: (updatedTask) =>
                        taskprovider.updateTask(updatedTask),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
