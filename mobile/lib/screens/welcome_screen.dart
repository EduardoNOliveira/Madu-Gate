import 'package:flutter/material.dart';

import '../models/auth_session.dart';
import '../services/session_store.dart';
import '../theme/app_theme.dart';
import '../widgets/brand_logo.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final List<String> _gateOptions = <String>[
    'Residência',
    'UFBA - Estacionamento Principal',
    'Condomínio',
  ];

  String _selectedGate = 'Residência';
  AuthSession? _session;

  @override
  void initState() {
    super.initState();
    SessionStore.instance.loadSession().then((session) {
      if (mounted) {
        setState(() => _session = session);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isWide = screenWidth >= 700;

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
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: 18),
                const Center(child: BrandLogo(iconSize: 106, textSize: 42)),
                const SizedBox(height: 10),
                const Text(
                  'Controle Inteligente\nde Acesso',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70, fontSize: 20, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 18),
                Card(
                  color: Colors.white.withValues(alpha: 0.08),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    child: Row(
                      children: <Widget>[
                        const Icon(Icons.place_outlined, color: Colors.white70),
                        const SizedBox(width: 10),
                        const Text('Portão:', style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w600)),
                        const SizedBox(width: 12),
                        Expanded(
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _selectedGate,
                              dropdownColor: const Color(0xFF112047),
                              style: const TextStyle(color: Colors.white),
                              iconEnabledColor: Colors.white,
                              items: _gateOptions
                                  .map((gate) => DropdownMenuItem<String>(value: gate, child: Text(gate, overflow: TextOverflow.ellipsis)))
                                  .toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() => _selectedGate = value);
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Align(
                  alignment: Alignment.center,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: isWide ? 420 : double.infinity),
                    child: SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          minimumSize: const Size.fromHeight(52),
                          backgroundColor: AppPalette.brandSecondary,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(builder: (_) => const LoginScreen()),
                          );
                        },
                        child: const Text('Entrar'),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.center,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: isWide ? 420 : double.infinity),
                    child: SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size.fromHeight(52),
                          foregroundColor: Colors.white,
                          side: const BorderSide(color: AppPalette.brandSecondary),
                        ),
                        onPressed: () => _handleGateAction(context),
                        child: const Text('Abrir Portão'),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 26),
                const Divider(color: Colors.white24),
                const SizedBox(height: 8),
                const Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: <Widget>[
                    _StatusCard(label: 'Servidor', status: 'Online', icon: Icons.cloud_done_rounded, ok: true),
                    _StatusCard(label: 'ESP32', status: 'Conectado', icon: Icons.memory_rounded, ok: true),
                    _StatusCard(label: 'Wi-Fi', status: '100%', icon: Icons.wifi_rounded, ok: true),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  _session?.canOpenGate == true ? 'Acesso aprovado • v0.1.0 Alpha' : 'v0.1.0 Alpha',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white54),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleGateAction(BuildContext context) async {
    final session = _session ?? await SessionStore.instance.loadSession();

    if (!context.mounted) {
      return;
    }

    if (session == null) {
      Navigator.of(context).push(
        MaterialPageRoute<void>(builder: (_) => const LoginScreen()),
      );
      return;
    }

    if (!session.canOpenGate) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Seu cadastro ainda está pendente de aprovação.')),
      );
      return;
    }

    await _showOpenGateDialog(context);
  }

  Future<void> _showOpenGateDialog(BuildContext context) async {
    int openSeconds = 3;
    bool opening = false;
    double progress = 0;
    String progressLabel = '';

    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setLocalState) {
            Future<void> runOpenFlow() async {
              setLocalState(() {
                opening = true;
                progress = 0.15;
                progressLabel = 'Abrindo...';
              });

              await Future<void>.delayed(const Duration(milliseconds: 450));
              if (!dialogContext.mounted) return;
              setLocalState(() => progress = 0.55);

              await Future<void>.delayed(Duration(seconds: openSeconds));
              if (!dialogContext.mounted) return;
              setLocalState(() {
                progress = 1;
                progressLabel = 'Portão acionado';
              });

              await Future<void>.delayed(const Duration(milliseconds: 600));
              if (dialogContext.mounted) {
                Navigator.of(dialogContext).pop(true);
              }
            }

            return AlertDialog(
              title: Text('Abrir ${_selectedGate == 'Residência' ? 'Portão Principal' : _selectedGate}?'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text('Tempo de acionamento'),
                  const SizedBox(height: 8),
                  SegmentedButton<int>(
                    segments: const <ButtonSegment<int>>[
                      ButtonSegment<int>(value: 2, label: Text('2 segundos')),
                      ButtonSegment<int>(value: 3, label: Text('3 segundos')),
                      ButtonSegment<int>(value: 5, label: Text('5 segundos')),
                    ],
                    selected: <int>{openSeconds},
                    onSelectionChanged: opening ? null : (selection) => setLocalState(() => openSeconds = selection.first),
                  ),
                  if (opening) ...<Widget>[
                    const SizedBox(height: 8),
                    LinearProgressIndicator(value: progress),
                    const SizedBox(height: 8),
                    Text(progressLabel),
                  ],
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: opening ? null : () => Navigator.of(dialogContext).pop(false),
                  child: const Text('Cancelar'),
                ),
                FilledButton(
                  onPressed: opening ? null : runOpenFlow,
                  child: const Text('Abrir'),
                ),
              ],
            );
          },
        );
      },
    );

    if (context.mounted && result == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Comando enviado para abrir ${_selectedGate == 'Residência' ? 'o Portão Principal' : _selectedGate}')),
      );
    }
  }
}

class _StatusCard extends StatelessWidget {
  const _StatusCard({required this.label, required this.status, required this.icon, required this.ok});

  final String label;
  final String status;
  final IconData icon;
  final bool ok;

  @override
  Widget build(BuildContext context) {
    final statusColor = ok ? Colors.greenAccent : Colors.redAccent;

    return SizedBox(
      width: 170,
      child: Card(
        color: Colors.white.withValues(alpha: 0.07),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(icon, size: 18, color: Colors.white70),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      label,
                      style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.w600),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: <Widget>[
                  Icon(Icons.circle, size: 9, color: statusColor),
                  const SizedBox(width: 6),
                  Text(status, style: TextStyle(color: statusColor)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
