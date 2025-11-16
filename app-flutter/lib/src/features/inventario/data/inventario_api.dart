import '../../../core/network/api_client.dart';

class InventarioAPI {
  Future<List<dynamic>> getProductos() async {
    final resp = await apiClient.get('/inventario');
    return resp['productos'] ?? [];
  }
}

final inventarioAPI = InventarioAPI();
