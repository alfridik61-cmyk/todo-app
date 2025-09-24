import 'package:flutter/material.dart';
import 'package:flutter_application_learning/todo_app/task.dart';


class Alertdialogadd extends StatefulWidget {
  final Function saveTask;
  const Alertdialogadd({super.key, required this.saveTask});

  @override
  State<Alertdialogadd> createState() => _Alertdialog_addState();
}

class _Alertdialog_addState extends State<Alertdialogadd> {
  String taskName = " ";
  String time = "";
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Add New Task!!"),
      content: Padding(
        padding: const EdgeInsets.all(8),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "Task Name"),
                onChanged: (value) {
                  taskName = value;
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "please enter the task";
                  }
                  return null;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: "Time"),
                onChanged: (value) {
                  time = value;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancel"),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      Task newTask = Task(
                        taskName: taskName,
                        date: "Today",
                        time: time,
                      );

                      widget.saveTask(newTask);
                      Navigator.pop(context);
                    });
                  }
                },
                child: Text("Add"),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class Alertdialogdelete extends StatefulWidget {
  final Function taskDelete;

  const Alertdialogdelete({super.key, required this.taskDelete});

  @override
  State<Alertdialogdelete> createState() => _AlertdialogdeleteState();
}

class _AlertdialogdeleteState extends State<Alertdialogdelete> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Do you confirm delete?"),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            widget.taskDelete();
            Navigator.pop(context);
          },
          child: Text("delete"),
        ),
      ],
    );
  }
}
