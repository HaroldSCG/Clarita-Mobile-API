import 'package:flutter/material.dart';

import 'rutas_entregas_controller.dart';

class EntregasPage extends StatefulWidget {
  const EntregasPage({super.key});

  @override
  State<EntregasPage> createState() => _EntregasPageState();
}

class _EntregasPageState extends State<EntregasPage> {
  int? rutaId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    rutaId = ModalRoute.of(context)?.settings.arguments as int?;
    if (rutaId != null) {
      cargar();
    }
  }

  Future<void> cargar() async {
    await rutasEntregasController.cargarEntregas(rutaId!);
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final c = rutasEntregasController;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Entregas'),
      ),
      body: c.loading
          ? const Center(child: CircularProgressIndicator())
          : c.error != null
              ? Center(child: Text("Error: ${c.error}"))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: c.entregas.length,
                  itemBuilder: (_, i) {
                    final e = c.entregas[i];

                    return Card(
                      color: const Color(0xFF111111),
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: ListTile(
                        title: Text(
                          e['cliente'] ?? 'Cliente',
                          style: const TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          e['direccion'] ?? '',
                          style: const TextStyle(color: Colors.white54),
                        ),
                        trailing: Text(
                          e['estado'] ?? '',
                          style: const TextStyle(color: Colors.pinkAccent),
                        ),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/entrega/detalle',
                            arguments: e['id'],
                          );
                        },
                      ),
                    );
                  },
                ),
    );
  }
}