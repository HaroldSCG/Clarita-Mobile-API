import '../data/auth_repository.dart';
import '../domain/auth_state.dart';

class LoginController {
  Future<bool> login(String correo, String password) async {
    try {
      authState.startLoading();
      final user = await authRepository.login(correo, password);
      authState.setUser(user);
      return true;
    } catch (e) {
      authState.setError(e.toString());
      return false;
    }
  }

  Future<bool> restore() async {
    try {
      final user = await authRepository.restoreSession();
      if (user != null) {
        authState.setUser(user);
        return true;
      }
      return false;
    } catch (_) {
      return false;
    }
  }

  void logout() {
    authRepository.logout();
    authState.logout();
  }
}

final loginController = LoginController();