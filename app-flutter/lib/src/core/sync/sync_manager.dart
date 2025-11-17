import 'dart:async';
import '../network/api_client.dart';
import '../storage/dao/combustible_dao.dart';
import '../storage/dao/pedidos_dao.dart';
import '../storage/dao/productos_dao.dart';
import '../models/combustible_model.dart';
import '../models/pedido_model.dart';
import '../models/producto_model.dart';

class SyncManager {
  bool syncing = false;
  String? lastError;

  /// Ejecuta TODA la sincronización global
  Future<void> syncAll() async {
    if (syncing) return;
    syncing = true;

    try {
      await Future.wait([
        syncProductos(),
        syncCombustible(),
        syncPedidos(),
      ]);
      lastError = null;
    } catch (e) {
      lastError = e.toString();
    } finally {
      syncing = false;
    }
  }

  /// Sincroniza inventario (productos)
  Future<void> syncProductos() async {
    try {
      final resp = await apiClient.get("/inventario");
      final lista = resp["productos"] ?? resp["data"] ?? [];

      for (var item in lista) {
        final modelo = ProductoModel.fromJson(item);
        await productosDAO.insert(modelo);
      }
    } catch (_) {}
  }

  /// Sincroniza combustible
  Future<void> syncCombustible() async {
    try {
      final resp = await apiClient.get("/combustible");
      final lista = resp["registros"] ?? resp["data"] ?? [];

      for (var item in lista) {
        await combustibleDAO.insert(CombustibleModel.fromJson(item));
      }
    } catch (_) {}
  }

  /// Sincroniza pedidos
  Future<void> syncPedidos() async {
    try {
      final resp = await apiClient.get("/pedidos");
      final lista = resp["pedidos"] ?? resp["data"] ?? [];

      for (var item in lista) {
        await pedidosDao.insert(PedidoModel.fromJson(item));
      }
    } catch (_) {}
  }
}

final syncManager = SyncManager();