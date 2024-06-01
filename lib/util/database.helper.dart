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
    String path = join(await getDatabasesPath(), 'app_database_v4.db');
    return await openDatabase(
      path,
      version: 4,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE courses (
        id INTEGER PRIMARY KEY,
        title TEXT,
        icon TEXT
      );
    ''');

    await db.execute('''
      CREATE TABLE assignments (
        id INTEGER PRIMARY KEY,
        title TEXT,
        due_date DATE Null,
        course_id INTEGER,
        file_path TEXT,
        FOREIGN KEY (course_id) REFERENCES courses(id)
      );
    ''');

    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY,
        username TEXT UNIQUE,
        password TEXT,
        role TEXT,
        course_id INTEGER,
        FOREIGN KEY (course_id) REFERENCES courses(id)
      );
    ''');

    await db.execute('''
      INSERT INTO courses (title, icon)
      VALUES ('Mobile App', 'flutter');
    ''');

    await db.execute('''
      INSERT INTO courses (title, icon)
      VALUES ('Project Management', 'management');
    ''');

    await db.execute('''
      INSERT INTO courses (title, icon)
      VALUES ('Computer Graphics', 'graphics');
    ''');

    await db.execute('''
      INSERT INTO courses (title, icon)
      VALUES ('Software Testing', 'testing');
    ''');

    await db.execute('''
      INSERT INTO assignments (title, due_date, course_id)
      VALUES ('Assignment 1', '2020-01-01', 1);
    ''');

    await db.execute('''
      INSERT INTO assignments (title, due_date, course_id)
      VALUES ('Note 1', Null, 1);
    ''');

    await db.execute('''
      INSERT INTO assignments (title, due_date, course_id)
      VALUES ('Assignment 2', '2077-01-01', 1);
    ''');

    await db.execute('''
      INSERT INTO users (username, password, role)
      VALUES ('admin', '12345678', 'admin');
    ''');

    await db.execute('''
      INSERT INTO users (username, password, role, course_id)
      VALUES ('Ashenafi', '12345678', 'Teacher', 1);
    ''');

    await db.execute('''
      INSERT INTO users (username, password, role)
      VALUES ('Timaj', '12345678', 'Student');
    ''');
    await db.execute('''
      INSERT INTO users (username, password, role)
      VALUES ('Kaleab', '12345678', 'Student');
    ''');
    await db.execute('''
      INSERT INTO users (username, password, role)
      VALUES ('Yesehak', '12345678', 'Student');
    ''');
    await db.execute('''
      INSERT INTO users (username, password, role)
      VALUES ('Edelawit', '12345678', 'Student');
    ''');
    await db.execute('''
      INSERT INTO users (username, password, role)
      VALUES ('Lidiya', '12345678', 'Student');
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

  Future<List<Map<String, dynamic>>> getAssignmentsByCourseId(
      int courseId) async {
    Database db = await database;
    return await db.query(
      'assignments',
      where: 'course_id = ?'
          'AND due_date IS NOT Null',
      whereArgs: [courseId],
    );
  }

  Future<List<Map<String, dynamic>>> getAssignments() async {
    Database db = await database;
    return await db.query('assignments', orderBy: 'due_date');
  }

  Future<List<Map<String, dynamic>>> getOverDueAssignments() async {
    Database db = await database;
    return await db.query(
      'assignments',
      where: 'due_date < ?',
      whereArgs: [DateTime.now().toIso8601String()],
      orderBy: 'due_date',
    );
  }

  Future<int> insertAssignment(Map<String, dynamic> row) async {
    Database db = await database;
    return await db.insert('assignments', row);
  }

  Future<int> updateAssignment(Map<String, dynamic> row) async {
    Database db = await database;
    int id = row['id'];
    return await db
        .update('assignments', row, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteAssignment(int id) async {
    Database db = await database;
    return await db.delete('assignments', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> insertUser(Map<String, dynamic> row) async {
    Database db = await database;
    return await db.insert('users', row);
  }

  Future<Map<String, dynamic>?> getUser(
      String username, String password) async {
    Database db = await database;
    List<Map<String, dynamic>> results = await db.query(
      'users',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );
    if (results.isNotEmpty) {
      return results.first;
    }
    return null;
  }

  Future<int> deleteUser(int id) async {
    Database db = await database;
    return await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    Database db = await database;
    return await db.query('users');
  }

  Future<void> updateUserPassword(int id, String password) async {
    Database db = await database;
    await db.update('users', {'password': password},
        where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> getNotes() async {
    Database db = await database;
    return await db.query('assignments', where: 'due_date IS NULL');
  }

  Future<List<Map<String, dynamic>>> getNotesByCourseId(int courseId) async {
    Database db = await database;
    return await db.query(
      'assignments',
      where: 'course_id = ? AND due_date IS NULL',
      whereArgs: [courseId],
    );
  }

  Future<int> insertNote(Map<String, dynamic> row) async {
    Database db = await database;
    return await db.insert('assignments', row);
  }

  Future<int> updateNote(Map<String, dynamic> row) async {
    Database db = await database;
    int id = row['id'];
    return await db
        .update('assignments', row, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteNote(int id) async {
    Database db = await database;
    return await db.delete('assignments', where: 'id = ?', whereArgs: [id]);
  }
}
