import '../../pedidos/data/pedidos_api.dart';
import '../../../core/storage/dao/pedidos_dao.dart';
import '../../../core/models/pedido_model.dart';

class PedidosController {
  bool loading = false;
  String? error;
  List<PedidoModel> lista = [];

  Future<void> cargar() async {
    loading = true;
    error = null;

    try {
      final data = await pedidosAPI.getPedidos();

      lista = data
          .map((e) => PedidoModel.fromMap(e as Map<String, dynamic>))
          .toList();

      await PedidosDao().replaceAll(lista);

    } catch (e) {
      error = e.toString();
    }

    loading = false;
  }
}

final pedidosController = PedidosController();
