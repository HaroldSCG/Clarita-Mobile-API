import 'package:flutter/material.dart';

import '../../../core/widgets/app_scaffold.dart';
import 'rutas_entregas_controller.dart';

class RutasEntregasPage extends StatefulWidget {
  const RutasEntregasPage({super.key});

  @override
  State<RutasEntregasPage> createState() => _RutasEntregasPageState();
}

class _RutasEntregasPageState extends State<RutasEntregasPage> {
  @override
  void initState() {
    super.initState();
    cargar();
  }

  Future<void> cargar() async {
    await rutasEntregasController.cargarRutas();
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final c = rutasEntregasController;

    return AppScaffold(
      title: 'Rutas de entrega',
      currentRoute: '/rutas',
      actions: [
        IconButton(icon: const Icon(Icons.refresh), onPressed: cargar),
      ],
      body: c.loading
          ? const Center(child: CircularProgressIndicator())
          : c.error != null
              ? Center(child: Text("Error: ${c.error}"))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: c.rutas.length,
                  itemBuilder: (_, i) {
                    final ruta = c.rutas[i];

                    return Card(
                      color: const Color(0xFF1A1A1A),
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                      child: ListTile(
                        title: Text(
                          ruta['nombre'] ?? 'Ruta',
                          style: const TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          'Entregas: ${ruta['totalEntregas'] ?? 0}',
                          style: const TextStyle(color: Colors.white54),
                        ),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/rutas/entregas',
                            arguments: ruta['id'],
                          );
                        },
                      ),
                    );
                  },
                ),
    );
  }
}