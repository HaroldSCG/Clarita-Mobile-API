import 'package:flutter/material.dart';
import '../presentation/rutas_entregas_controller.dart';

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
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final c = rutasEntregasController;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Rutas Asignadas"),
      ),

      // 👇 AQUI ESTABA EL ERROR: usabas c.loading y c.error
      body: c.loadingRutas
          ? const Center(child: CircularProgressIndicator())
          : c.errorRutas != null
              ? Center(child: Text("Error: ${c.errorRutas}"))
              : ListView.builder(
                  itemCount: c.rutas.length,
                  itemBuilder: (_, i) {
                    final ruta = c.rutas[i];

                    return Card(
                      child: ListTile(
                        title: Text("Ruta #${ruta['id']}  -  ${ruta['nombre']}"),
                        subtitle: Text(
                          "Estado: ${ruta['estado']} • Entregas: ${ruta['numeroEntregas']}",
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/rutas/entregas',
                            arguments: ruta,
                          );
                        },
                      ),
                    );
                  },
                ),
    );
  }
}
