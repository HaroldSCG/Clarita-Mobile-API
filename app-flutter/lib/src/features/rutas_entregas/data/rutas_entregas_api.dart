import '../../../core/network/api_client.dart';

class RutasEntregasAPI {
  Future<List<dynamic>> getRutas() async {
    final res = await apiClient.get('/rutas');
    return res["data"] ?? [];
  }

  Future<List<dynamic>> getEntregasByRuta(int rutaId) async {
    final res = await apiClient.get('/rutas/$rutaId/entregas');
    return res["data"] ?? [];
  }

  Future<void> confirmarEntrega(int entregaId, Map<String, dynamic> body) async {
    await apiClient.post('/entregas/$entregaId/confirmar', body);
  }

  Future<void> reportarFallo(int entregaId, Map<String, dynamic> body) async {
    await apiClient.post('/entregas/$entregaId/fallo', body);
  }
}

final rutasEntregasAPI = RutasEntregasAPI();
