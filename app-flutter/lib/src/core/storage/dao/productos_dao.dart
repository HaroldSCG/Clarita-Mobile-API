import 'package:sqflite/sqflite.dart';
import '../local_db.dart';
import '../../../core/models/producto_model.dart';

class ProductosDao {
  Future<Database> get _db async => LocalDb.instance.database;

  Future<void> replaceAll(List<ProductoModel> items) async {
    final db = await _db;
    await db.delete('productos');

    for (final p in items) {
      await db.insert('productos', p.toMap());
    }
  }

  Future<List<ProductoModel>> getAll() async {
    final db = await _db;

    final rows = await db.query('productos');

    return rows.map((e) => ProductoModel.fromMap(e)).toList();
  }
}
