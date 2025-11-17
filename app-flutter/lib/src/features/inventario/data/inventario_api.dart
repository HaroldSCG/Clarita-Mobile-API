import '../../../core/network/api_client.dart';

class InventarioAPI {
  Future<List<dynamic>> getAll() async {
    final resp = await apiClient.get("/inventario");
    return resp["data"] ?? [];
  }
}

final inventarioAPI = InventarioAPI();