import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'app_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE courses (
        id INTEGER PRIMARY KEY,
        title TEXT,
        icon TEXT
      )
    ''');

    await db.execute('''
      INSERT INTO courses (title, icon)
      VALUES ('Flutter', 'flutter')
    ''');

    await db.execute('''
      INSERT INTO courses (title, icon)
      VALUES ('Dart', 'dart')
    ''');
  }

  Future<List<Map<String, dynamic>>> getCourses() async {
    Database db = await database;
    return await db.query('courses');
  }

  Future<int> insertCourse(Map<String, dynamic> row) async {
    Database db = await database;
    return await db.insert('courses', row);
  }

  Future<int> updateCourse(Map<String, dynamic> row) async {
    Database db = await database;
    int id = row['id'];
    return await db.update('courses', row, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteCourse(int id) async {
    Database db = await database;
    return await db.delete('courses', where: 'id = ?', whereArgs: [id]);
  }
}
