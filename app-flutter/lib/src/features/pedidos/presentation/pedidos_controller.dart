import '../data/pedidos_api.dart';
import '../../../core/models/pedido_model.dart';

class PedidosController {
  bool loading = false;
  String? error;

  List<PedidoModel> pedidos = [];
  List<PedidoModel> visibles = [];
  String filtro = '';

  Future<void> cargar() async {
    loading = true;
    error = null;

    try {
      final data = await pedidosAPI.getPedidos();
      pedidos = data;
      _aplicarFiltro();
    } catch (e) {
      error = e.toString();
      visibles = [];
    }

    loading = false;
  }

  void actualizarBusqueda(String texto) {
    filtro = texto.trim().toLowerCase();
    _aplicarFiltro();
  }

  void _aplicarFiltro() {
    if (filtro.isEmpty) {
      visibles = [...pedidos];
      return;
    }

    visibles = pedidos.where((p) {
      final target = filtro;
      return p.clienteNombre.toLowerCase().contains(target) ||
          p.direccion.toLowerCase().contains(target) ||
          p.estado.toLowerCase().contains(target) ||
          p.nit.toLowerCase().contains(target) ||
          p.codigo.toLowerCase().contains(target);
    }).toList();
  }
}

final pedidosController = PedidosController();
