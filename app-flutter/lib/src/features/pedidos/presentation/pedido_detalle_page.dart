import 'package:flutter/material.dart';

import '../../../core/models/pedido_model.dart';
import '../widgets/pedido_detalle_section.dart';

class PedidoDetallePage extends StatelessWidget {
  final PedidoModel pedido;

  const PedidoDetallePage({
    super.key,
    required this.pedido,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pedido ${pedido.codigo}'),
      ),
      body: PedidoDetalleSection(pedido: pedido),
    );
  }
}
