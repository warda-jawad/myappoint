class Task {
  final int? id;
  final String? title;
  final String? description;
  final String? date;
  final String? time;

  Task({
    this.id,
    required this.title,
    required this.description,
    required this.date,
    this.time,
  });

  Task.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        title = res["title"],
        description = res["description"],
        date = res["date"],
        time = res["time"];

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date,
      'time': time
    };
  }
}
