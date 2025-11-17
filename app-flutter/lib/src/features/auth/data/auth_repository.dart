import 'auth_api.dart';
import 'auth_local.dart';
import '../../../core/models/user_model.dart';

class AuthRepository {
  Future<UserModel> login(String correo, String password) async {
    final resp = await authAPI.login(correo, password);

    if (resp["ok"] != true) {
      throw resp["message"] ?? "Credenciales inválidas";
    }

    final token = resp["token"];
    final user = UserModel.fromJson(resp["user"]);

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
        final user = UserModel.fromJson(resp["user"]);
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