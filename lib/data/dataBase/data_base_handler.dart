import 'package:myappoint/model/task_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHandler {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(
        path,
        'Tasksss.db',
      ),
      onCreate: (database, version) async {
        await database.execute(
          // to create table
          "CREATE TABLE activeTasks(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL,description TEXT NOT NULL, date DATE NOT NULL, time TEXT NOT NULL)",
        );
        await database.execute(
          // to create table
          "CREATE TABLE user(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL,email TEXT NOT NULL,  password TEXT NOT NULL)",
        );
        await database.execute(
            "CREATE TABLE doneTasks(id INTEGER PRIMARY KEY AUTOINCREMENT, "
            "title TEXT NOT NULL,description TEXT NOT NULL, date DATE NOT NULL,"
            " time TEXT NOT NULL,  "
            "userid INTEGER,"
            "FOREIGN KEY (userId) REFERENCES user(id) ON DELETE SET NULL )");
      },
      version: 1,
    );
  }

  Future<int> insertTask(List<Task> doneTasks) async {
    int result = 0;
    final Database db = await initializeDB();
    for (var taskk in doneTasks) {
      result = await db.insert('doneTasks', taskk.toMap());
    }
    return result;
  }

  Future<void> updateTask(List<Task> doneTasks) async {
    final Database db = await initializeDB();
    for (var taskk in doneTasks) {
      await db.update(
        '  doneTasks',
        taskk.toMap(),
        where: 'id = ?',
        whereArgs: [taskk.id],
      );
    }
  }

  Future<List<Task>> retrieveTasks() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('doneTasks');
    return queryResult.map((e) => Task.fromMap(e)).toList();
  }

  Future<void> deleteTask(int id) async {
    final Database db = await initializeDB();
    db.delete(
      'doneTasks',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
