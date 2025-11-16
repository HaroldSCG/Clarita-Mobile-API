import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDb {
  LocalDb._privateConstructor();
  static final LocalDb instance = LocalDb._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    final path = join(await getDatabasesPath(), 'clarita.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // Tabla de usuario para sesión
        await db.execute('''
          CREATE TABLE users (
            id INTEGER PRIMARY KEY,
            nombre TEXT,
            correo TEXT,
            token TEXT
          );
        ''');
      },
    );
  }
}
