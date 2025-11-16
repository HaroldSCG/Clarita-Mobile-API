import 'package:flutter/material.dart';
import '../../../core/network/api_client.dart';
import '../data/auth_api.dart';

class LoginController {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  Future<bool> login() async {
    try {
      final email = emailCtrl.text.trim();
      final pass = passCtrl.text.trim();

      final res = await authAPI.login(email, pass);

      // El backend devuelve: { token: "...", user: {...} }
      if (res.containsKey('token')) {
        apiClient.setToken(res['token']);
        return true;
      }

      return false;

    } catch (e) {
      print("Error login: $e");
      return false;
    }
  }

  void dispose() {
    emailCtrl.dispose();
    passCtrl.dispose();
  }
}

final loginController = LoginController();
