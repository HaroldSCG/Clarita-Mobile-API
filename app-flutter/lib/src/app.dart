import 'package:flutter/material.dart';
import 'routing/app_router.dart';
import 'config/theme.dart';
import 'features/auth/data/auth_repository.dart';
import 'features/auth/domain/auth_state.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  String initialRoute = '/';

  @override
  void initState() {
    super.initState();
    _loadSession();
  }

  Future<void> _loadSession() async {
    final session = await authRepository.loadSession();

    if (session != null) {
      authState.loggedIn = true;
      initialRoute = '/home';
    }

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Distribuidora Clarita',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
