import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import '../services/api_client.dart';
import '../services/auth_service.dart';
import '../services/session_store.dart';
import '../theme/app_theme.dart';
import '../widgets/brand_logo.dart';
import '../widgets/fade_slide_in.dart';
import 'app_shell_screen.dart';
import 'quick_access_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = true;
  bool _obscurePassword = true;
  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final apiClient = ApiClient(baseUrl: _resolveBaseUrl());
      final authService = AuthService(apiClient);

      final session = await authService.login(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      if (_rememberMe) {
        await SessionStore.instance.saveSession(session);
      }

      if (!mounted) return;

      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(builder: (_) => AppShellScreen(session: session)),
      );
    } catch (error) {
      setState(() {
        _error = error.toString().replaceFirst('Exception: ', '');
      });
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  String _resolveBaseUrl() {
    if (kIsWeb) {
      return 'http://127.0.0.1:3000';
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return 'http://10.0.2.2:3000';
      default:
        return 'http://127.0.0.1:3000';
    }
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
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 430),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const FadeSlideIn(
                      delay: Duration(milliseconds: 40),
                      child: BrandLogo(iconSize: 82, textSize: 42),
                    ),
                    const SizedBox(height: 8),
                    const FadeSlideIn(
                      delay: Duration(milliseconds: 140),
                      child: Text(
                        'Controle inteligente de acesso.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white70, fontSize: 15),
                      ),
                    ),
                    const SizedBox(height: 20),
                    FadeSlideIn(
                      delay: const Duration(milliseconds: 220),
                      child: _buildInput(
                        controller: _emailController,
                        hint: 'E-mail',
                        icon: Icons.alternate_email_rounded,
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    const SizedBox(height: 10),
                    FadeSlideIn(
                      delay: const Duration(milliseconds: 300),
                      child: _buildInput(
                        controller: _passwordController,
                        hint: 'Senha',
                        icon: Icons.lock_outline_rounded,
                        obscureText: _obscurePassword,
                        suffixIcon: IconButton(
                          onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                          icon: Icon(
                            _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                            color: Colors.white70,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    FadeSlideIn(
                      delay: const Duration(milliseconds: 360),
                      child: Row(
                        children: <Widget>[
                          Checkbox(
                            value: _rememberMe,
                            onChanged: (value) => setState(() => _rememberMe = value ?? false),
                            side: const BorderSide(color: Colors.white54),
                          ),
                          const Text('Lembrar-me', style: TextStyle(color: Colors.white70)),
                          const Spacer(),
                          TextButton(
                            onPressed: () {},
                            child: const Text('Esqueci minha senha', style: TextStyle(color: AppPalette.brandSecondary)),
                          )
                        ],
                      ),
                    ),
                    if (_error != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(_error!, style: const TextStyle(color: Colors.redAccent)),
                      ),
                    FadeSlideIn(
                      delay: const Duration(milliseconds: 420),
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                          backgroundColor: AppPalette.brandSecondary,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: _loading ? null : _submit,
                        child: _loading
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                              )
                            : const Text('Entrar'),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const FadeSlideIn(
                      delay: Duration(milliseconds: 500),
                      child: Row(
                        children: <Widget>[
                          Expanded(child: Divider(color: Colors.white24)),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Text('ou', style: TextStyle(color: Colors.white70)),
                          ),
                          Expanded(child: Divider(color: Colors.white24)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    FadeSlideIn(
                      delay: const Duration(milliseconds: 560),
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                          foregroundColor: Colors.white,
                          side: const BorderSide(color: AppPalette.brandSecondary),
                        ),
                        onPressed: () {},
                        child: const Text('Criar conta'),
                      ),
                    ),
                    const SizedBox(height: 10),
                    FadeSlideIn(
                      delay: const Duration(milliseconds: 620),
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(builder: (_) => const QuickAccessScreen()),
                          );
                        },
                        child: const Text('Acesso rápido (biometria)', style: TextStyle(color: AppPalette.brandSecondary)),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const FadeSlideIn(
                      delay: Duration(milliseconds: 700),
                      child: Text(
                        'v0.1.0 Alpha',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white38),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInput({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white54),
        prefixIcon: Icon(icon, color: Colors.white70),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: AppPalette.darkCard,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white24),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppPalette.brandSecondary),
        ),
      ),
    );
  }
}
