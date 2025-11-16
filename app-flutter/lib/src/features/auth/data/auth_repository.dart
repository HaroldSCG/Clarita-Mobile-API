import 'auth_api.dart';
import 'auth_local.dart';
import '../../../core/network/api_client.dart';

class AuthRepository {
  Future<bool> login(String correo, String password) async {
    final result = await authAPI.login(correo, password);

    final token = result["token"];
    final user = result["user"];

    apiClient.setToken(token);

    await authLocal.saveSession(token, user);
    return true;
  }

  Future<Map<String, dynamic>?> loadSession() async {
    final session = await authLocal.getSession();
    if (session == null) return null;

    apiClient.setToken(session["token"]);
    return session;
  }
}

final authRepository = AuthRepository();
