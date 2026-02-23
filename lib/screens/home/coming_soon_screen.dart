import 'package:flutter/material.dart';

class ComingSoonScreen extends StatelessWidget {
  final String label;

  const ComingSoonScreen({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Center(
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1B1B2F),
          ),
        ),
      ),
    );
  }
}
