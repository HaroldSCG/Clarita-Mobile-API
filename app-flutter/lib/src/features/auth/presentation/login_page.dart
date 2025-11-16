import 'package:flutter/material.dart';
import '../../../features/auth/presentation/login_controller.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool loading = false;
  String? errorMsg;

  Future<void> doLogin() async {
    setState(() {
      loading = true;
      errorMsg = null;
    });

    final ok = await loginController.login();

    if (!mounted) return;

    if (ok) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      setState(() {
        errorMsg = "Credenciales incorrectas";
      });
    }

    setState(() => loading = false);
  }

  @override
  void dispose() {
    loginController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png',
                height: 120,
              ),
              const SizedBox(height: 30),

              TextField(
                controller: loginController.emailCtrl,
                decoration: const InputDecoration(
                  labelText: 'Correo',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: loginController.passCtrl,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Contraseña',
                  border: OutlineInputBorder(),
                ),
              ),

              if (errorMsg != null) ...[
                const SizedBox(height: 20),
                Text(
                  errorMsg!,
                  style: const TextStyle(color: Colors.red),
                ),
              ],

              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: loading ? null : doLogin,
                child: loading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Iniciar Sesión"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
