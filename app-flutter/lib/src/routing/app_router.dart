import 'package:flutter/material.dart';

// Auth
import '../features/auth/presentation/login_page.dart';

// Home
import '../features/home/home_page.dart';

// Combustible
import '../features/combustible/presentation/combustible_page.dart';

// Inventario
import '../features/inventario/presentation/inventario_page.dart';

// Pedidos
import '../features/pedidos/presentation/pedidos_page.dart';
import '../features/pedidos/presentation/pedido_detalle_page.dart';
import '../core/models/pedido_model.dart';

// Rutas / Entregas
import '../features/rutas_entregas/presentation/rutas_entregas_page.dart';
import '../features/rutas_entregas/presentation/entregas_page.dart';
import '../features/rutas_entregas/presentation/entrega_detalle_page.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _page(const LoginPage());

      case '/home':
        return _page(const HomePage());

      /// --- Combustible ---
      case '/combustible':
        return _page(const CombustiblePage());

      /// --- Inventario ---
      case '/inventario':
        return _page(const InventarioPage());

      /// --- Pedidos ---
      case '/pedidos':
        return _page(const PedidosPage());

      case '/pedidos/detalle':
        final pedido = settings.arguments as PedidoModel;
        return _page(PedidoDetallePage(pedido: pedido));

      /// --- Rutas y Entregas ---
      case '/rutas':
        return _page(const RutasEntregasPage());

      case '/rutas/entregas':
        return _page(const EntregasPage(), arguments: settings.arguments);

      case '/entrega/detalle':
        return _page(const EntregaDetallePage(), arguments: settings.arguments);

      /// --- Ruta desconocida ---
      default:
        return _page(
          const Scaffold(
            body: Center(
              child: Text(
                'Ruta no encontrada',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        );
    }
  }

  static MaterialPageRoute _page(Widget page, {Object? arguments}) {
    return MaterialPageRoute(
      builder: (_) => page,
      settings: RouteSettings(arguments: arguments),
    );
  }
}
