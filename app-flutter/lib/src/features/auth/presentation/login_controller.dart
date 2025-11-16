import 'package:flutter/material.dart';

import '../data/auth_repository.dart';
import '../domain/auth_state.dart';

class LoginController {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  // referencia al estado global de auth
  final AuthState _state = authState;

  Future<bool> login() async {
    _state.loading = true;

    final correo = emailCtrl.text.trim();
    final password = passCtrl.text.trim();

    if (correo.isEmpty || password.isEmpty) {
      _state.loading = false;
      return false;
    }

    try {
      final ok = await authRepository.login(correo, password);
      _state.loggedIn = ok;
      return ok;
    } catch (_) {
      return false;
    } finally {
      _state.loading = false;
    }
  }

  void dispose() {
    emailCtrl.dispose();
    passCtrl.dispose();
  }
}

// instancia global
final loginController = LoginController();
