import 'package:sqflite/sqflite.dart';
import '../local_db.dart';
import '../../../core/models/combustible_model.dart';

class CombustibleDao {
  Future<Database> get _db async => LocalDb.instance.database;

  Future<void> replaceAll(List<CombustibleModel> items) async {
    final db = await _db;

    await db.delete('combustible');

    for (final item in items) {
      await db.insert('combustible', item.toMap());
    }
  }

  Future<List<CombustibleModel>> getAll() async {
    final db = await _db;

    final rows = await db.query('combustible');

    return rows.map((e) => CombustibleModel.fromMap(e)).toList();
  }
}
