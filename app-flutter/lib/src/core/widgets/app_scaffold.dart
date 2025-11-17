import 'package:flutter/material.dart';
import 'app_drawer.dart';

class AppScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final Widget? floatingActionButton;
  final List<Widget>? actions;
  final String currentRoute;

  const AppScaffold({
    super.key,
    required this.title,
    required this.body,
    this.floatingActionButton,
    this.actions,
    this.currentRoute = '/',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: actions,
      ),
      drawer: AppDrawer(currentRoute: currentRoute),
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}