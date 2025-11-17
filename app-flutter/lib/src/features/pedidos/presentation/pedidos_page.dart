import 'package:flutter/material.dart';

import '../../../core/widgets/app_scaffold.dart';
import 'pedidos_controller.dart';
import '../widgets/pedido_card.dart';

class PedidosPage extends StatefulWidget {
  const PedidosPage({super.key});

  @override
  State<PedidosPage> createState() => _PedidosPageState();
}

class _PedidosPageState extends State<PedidosPage> {
  @override
  void initState() {
    super.initState();
    cargar();
  }

  Future<void> cargar() async {
    await pedidosController.cargar();
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final c = pedidosController;

    return AppScaffold(
      title: 'Pedidos',
      currentRoute: '/pedidos',
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: cargar,
        )
      ],
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFF111827),
                prefixIcon: const Icon(Icons.search, color: Colors.white70),
                hintText: 'Buscar pedido...',
                hintStyle: const TextStyle(color: Colors.white54),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (txt) {
                c.actualizarBusqueda(txt);
                setState(() {});
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: c.loading
                  ? const Center(
                      child: CircularProgressIndicator(
                          color: Color(0xFFFF4081)))
                  : c.error != null
                      ? Center(child: Text("Error: ${c.error}"))
                      : ListView.builder(
                          itemCount: c.visibles.length,
                          itemBuilder: (_, i) {
                            final p = c.visibles[i];
                            return PedidoCard(
                              pedido: p,
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  '/pedidos/detalle',
                                  arguments: p,
                                );
                              },
                            );
                          },
                        ),
            )
          ],
        ),
      ),
    );
  }
}
