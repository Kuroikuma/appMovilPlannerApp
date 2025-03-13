import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  final Object error;

  const ErrorView({required this.error, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 48, color: Colors.red),
          const SizedBox(height: 16),
          Text(error.toString()),
        ],
      ),
    );
  }
}
