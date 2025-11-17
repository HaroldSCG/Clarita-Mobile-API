class Env {
  /// Backend principal en Railway para la app móvil
  static const String apiBaseUrl =
      "https://clarita-mobile-api-production.up.railway.app/api/mobile";

  /// Timeout general para requests HTTP
  static const Duration timeout = Duration(seconds: 12);
}