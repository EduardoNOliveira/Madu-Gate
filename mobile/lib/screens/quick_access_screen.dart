import 'package:flutter/material.dart';

import '../services/session_store.dart';
import '../theme/app_theme.dart';
import '../widgets/brand_logo.dart';
import '../widgets/fade_slide_in.dart';
import 'app_shell_screen.dart';

class QuickAccessScreen extends StatelessWidget {
  const QuickAccessScreen({super.key});

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
            padding: const EdgeInsets.all(24),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 20),
                const FadeSlideIn(
                  delay: Duration(milliseconds: 80),
                  child: BrandLogo(iconSize: 74, showName: false),
                ),
                const SizedBox(height: 12),
                const FadeSlideIn(
                  delay: Duration(milliseconds: 160),
                  child: Text(
                    'Acesso rápido',
                    style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 8),
                const FadeSlideIn(
                  delay: Duration(milliseconds: 220),
                  child: Text(
                    'Use sua biometria para entrar',
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
                const Spacer(),
                const FadeSlideIn(
                  delay: Duration(milliseconds: 300),
                  offsetY: 0.04,
                  child: _FingerprintTarget(),
                ),
                const Spacer(),
                FadeSlideIn(
                  delay: const Duration(milliseconds: 420),
                  child: SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: AppPalette.brandSecondary,
                        foregroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(52),
                      ),
                      onPressed: () async {
                        final session = await SessionStore.instance.loadSession();
                        if (!context.mounted) {
                          return;
                        }

                        if (session == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Faça login uma vez para habilitar o acesso rápido.')),
                          );
                          return;
                        }

                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute<void>(builder: (_) => AppShellScreen(session: session)),
                        );
                      },
                      child: const Text('Entrar com biometria'),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                FadeSlideIn(
                  delay: const Duration(milliseconds: 500),
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Usar senha', style: TextStyle(color: AppPalette.brandSecondary)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FingerprintTarget extends StatefulWidget {
  const _FingerprintTarget();

  @override
  State<_FingerprintTarget> createState() => _FingerprintTargetState();
}

class _FingerprintTargetState extends State<_FingerprintTarget> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1800))..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        final pulse = 1 + (_controller.value * 0.05);
        return Transform.scale(
          scale: pulse,
          child: Container(
            width: 210,
            height: 210,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0x3342B9FF), width: 2),
              gradient: const RadialGradient(
                colors: <Color>[Color(0x2242B9FF), Color(0x00000000)],
              ),
            ),
            child: const Center(
              child: Icon(Icons.fingerprint_rounded, size: 108, color: AppPalette.brandSecondary),
            ),
          ),
        );
      },
    );
  }
}
