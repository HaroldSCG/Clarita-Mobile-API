import '../../inventario/data/inventario_api.dart';
import '../../../core/storage/dao/productos_dao.dart';
import '../../../core/models/producto_model.dart';

class InventarioController {
  bool loading = false;
  String? error;
  List<ProductoModel> productos = [];

  Future<void> cargarProductos() async {
    loading = true;
    error = null;

    try {
      final data = await inventarioAPI.getProductos();

      productos = data
          .map((e) => ProductoModel.fromMap(e as Map<String, dynamic>))
          .toList();

      // guardar local
      await ProductosDao().replaceAll(productos);
    } catch (e) {
      error = e.toString();
    }

    loading = false;
  }
}

final inventarioController = InventarioController();
