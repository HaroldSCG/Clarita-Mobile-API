import 'package:flutter/material.dart';
import '../../../config/theme.dart';
import '../domain/auth_state.dart';
import '../presentation/login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final correoCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  bool loading = false;

  Future<void> _doLogin() async {
    setState(() => loading = true);

    final ok = await loginController.login(
      correoCtrl.text.trim(),
      passCtrl.text.trim(),
    );

    if (!mounted) return;

    setState(() => loading = false);

    if (ok) {
      // Ir al home
      if (mounted) {
        Navigator.pushReplacementNamed(context, "/home");
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(authState.error ?? "Error en login")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          width: 350,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Distribuidora Clarita",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              TextField(
                controller: correoCtrl,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: "Correo",
                ),
              ),

              const SizedBox(height: 16),
              TextField(
                controller: passCtrl,
                obscureText: true,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: "Contraseña",
                ),
              ),

              const SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: loading ? null : _doLogin,
                  child: loading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Iniciar Sesión"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
