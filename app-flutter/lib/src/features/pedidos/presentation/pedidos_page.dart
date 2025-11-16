import 'package:flutter/material.dart';
import 'pedidos_controller.dart';

class PedidosPage extends StatefulWidget {
  const PedidosPage({super.key});

  @override
  State<PedidosPage> createState() => _PedidosPageState();
}

class _PedidosPageState extends State<PedidosPage> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    await pedidosController.cargar();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final c = pedidosController;

    return Scaffold(
      appBar: AppBar(title: const Text("Pedidos")),
      body: c.loading
          ? const Center(child: CircularProgressIndicator())
          : c.error != null
              ? Center(child: Text("Error: ${c.error}"))
              : ListView.builder(
                  itemCount: c.lista.length,
                  itemBuilder: (_, i) {
                    final p = c.lista[i];
                    return ListTile(
                      title: Text("Pedido #${p.id}"),
                      subtitle: Text("Cliente: ${p.cliente}"),
                      trailing: Text("Total: Q${p.total}"),
                    );
                  },
                ),
    );
  }
}
