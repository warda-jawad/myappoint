import 'package:myappoint/model/task_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHandler {
  Future<Database> initializeDB() async {
    String path =
        await getDatabasesPath(); // getDatabasePath() is inside the sqflite,
    // and it will get the default database location.
    return openDatabase(
      // openDatabase()  is also inside the package sqflite,
      // and it accepts a mandatory String as an argument which will be the path of the database.
      join(
        path,
        'Taskss.db',
      ), //to make DB, Taskss.db is the name of my database.
      onCreate: (database, version) async {
        await database.execute(
          // to create table
          "CREATE TABLE activeTasks(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL,description TEXT NOT NULL, date TEXT NOT NULL, time TEXT NOT NULL)",
        );
      },
      version: 1,
    );
  }

  // to insert data
  Future<int> insertTask(List<Task> activeTasks) async {
    // activeTasks is the name of table
    int result = 0;
    final Database db = await initializeDB();
    for (var taskk in activeTasks) {
      result = await db.insert('activeTasks', taskk.toMap());
    }
    return result;
  }

  //to retrieve all data
  Future<List<Task>> retrieveTasks() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult =
        await db.query('activeTasks'); // activeTasks is name of table
    return queryResult.map((e) => Task.fromMap(e)).toList();
  }

  // to delete data
  Future<void> deleteTask(int id) async {
    final Database db = await initializeDB();
    await db.delete(
      'activeTasks', // activeTasks is name of table
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
