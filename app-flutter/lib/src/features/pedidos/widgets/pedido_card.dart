import 'package:flutter/material.dart';

import '../../../core/models/pedido_model.dart';
import 'pedido_estado_chip.dart';

class PedidoCard extends StatelessWidget {
  final PedidoModel pedido;
  final VoidCallback onTap;

  const PedidoCard({super.key, required this.pedido, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF1A1A1A),
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: ListTile(
        onTap: onTap,
        title: Text(
          pedido.clienteNombre,
          style: const TextStyle(color: Colors.white),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              pedido.direccion,
              style: const TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 4),
            Text(
              'Código: ${pedido.codigo} · NIT: ${pedido.nit}',
              style: const TextStyle(color: Colors.white38, fontSize: 12),
            ),
          ],
        ),
        trailing: PedidoEstadoChip(estado: pedido.estado),
      ),
    );
  }
}
