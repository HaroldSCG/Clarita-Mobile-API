import '../../../core/network/api_client.dart';

class RutasEntregasAPI {
  Future<List<dynamic>> getRutas() async {
    final resp = await apiClient.get('/rutas');
    final data = resp['rutas'] ?? resp['data'] ?? resp;
    if (data is List) return data;
    return [];
  }

  Future<List<dynamic>> getEntregas() async {
    final resp = await apiClient.get('/entregas');
    final data = resp['entregas'] ?? resp['data'] ?? resp;
    if (data is List) return data;
    return [];
  }

  Future<List<dynamic>> getEntregasByRuta(int rutaId) async {
    final resp = await apiClient.get('/rutas/entregas/$rutaId');
    final data = resp['entregas'] ?? resp['data'] ?? [];
    if (data is List) return data;
    return [];
  }

  /// Detalle de una entrega específica
  Future<Map<String, dynamic>> getEntregaDetalle(int id) async {
    final resp = await apiClient.get('/entregas/$id');
    final detalle = resp['entrega'] ?? resp['detalle'] ?? resp;

    if (detalle is Map<String, dynamic>) {
      return detalle;
    }
    if (detalle is Map) {
      return Map<String, dynamic>.from(detalle);
    }
    return {};
  }
}

final rutasEntregasAPI = RutasEntregasAPI();
