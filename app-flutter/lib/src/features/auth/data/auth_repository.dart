import 'auth_api.dart';
import 'auth_local.dart';
import '../../../core/models/user_model.dart';

class AuthRepository {
  Future<UserModel> login(String correo, String password) async {
    final resp = await authAPI.login(correo, password);

    if (resp["ok"] != true) {
      throw resp["message"] ?? "Credenciales inválidas";
    }

    // Extraer correctamente la estructura del backend
    final data = resp["data"] ?? {};

    final token = data["token"];
    final userJson = data["user"];

    if (token == null || userJson == null) {
      throw "Respuesta inválida del servidor";
    }

    final user = UserModel.fromJson(userJson);

    await authLocal.saveToken(token);
    await authLocal.saveUser(user.toJson());

    return user;
  }

  Future<UserModel?> restoreSession() async {
    final token = await authLocal.getToken();
    if (token == null) return null;

    try {
      final resp = await authAPI.me();

      if (resp["ok"] == true) {

        final data = resp["data"] ?? {};
        final userJson = data["user"];

        if (userJson == null) return null;

        final user = UserModel.fromJson(userJson);

        await authLocal.saveUser(user.toJson());
        return user;
      }
    } catch (_) {}

    return null;
  }

  Future<void> logout() async {
    await authLocal.deleteToken();
  }
}

final authRepository = AuthRepository();