import 'package:sqflite/sqflite.dart';
import '../local_db.dart';
import '../../../core/models/pedido_model.dart';

class PedidosDao {
  static const tableName = 'pedidos';

  Future<void> insert(PedidoModel pedido) async {
    final db = await LocalDB.instance.database;

    await db.insert(
      tableName,
      pedido.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<PedidoModel>> getAll() async {
    final db = await LocalDB.instance.database;
    final maps = await db.query(tableName);

    return maps.map((e) => PedidoModel.fromJson(e)).toList();
  }

  Future<void> clear() async {
    final db = await LocalDB.instance.database;
    await db.delete(tableName);
  }
}

final pedidosDao = PedidosDao();