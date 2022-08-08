import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  //padrao singleton
  DatabaseHelper._();
  static final DatabaseHelper instance = DatabaseHelper._();

  static Database? _database;

  Future<Database> get database async {
    _database ??= await _init();
    return _database!;
  }

  Future<Database> _init() async {
    String path = await getDatabasesPath();
    String pathWithName = '$path + /database.db';

    return await openDatabase(pathWithName, version: 1,
        onCreate: (Database db, int version) {
      db.execute(
          'create table texts (id integer primary key autoincrement,title text)');
    });
  }

  //métodos crud

  Future<int> insertText(String text) async {
    Database db = await instance.database;

    return db.insert('texts', {'title': text});
  }

  Future<List<Map<String, dynamic>>> getAllText() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> response = await db.query('texts');

    if (response.isNotEmpty) {
      return (response);
    }
    return [];
  }
}
