import '../../../core/network/api_client.dart';
import '../../../core/models/pedido_model.dart';

class PedidosAPI {
  Future<List<PedidoModel>> getPedidos() async {
    final resp = await apiClient.get('/pedidos');
    final data = resp['pedidos'] ?? resp['data'] ?? resp['lista'] ?? [];

    if (data is List) {
      return data
          .map((e) => PedidoModel.fromJson(
              Map<String, dynamic>.from(e as Map<dynamic, dynamic>)))
          .toList();
    }

    return [];
  }

  Future<Map<String, dynamic>> getPedidoById(int id) async {
    final resp = await apiClient.get('/pedidos/$id');

    final pedido = resp['pedido'];
    if (pedido is Map) {
      final map = Map<String, dynamic>.from(pedido);
      map['detalles'] =
          (resp['detalles'] is List) ? resp['detalles'] : <dynamic>[];
      return map;
    }
    return resp;
  }
}

final pedidosAPI = PedidosAPI();
