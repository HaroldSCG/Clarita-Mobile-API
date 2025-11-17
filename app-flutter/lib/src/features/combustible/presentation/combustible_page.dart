import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../presentation/combustible_controller.dart';
import '../../../core/widgets/app_scaffold.dart';

class CombustiblePage extends StatefulWidget {
  const CombustiblePage({super.key});

  @override
  State<CombustiblePage> createState() => _CombustiblePageState();
}

class _CombustiblePageState extends State<CombustiblePage> {
  @override
  void initState() {
    super.initState();
    combustibleController.load();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: combustibleController,
      child: Consumer<CombustibleController>(
        builder: (_, c, __) {
          return AppScaffold(
            title: "Combustible",
            body: c.loading
                ? const Center(child: CircularProgressIndicator())
                : c.error != null
                    ? Center(
                        child: Text(
                        "Error: ${c.error}",
                        style: const TextStyle(color: Colors.red),
                      ))
                    : ListView.builder(
                        padding: const EdgeInsets.all(12),
                        itemCount: c.items.length,
                        itemBuilder: (context, i) {
                          final item = c.items[i];
                          return Card(
                            child: ListTile(
                              title: Text("Camión ${item.camionId}"),
                              subtitle: Text(
                                "${item.litros} litros | ${item.gasolinera}\n${item.fechaCarga}",
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