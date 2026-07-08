import 'package:flutter/material.dart';

import 'screens/splash_screen.dart';
import 'theme/app_theme.dart';

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
      theme: buildAppTheme(),
      home: const SplashScreen(),
    );
  }
}
