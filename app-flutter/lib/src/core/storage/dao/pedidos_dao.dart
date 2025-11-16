import 'package:sqflite/sqflite.dart';
import '../local_db.dart';
import '../../../core/models/pedido_model.dart';

class PedidosDao {
  Future<Database> get _db async => LocalDb.instance.database;

  Future<void> replaceAll(List<PedidoModel> items) async {
    final db = await _db;

    await db.delete('pedidos');

    for (final item in items) {
      await db.insert('pedidos', item.toMap());
    }
  }

  Future<List<PedidoModel>> getAll() async {
    final db = await _db;

    final rows = await db.query('pedidos');

    return rows.map((e) => PedidoModel.fromMap(e)).toList();
  }
}
