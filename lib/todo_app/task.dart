class Task {
  String? id;
  String taskName;
  final String date;
  String time;
  bool? ischecked;

  Task({
    required this.taskName,
    required this.date,
    required this.time,
    this.id,
    this.ischecked,
  });
  Map<String, dynamic> tomap() {
    return {
      'taskName': taskName,
      'date': date,
      'time': time,
      'id': id,
      'ischecked': ischecked,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      taskName: map['taskName'],
      date: map['date'],
      time: map['time'],
      id: map['id'],
      ischecked: map['ischecked'],
    );
  }
}
