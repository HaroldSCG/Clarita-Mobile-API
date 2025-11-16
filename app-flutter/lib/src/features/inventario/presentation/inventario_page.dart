import 'package:flutter/material.dart';
import 'inventario_controller.dart';

class InventarioPage extends StatefulWidget {
  const InventarioPage({super.key});

  @override
  State<InventarioPage> createState() => _InventarioPageState();
}

class _InventarioPageState extends State<InventarioPage> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    await inventarioController.cargarProductos();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final c = inventarioController;

    return Scaffold(
      appBar: AppBar(title: const Text("Inventario")),
      body: c.loading
          ? const Center(child: CircularProgressIndicator())
          : c.error != null
              ? Center(child: Text("Error: ${c.error}"))
              : ListView.builder(
                  itemCount: c.productos.length,
                  itemBuilder: (_, i) {
                    final p = c.productos[i];
                    return ListTile(
                      title: Text(p.nombre),
                      subtitle: Text("Stock: ${p.stock}"),
                      trailing: Text("Q${p.precio}"),
                    );
                  },
                ),
    );
  }
}
