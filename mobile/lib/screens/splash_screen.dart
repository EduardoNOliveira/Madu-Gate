import 'dart:async';

import 'package:flutter/material.dart';

import '../services/session_store.dart';
import '../theme/app_theme.dart';
import '../widgets/brand_logo.dart';
import '../widgets/fade_slide_in.dart';
import 'app_shell_screen.dart';
import 'welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 1800), () async {
      if (!mounted) {
        return;
      }

      final session = await SessionStore.instance.loadSession();
      if (!mounted) {
        return;
      }

      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(builder: (_) => session == null ? const WelcomeScreen() : AppShellScreen(session: session)),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[AppPalette.darkBg, Color(0xFF031332)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Spacer(),
                const FadeSlideIn(
                  delay: Duration(milliseconds: 120),
                  child: BrandLogo(iconSize: 86, textSize: 42),
                ),
                const SizedBox(height: 10),
                const FadeSlideIn(
                  delay: Duration(milliseconds: 240),
                  child: Text(
                    'Controle inteligente de acesso.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70, fontSize: 15),
                  ),
                ),
                const Spacer(),
                const FadeSlideIn(
                  delay: Duration(milliseconds: 380),
                  child: _LoadingLine(),
                ),
                const SizedBox(height: 14),
                const FadeSlideIn(
                  delay: Duration(milliseconds: 520),
                  child: Text(
                    'Carregando...',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppPalette.brandSecondary),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LoadingLine extends StatelessWidget {
  const _LoadingLine();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(99),
      child: const LinearProgressIndicator(
        minHeight: 4,
        backgroundColor: Color(0x332ED4FF),
        valueColor: AlwaysStoppedAnimation<Color>(AppPalette.brandSecondary),
      ),
    );
  }
}
