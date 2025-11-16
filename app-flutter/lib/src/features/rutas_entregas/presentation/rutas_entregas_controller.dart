import '../data/rutas_entregas_api.dart';

class RutasEntregasController {
  // ----- Estado general -----
  bool loadingRutas = false;
  String? errorRutas;
  List<dynamic> rutas = [];

  // ----- Estado entregas -----
  bool loadingEntregas = false;
  String? errorEntregas;
  List<dynamic> entregas = [];

  // =====================================================
  // CARGAR TODAS LAS RUTAS
  // =====================================================
  Future<void> cargarRutas() async {
    loadingRutas = true;
    errorRutas = null;

    try {
      final data = await rutasEntregasAPI.getRutas();
      rutas = data;
    } catch (e) {
      errorRutas = e.toString();
    }

    loadingRutas = false;
  }

  // =====================================================
  // CARGAR ENTREGAS PARA UNA RUTA
  // =====================================================
  Future<void> cargarEntregas(int rutaId) async {
    loadingEntregas = true;
    errorEntregas = null;

    try {
      final data = await rutasEntregasAPI.getEntregasByRuta(rutaId);
      entregas = data;
    } catch (e) {
      errorEntregas = e.toString();
    }

    loadingEntregas = false;
  }

  // =====================================================
  // CONFIRMAR ENTREGA
  // =====================================================
  Future<bool> confirmarEntrega(int entregaId, Map<String, dynamic> body) async {
    try {
      await rutasEntregasAPI.confirmarEntrega(entregaId, body);
      return true;
    } catch (e) {
      errorEntregas = e.toString();
      return false;
    }
  }

  // =====================================================
  // REPORTAR FALLO
  // =====================================================
  Future<bool> reportarFallo(int entregaId, Map<String, dynamic> body) async {
    try {
      await rutasEntregasAPI.reportarFallo(entregaId, body);
      return true;
    } catch (e) {
      errorEntregas = e.toString();
      return false;
    }
  }
}

final rutasEntregasController = RutasEntregasController();
