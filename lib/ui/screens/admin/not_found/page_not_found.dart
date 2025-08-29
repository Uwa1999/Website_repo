import 'package:flutter/material.dart';

class NotFoundScreen extends StatelessWidget {
  static const String route = '/404';

  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/404.jpg', // Provide a friendly illustration here
                width: 800,
                height: 500,
                fit: BoxFit.contain,
              ),
              const Text(
                'Page Not Found',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'The page you are looking for doesn’t exist or has been moved.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
