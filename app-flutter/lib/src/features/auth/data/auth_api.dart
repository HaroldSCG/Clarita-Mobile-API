import '../../../core/network/api_client.dart';
import '../../../config/env.dart';

class AuthAPI {
  Future<Map<String, dynamic>> login(String correo, String password) async {
    return await apiClient.post(
      "/auth/login",
      {
        "correo": correo,
        "password": password,
      },
    );
  }

  Future<Map<String, dynamic>> me() async {
    return await apiClient.get("/auth/me");
  }
}

final authAPI = AuthAPI();
