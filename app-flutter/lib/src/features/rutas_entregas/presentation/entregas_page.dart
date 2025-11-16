import 'package:flutter/material.dart';
import '../presentation/rutas_entregas_controller.dart';

class EntregasPage extends StatefulWidget {
  const EntregasPage({super.key});

  @override
  State<EntregasPage> createState() => _EntregasPageState();
}

class _EntregasPageState extends State<EntregasPage> {
  Map<String, dynamic>? ruta;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ruta = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    cargar();
  }

  Future<void> cargar() async {
    if (ruta == null) return;
    await rutasEntregasController.cargarEntregas(ruta!['id']);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final c = rutasEntregasController;

    return Scaffold(
      appBar: AppBar(
        title: Text("Entregas - Ruta ${ruta?['nombre'] ?? ''}"),
      ),
      body: c.loadingEntregas
          ? const Center(child: CircularProgressIndicator())
          : c.errorEntregas != null
              ? Center(child: Text("Error: ${c.errorEntregas}"))
              : ListView.builder(
                  itemCount: c.entregas.length,
                  itemBuilder: (_, i) {
                    final entrega = c.entregas[i];

                    return Card(
                      child: ListTile(
                        title: Text(
                          "Entrega #${entrega['id']} - Pedido ${entrega['pedidoId']}",
                        ),
                        subtitle: Text(
                          "Estado: ${entrega['estadoEntrega']}",
                        ),
                        trailing: Icon(
                          entrega['estadoEntrega'] == 'entregado'
                              ? Icons.check_circle
                              : Icons.local_shipping,
                          color: entrega['estadoEntrega'] == 'entregado'
                              ? Colors.green
                              : Colors.orange,
                        ),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/entrega/detalle',
                            arguments: entrega,
                          );
                        },
                      ),
                    );
                  },
                ),
    );
  }
}
