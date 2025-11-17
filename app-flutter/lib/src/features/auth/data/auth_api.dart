import '../../../core/network/api_client.dart';

class AuthAPI {
  Future<Map<String, dynamic>> login(String correo, String password) async {
    final resp = await apiClient.post(
      "/api/mobile/auth/login",
      {
        "correo": correo,
        "password": password,
      },
    );
    return resp;
  }

  Future<Map<String, dynamic>> me() async {
    return await apiClient.get("/api/mobile/auth/me");
  }
}

final authAPI = AuthAPI();