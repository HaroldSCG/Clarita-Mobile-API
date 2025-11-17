import 'package:flutter/material.dart';

import '../data/rutas_entregas_api.dart';

class RutasEntregasController extends ChangeNotifier {
  bool loading = false;
  String? error;

  List<Map<String, dynamic>> rutas = [];
  List<Map<String, dynamic>> entregas = [];

  Future<void> cargarRutas() async {
    try {
      loading = true;
      error = null;
      notifyListeners();

      final data = await rutasEntregasAPI.getRutas();
      rutas = data.map((e) => Map<String, dynamic>.from(e)).toList();
    } catch (e) {
      error = e.toString();
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> cargarEntregas(int rutaId) async {
    try {
      loading = true;
      error = null;
      notifyListeners();

      final data = await rutasEntregasAPI.getEntregasByRuta(rutaId);
      entregas = data.map((e) => Map<String, dynamic>.from(e)).toList();
    } catch (e) {
      error = e.toString();
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}

final rutasEntregasController = RutasEntregasController();