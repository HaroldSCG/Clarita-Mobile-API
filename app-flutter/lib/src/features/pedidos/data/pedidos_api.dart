import '../../../core/network/api_client.dart';

class PedidosAPI {
  Future<List<dynamic>> getPedidos() async {
    final resp = await apiClient.get('/pedidos');
    return resp['pedidos'] ?? [];
  }
}

final pedidosAPI = PedidosAPI();
