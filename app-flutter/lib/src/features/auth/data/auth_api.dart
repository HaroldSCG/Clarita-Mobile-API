import '../../../core/network/api_client.dart';

class AuthAPI {
  Future<Map<String, dynamic>> login(String correo, String password) async {
    final resp = await apiClient.post(
      "/mobile/auth/login",
      {
        "correo": correo,
        "password": password,
      },
    );
    return resp;
  }

  Future<Map<String, dynamic>> me() async {
    return await apiClient.get("/mobile/auth/me");
  }
}

final authAPI = AuthAPI();