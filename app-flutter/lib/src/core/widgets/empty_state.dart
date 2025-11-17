import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  final String message;

  const EmptyState(this.message, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: const TextStyle(color: Colors.white54, fontSize: 16),
        textAlign: TextAlign.center,
      ),
    );
  }
}