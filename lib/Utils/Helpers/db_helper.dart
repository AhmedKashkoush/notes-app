import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static const String notesSql =
      "CREATE TABLE notes(id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT,content TEXT,image TEXT,color TEXT,date TEXT,is_done INTEGER,is_favourite INTEGER,is_archived INTEGER)";
  static const String notesNewSql =
      "CREATE TABLE notes(id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT,content TEXT,image BLOB,color TEXT,date TEXT,is_done INTEGER,is_favourite INTEGER,is_archived INTEGER)";
  static Database? _db;
  static Future<Database?> get db async {
    if (_db == null) _db = await _initDB();
    return _db;
  }

  static Future<Database?> _initDB() async {
    String dbname = 'notes_db.db';
    String path = await getDatabasesPath();
    path = join(path, dbname);
    Database db = await openDatabase(path,
        onCreate: _onCreate, onUpgrade: _onUpgrade, version: 4);
    return db;
  }

  static void _onUpgrade(Database db, int oldVersion, int newVersion) async {
    Batch _batch = db.batch();
    _batch.execute("DROP TABLE notes");
    _batch.execute(notesSql);
    _batch.commit();
  }

  static void _onCreate(Database db, int version) async {
    Batch _batch = db.batch();
    _batch.execute(notesSql);
    _batch.commit();
  }

  static Future<int> create(String query, List args) async {
    int response = await _db!.rawInsert(query, args);
    return response;
  }

  static Future<List<Map<String, Object?>>> read(
      String query, List args) async {
    List<Map<String, Object?>> data = await _db!.rawQuery(query, args);
    return data;
  }

  static Future<int> update(String query, List args) async {
    int response = await _db!.rawUpdate(query, args);
    return response;
  }

  static Future<int> delete(String query, List args) async {
    int response = await _db!.rawDelete(query, args);
    return response;
  }
}
