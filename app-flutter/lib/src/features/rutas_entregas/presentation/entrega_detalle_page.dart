import 'package:flutter/material.dart';

class EntregaDetallePage extends StatelessWidget {
  const EntregaDetallePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Recibir entrega enviada desde la pantalla anterior
    final entrega =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (entrega == null) {
      return const Scaffold(
        body: Center(child: Text("Entrega no encontrada")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Entrega #${entrega['id']}"),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              "Detalles del Pedido",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),

            _detalle("Pedido ID", entrega["pedidoId"]),
            _detalle("Estado", entrega["estadoEntrega"]),
            _detalle("Dirección", entrega["direccionEntrega"] ?? "No definida"),
            _detalle("Persona que recibe", entrega["personaRecibe"] ?? "No definido"),
            _detalle("Teléfono", entrega["telefonoEntrega"] ?? "No definido"),
            _detalle("Instrucciones", entrega["instruccionesEspeciales"] ?? "Ninguna"),

            const Divider(height: 40),

            Text(
              "Ubicación destino",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),

            _detalle("Latitud", entrega["latitudDestino"]?.toString() ?? "-"),
            _detalle("Longitud", entrega["longitudDestino"]?.toString() ?? "-"),

            const Divider(height: 40),

            Text(
              "Estado de seguimiento",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),

            _detalle("Fecha salida", entrega["fechaSalida"] ?? "-"),
            _detalle("Entrega real", entrega["fechaEntregaReal"] ?? "-"),
            _detalle("Motivo fallo", entrega["motivoFallo"] ?? "-"),

            const SizedBox(height: 40),

            // Botón para actualizar estado (conectaremos al backend más adelante)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Función pendiente")),
                  );
                },
                child: const Text("Actualizar estado de entrega"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _detalle(String titulo, dynamic valor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text(
            "$titulo: ",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(valor.toString()),
          ),
        ],
      ),
    );
  }
}
