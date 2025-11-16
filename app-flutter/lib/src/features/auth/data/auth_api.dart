import '../../../config/env.dart';
import '../../../core/network/api_client.dart';

class AuthAPI {

  Future<Map<String, dynamic>> login(String email, String password) async {
    return await apiClient.post(
      "/auth/login",
      {
        "email": email,
        "password": password,
      },
    );
  }

  Future<Map<String, dynamic>> me() async {
    return await apiClient.get("/auth/me");
  }
}

final authAPI = AuthAPI();
