import 'package:flutter/material.dart';

class PedidoEstadoChip extends StatelessWidget {
  final String estado;
  const PedidoEstadoChip({super.key, required this.estado});

  @override
  Widget build(BuildContext context) {
    final e = estado.toLowerCase();

    Color bg;
    Color fg;
    String label;

    if (e.contains('cancel')) {
      bg = Colors.redAccent.withValues(alpha: 0.2);
      fg = Colors.white;
      label = 'CANCELADO';
    } else if (e.contains('entre')) {
      bg = Colors.green.withValues(alpha: 0.2);
      fg = Colors.white;
      label = 'ENTREGADO';
    } else if (e.contains('proc') || e.contains('camino')) {
      bg = Colors.blue.withValues(alpha: 0.2);
      fg = Colors.white;
      label = 'EN PROCESO';
    } else {
      bg = Colors.amberAccent.withValues(alpha: 0.3);
      fg = Colors.black87;
      label = 'PENDIENTE';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(18)),
      child: Text(label, style: TextStyle(color: fg, fontWeight: FontWeight.bold)),
    );
  }
}