import 'package:flutter/material.dart';
import 'combustible_controller.dart';

class CombustiblePage extends StatefulWidget {
  const CombustiblePage({super.key});

  @override
  State<CombustiblePage> createState() => _CombustiblePageState();
}

class _CombustiblePageState extends State<CombustiblePage> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    await combustibleController.cargar();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final c = combustibleController;

    return Scaffold(
      appBar: AppBar(title: const Text("Registro de Combustible")),
      body: c.loading
          ? const Center(child: CircularProgressIndicator())
          : c.error != null
              ? Center(child: Text("Error: ${c.error}"))
              : ListView.builder(
                  itemCount: c.lista.length,
                  itemBuilder: (_, i) {
                    final e = c.lista[i];
                    return ListTile(
                      title: Text("Camión ${e.camionId}"),
                      subtitle: Text("Litros: ${e.litros}"),
                      trailing: Text(e.fecha),
                    );
                  },
                ),
    );
  }
}
