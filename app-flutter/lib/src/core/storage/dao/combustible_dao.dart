
import '../local_db.dart';
import '../../models/combustible_model.dart';
import 'package:sqflite/sqflite.dart';
class CombustibleDAO {
  Future<void> insert(CombustibleModel c) async {
    final db = await LocalDB.instance.database;

    await db.insert(
      'combustible',
      {
        "id": c.id,
        "camionId": c.camionId,
        "gasolinera": c.gasolinera,
        "litros": c.litros,
        "precio": c.precio,
        "fechaCarga": c.fechaCarga,
        "kilometrajeInicial": c.kilometrajeInicial,
        "kilometrajeFinal": c.kilometrajeFinal,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<CombustibleModel>> getAll() async {
    final db = await LocalDB.instance.database;
    final result = await db.query('combustible');

    return result.map((e) => CombustibleModel.fromJson(e)).toList();
  }
}

final combustibleDAO = CombustibleDAO();