import 'package:flutter/material.dart';

import 'screens/login_screen.dart';

void main() {
  runApp(const MaduGateApp());
}

class MaduGateApp extends StatelessWidget {
  const MaduGateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Madu Gate',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2563EB),
          primary: const Color(0xFF2563EB),
          secondary: const Color(0xFF0F172A),
        ),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}
