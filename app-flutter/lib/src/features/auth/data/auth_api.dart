import '../../../core/network/api_client.dart';

class AuthAPI {
  Future<Map<String, dynamic>> login(String correo, String password) async {
    final result = await apiClient.post(
      "/auth/login",
      {
        "correo": correo,
        "password": password,
      },
    );

    return result;
  }

  Future<Map<String, dynamic>> me() async {
    final result = await apiClient.get("/auth/me");
    return result;
  }
}

final authAPI = AuthAPI();
