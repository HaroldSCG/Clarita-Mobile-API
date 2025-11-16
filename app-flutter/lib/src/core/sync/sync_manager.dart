import '../network/api_client.dart';
import '../storage/dao/productos_dao.dart';
import '../storage/dao/pedidos_dao.dart';
import '../storage/dao/combustible_dao.dart';

class SyncManager {
  bool syncing = false;
  String? error;

  Future<void> syncAll() async {
    syncing = true;
    error = null;

    try {
      // === Productos ===
      final productos = await apiClient.get('/productos');
      await ProductosDao().replaceAll(productos['data']);

      // === Pedidos ===
      final pedidos = await apiClient.get('/pedidos');
      await PedidosDao().replaceAll(pedidos['data']);

      // === Combustible ===
      final combustible = await apiClient.get('/combustible');
      await CombustibleDao().replaceAll(combustible['data']);

    } catch (e) {
      error = e.toString();
    }

    syncing = false;
  }
}

final syncManager = SyncManager();
