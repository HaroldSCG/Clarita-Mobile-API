import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Panel Principal")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          children: [

            _menuButton(
              context: context,
              label: "Inventario",
              route: "/inventario",
              icon: Icons.inventory_2_outlined,
            ),

            _menuButton(
              context: context,
              label: "Combustible",
              route: "/combustible",
              icon: Icons.local_gas_station_outlined,
            ),

            _menuButton(
              context: context,
              label: "Pedidos",
              route: "/pedidos",
              icon: Icons.receipt_long_outlined,
            ),

            _menuButton(
              context: context,
              label: "Rutas",
              route: "/rutas",
              icon: Icons.route_outlined,
            ),

          ],
        ),
      ),
    );
  }

  Widget _menuButton({
    required BuildContext context,
    required String label,
    required String route,
    required IconData icon,
  }) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, route),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 45),
              const SizedBox(height: 10),
              Text(label, style: const TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
