import 'package:flutter/material.dart';

import 'config/theme.dart';
import 'routing/app_router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Distribuidora Clarita',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: '/',
    );
  }
}