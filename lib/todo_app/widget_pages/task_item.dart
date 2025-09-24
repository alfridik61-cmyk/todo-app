import 'package:flutter/material.dart';
import 'package:flutter_application_learning/todo_app/task.dart';


class TaskItems extends StatelessWidget {
  final Task task;
  final Function? onDelete;
  final Function? onUpdate;

  const TaskItems({
    super.key,
    required this.task,
    this.onDelete,
    this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8),
        ],
      ),
      child: TextButton(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Icon(Icons.radio_button_checked_rounded),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_view_day,
                        size: 14,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        task.date,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(width: 12),
                      if (task.time != "")
                        Icon(
                          Icons.access_time,
                          size: 16,
                          color: Colors.grey.shade600,
                        ),
                      const SizedBox(width: 4),
                      Text(
                        task.time,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    task.taskName,
                    style: TextStyle(
                      fontSize: 18,
                      color: const Color.fromARGB(255, 57, 56, 56),
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.more_horiz, color: Colors.grey.shade600),
              onPressed: () => onDelete!(task),
            ),
          ],
        ),
        onPressed: () {
          TextEditingController nameController = TextEditingController(
            text: task.taskName,
          );
          TextEditingController timeController = TextEditingController(
            text: task.time,
          );
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Edit Task"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(labelText: "Task Name"),
                    ),
                    TextField(
                      controller: timeController,
                      decoration: InputDecoration(labelText: "Time"),
                    ),
                  ],
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
                      task.taskName = nameController.text;
                      task.time = timeController.text;
                      onUpdate!(task);

                      Navigator.pop(context);
                    },
                    child: Text("Save"),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
