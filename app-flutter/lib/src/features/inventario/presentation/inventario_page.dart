import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/widgets/app_scaffold.dart';
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
    inventarioController.load();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: inventarioController,
      child: Consumer<InventarioController>(
        builder: (context, c, _) {
          return AppScaffold(
            title: "Inventario",
            body: c.loading
                ? const Center(child: CircularProgressIndicator())
                : c.error != null
                    ? Center(
                        child: Text(
                          "Error: ${c.error}",
                          style: const TextStyle(color: Colors.red),
                        ),
                      )
                    : ListView.builder(
                        itemCount: c.items.length,
                        itemBuilder: (_, i) {
                          final p = c.items[i];
                          return Card(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            color: const Color(0xFF111827),
                            child: ListTile(
                              title: Text(
                                p.nombre,
                                style: const TextStyle(color: Colors.white),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Código: ${p.codigo}",
                                    style: const TextStyle(
                                        color: Colors.white70, fontSize: 12),
                                  ),
                                  Text(
                                    "Stock actual: ${p.stockActual} | Mínimo: ${p.stockMinimo}",
                                    style: const TextStyle(
                                        color: Colors.white70, fontSize: 12),
                                  ),
                                  if (p.categoria != null)
                                    Text(
                                      "Categoría: ${p.categoria}",
                                      style: const TextStyle(
                                          color: Colors.white70, fontSize: 12),
                                    ),
                                  if (p.proveedor != null)
                                    Text(
                                      "Proveedor: ${p.proveedor}",
                                      style: const TextStyle(
                                          color: Colors.white70, fontSize: 12),
                                    ),
                                ],
                              ),
                              trailing: Text(
                                "Q${p.precioVenta.toStringAsFixed(2)}",
                                style: const TextStyle(
                                  color: Color(0xFFFF4081),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
          );
        },
      ),
    );
  }
}
