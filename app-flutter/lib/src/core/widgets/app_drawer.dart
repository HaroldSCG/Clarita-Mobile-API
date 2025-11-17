import 'package:flutter/material.dart';
import '../../core/models/user_model.dart';
import '../../config/theme.dart';

class AppDrawer extends StatelessWidget {
  final UserModel? user;
  final String currentRoute;

  const AppDrawer({
    super.key,
    this.user,
    this.currentRoute = '/',
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: AppColors.background,
        child: Column(
          children: [
            _buildHeader(),
            _tile(context, Icons.home, "Inicio", "/home"),
            _tile(context, Icons.local_gas_station, "Combustible", "/combustible"),
            _tile(context, Icons.list_alt_rounded, "Reporte Combustible", "/reporte"),
            _tile(context, Icons.shopping_cart, "Ventas", "/ventas"),
            _tile(context, Icons.map, "Entregas", "/rutas"),
            _tile(context, Icons.person, "Usuario", "/usuario"),

            const Spacer(),

            ListTile(
              leading: const Icon(Icons.logout, color: Colors.redAccent),
              title: const Text("Cerrar sesión", style: TextStyle(color: Colors.redAccent)),
              onTap: () => Navigator.pushNamedAndRemoveUntil(context, "/", (_) => false),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return UserAccountsDrawerHeader(
      decoration: const BoxDecoration(color: AppColors.surface),
      accountName: Text(user?.nombre ?? "Usuario"),
      accountEmail: Text(user?.correo ?? "correo@clarita.com"),
      currentAccountPicture: const CircleAvatar(
        backgroundColor: AppColors.pink,
        child: Icon(Icons.person, color: Colors.white),
      ),
    );
  }

  Widget _tile(BuildContext context, IconData icon, String title, String route) {
    final selected = route == currentRoute;

    return ListTile(
      leading: Icon(icon, color: selected ? AppColors.pink : Colors.white70),
      title: Text(
        title,
        style: TextStyle(
          color: selected ? AppColors.pink : Colors.white,
          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      onTap: () {
        if (!selected) Navigator.pushReplacementNamed(context, route);
      },
    );
  }
}