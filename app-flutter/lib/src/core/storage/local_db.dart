import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDB {
  LocalDB._internal();
  static final LocalDB instance = LocalDB._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'clarita_mobile.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createTables,
    );
  }

  Future<void> _createTables(Database db, int version) async {
    await db.execute('''
      CREATE TABLE pedidos (
        id INTEGER PRIMARY KEY,
        cliente TEXT,
        direccion TEXT,
        estado TEXT,
        total REAL,
        fecha TEXT
      );
    ''');

    await db.execute('''
      CREATE TABLE pedido_detalles (
        id INTEGER PRIMARY KEY,
        pedidoId INTEGER,
        producto TEXT,
        cantidad INTEGER,
        precio REAL
      );
    ''');
  }
}