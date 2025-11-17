import '../local_db.dart';
import '../../models/producto_model.dart';
import 'package:sqflite/sqflite.dart';
class ProductosDAO {
  Future<void> insert(ProductoModel p) async {
    final db = await LocalDB.instance.database;

    await db.insert(
      'productos',
      {
        "id": p.id,
        "codigo": p.codigo,
        "nombre": p.nombre,
        "descripcion": p.descripcion,
        "precioVenta": p.precioVenta,
        "stockActual": p.stockActual,
        "stockMinimo": p.stockMinimo,
        "unidadMedida": p.unidadMedida,
        "categoria": p.categoria,
        "proveedor": p.proveedor,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<ProductoModel>> getAll() async {
    final db = await LocalDB.instance.database;
    final result = await db.query('productos');

    return result.map((e) => ProductoModel.fromJson(e)).toList();
  }
}

final productosDAO = ProductosDAO();