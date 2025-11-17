import 'package:flutter/material.dart';

import '../data/rutas_entregas_api.dart';

class EntregaDetallePage extends StatefulWidget {
  const EntregaDetallePage({super.key});

  @override
  State<EntregaDetallePage> createState() => _EntregaDetallePageState();
}

class _EntregaDetallePageState extends State<EntregaDetallePage> {
  Map<String, dynamic>? entrega;
  bool loading = true;

  Future<void> cargar(int id) async {
    final data = await rutasEntregasAPI.getEntregaDetalle(id);
    entrega = data;
    loading = false;
    if (mounted) setState(() {});
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final id = ModalRoute.of(context)?.settings.arguments as int?;
    if (id != null) cargar(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de entrega'),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : entrega == null
              ? const Center(child: Text("No se encontró información"))
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: ListView(
                    children: [
                      Text(
                        entrega!['cliente'] ?? '',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(entrega!['direccion'] ?? ''),
                      const SizedBox(height: 20),
                      Text("Estado: ${entrega!['estado']}"),
                      Text("Total: Q${entrega!['total'] ?? 0}"),
                      const SizedBox(height: 20),
                      const Text(
                        "Productos",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const SizedBox(height: 10),
                      ...(entrega!['productos'] as List<dynamic>? ?? []).map(
                        (p) => Card(
                          color: const Color(0xFF111111),
                          child: ListTile(
                            title: Text(
                              p['nombre'] ?? '',
                              style: const TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              "Cantidad: ${p['cantidad']}",
                              style: const TextStyle(color: Colors.white70),
                            ),
                            trailing: Text(
                              "Q${p['precio']}",
                              style: const TextStyle(
                                  color: Colors.pinkAccent, fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}