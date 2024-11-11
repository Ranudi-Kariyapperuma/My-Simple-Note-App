import 'package:mysimplenote/models/note.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('notes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE notes(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT,
      content TEXT,
      createdAt TEXT
    )
    ''');
  }

  Future<int> addNote(Note note) async {
    final db = await instance.database;
    return await db.insert('notes', note.toMap());
  }

  Future<List<Note>> getNotes() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('notes');
    return List.generate(maps.length, (i) {
      return Note.fromMap(maps[i]);
    });
  }

  Future<int> deleteNote(int id) async {
    final db = await instance.database;
    return await db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateNote(Note note) async {
    final db = await instance.database;
    return await db
        .update('notes', note.toMap(), where: 'id = ?', whereArgs: [note.id]);
  }

  Future<void> close() async {
    final db = await _database;
    if (db != null) {
      await db.close();
    }
  }
}
