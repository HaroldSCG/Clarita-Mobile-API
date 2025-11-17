import 'package:flutter/material.dart';
import '../../../core/models/pedido_model.dart';

class PedidoDetalleSection extends StatelessWidget {
  final PedidoModel pedido;

  const PedidoDetalleSection({
    super.key,
    required this.pedido,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          pedido.clienteNombre,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text('NIT: ${pedido.nit}'),
        const SizedBox(height: 8),
        Text('Dirección: ${pedido.direccion}'),
        const SizedBox(height: 8),
        Text('Estado: ${pedido.estado}'),
        const SizedBox(height: 8),
        Text('Fecha: ${pedido.fecha}'),
        const SizedBox(height: 16),
        const Divider(),
        const SizedBox(height: 8),
        const Text(
          'Detalle',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        // Aquí podrías renderizar pedido.detalles si lo necesitas.
      ],
    );
  }
}
