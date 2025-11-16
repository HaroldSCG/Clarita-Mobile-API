import 'package:flutter/material.dart';

// === IMPORTS DE PÁGINAS ===

// Login
import '../features/auth/presentation/login_page.dart';

// Home
import '../features/home/home_page.dart';

// Inventario
import '../features/inventario/presentation/inventario_page.dart';

// Combustible
import '../features/combustible/presentation/combustible_page.dart';

// Pedidos
import '../features/pedidos/presentation/pedidos_page.dart';

// Rutas / Entregas
import '../features/rutas_entregas/presentation/rutas_entregas_page.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {

      case '/':
        return MaterialPageRoute(builder: (_) => const LoginPage());

      case '/home':
        return MaterialPageRoute(builder: (_) => const HomePage());

      case '/inventario':
        return MaterialPageRoute(builder: (_) => const InventarioPage());

      case '/combustible':
        return MaterialPageRoute(builder: (_) => const CombustiblePage());

      case '/pedidos':
        return MaterialPageRoute(builder: (_) => const PedidosPage());

      case '/rutas':
        return MaterialPageRoute(builder: (_) => const RutasEntregasPage());

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text("Ruta no encontrada")),
          ),
        );
    }
  }
}
