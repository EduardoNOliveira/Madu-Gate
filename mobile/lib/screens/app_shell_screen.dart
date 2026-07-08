import 'package:flutter/material.dart';

import '../models/auth_session.dart';
import '../services/session_store.dart';
import '../theme/app_theme.dart';
import '../widgets/brand_logo.dart';
import '../widgets/fade_slide_in.dart';
import 'welcome_screen.dart';

class AppShellScreen extends StatefulWidget {
  const AppShellScreen({super.key, this.session});

  final AuthSession? session;

  @override
  State<AppShellScreen> createState() => _AppShellScreenState();
}

class _AppShellScreenState extends State<AppShellScreen> {
  int _currentIndex = 0;
  AuthSession? _session;

  @override
  void initState() {
    super.initState();
    _session = widget.session;
    if (_session == null) {
      SessionStore.instance.loadSession().then((session) {
        if (mounted) {
          setState(() => _session = session);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      _HomeDashboardPage(session: _session),
      const _AccessHistoryPage(),
      const _DevicePage(),
      _AccountPage(session: _session),
    ];

    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) => setState(() => _currentIndex = index),
        destinations: const <NavigationDestination>[
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Início'),
          NavigationDestination(icon: Icon(Icons.list_alt_outlined), selectedIcon: Icon(Icons.list_alt), label: 'Acessos'),
          NavigationDestination(icon: Icon(Icons.developer_board_outlined), selectedIcon: Icon(Icons.developer_board), label: 'Dispositivos'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Conta'),
        ],
      ),
    );
  }
}

class _HomeDashboardPage extends StatelessWidget {
  const _HomeDashboardPage({required this.session});

  final AuthSession? session;

  @override
  Widget build(BuildContext context) {
    final userName = session?.userName.trim();
    final firstName = userName == null || userName.isEmpty ? 'Usuário' : userName.split(' ').first;

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          Row(
            children: <Widget>[
              const BrandLogo(showName: false, iconSize: 34, center: false, dark: false),
              const SizedBox(width: 8),
              RichText(
                text: const TextSpan(
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                  children: <TextSpan>[
                    TextSpan(text: 'Madu ', style: TextStyle(color: Color(0xFF222B3A), fontWeight: FontWeight.w400)),
                    TextSpan(text: 'Gate', style: TextStyle(color: AppPalette.brandSecondary)),
                  ],
                ),
              ),
              const Spacer(),
              IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none_rounded)),
            ],
          ),
          const SizedBox(height: 18),
          FadeSlideIn(
            delay: const Duration(milliseconds: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Olá $firstName', style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w700)),
                const SizedBox(height: 6),
                Text(
                  session?.canOpenGate == true ? 'Portão Principal autorizado para este dispositivo.' : 'Aguardando aprovação de acesso.',
                  style: const TextStyle(color: Color(0xFF5B6472)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          const FadeSlideIn(
            delay: Duration(milliseconds: 100),
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.sensor_door_rounded, color: Colors.green),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Portão Principal', style: TextStyle(fontWeight: FontWeight.w700)),
                          SizedBox(height: 4),
                          Text('Última abertura 08:15', style: TextStyle(color: Color(0xFF5B6472))),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 18),
          FadeSlideIn(
            delay: const Duration(milliseconds: 140),
            offsetY: 0.04,
            child: Center(
              child: _OpenGateButton(enabled: session?.canOpenGate == true),
            ),
          ),
          const SizedBox(height: 12),
          FadeSlideIn(
            delay: const Duration(milliseconds: 180),
            child: Text(
              session?.canOpenGate == true ? 'Toque para abrir' : 'Seu perfil ainda não pode abrir o portão',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Color(0xFF5B6472)),
            ),
          ),
          const SizedBox(height: 18),
          const FadeSlideIn(
            delay: Duration(milliseconds: 240),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                _MetricTile(icon: Icons.groups_rounded, title: 'Visitantes hoje', value: '15'),
                _MetricTile(icon: Icons.directions_car_rounded, title: 'Acessos', value: '32'),
                _MetricTile(icon: Icons.videocam_outlined, title: 'Câmeras', value: '2 Online'),
                _MetricTile(icon: Icons.notifications_none_rounded, title: 'Notificações', value: '0'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _OpenGateButton extends StatefulWidget {
  const _OpenGateButton({required this.enabled});

  final bool enabled;

  @override
  State<_OpenGateButton> createState() => _OpenGateButtonState();
}

class _OpenGateButtonState extends State<_OpenGateButton> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 2200))..repeat(reverse: true);
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
        final t = _controller.value;
        final scale = 1 + (t * 0.03);
        return Transform.scale(
          scale: scale,
          child: Container(
            width: 260,
            height: 260,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(colors: <Color>[Color(0xFF2D7BFF), AppPalette.brandSecondary]),
              boxShadow: <BoxShadow>[
                BoxShadow(color: const Color(0x333A9DFF).withValues(alpha: 0.2 + (t * 0.25)), blurRadius: 24, spreadRadius: 4),
              ],
              border: Border.all(color: Colors.white, width: 8),
            ),
            child: Center(
              child: Opacity(
                opacity: widget.enabled ? 1 : 0.45,
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(Icons.sensor_door, color: Colors.white, size: 44),
                    SizedBox(height: 8),
                    Text('ABRIR\nPORTÃO', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 26)),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _MetricTile extends StatelessWidget {
  const _MetricTile({required this.icon, required this.title, required this.value});

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 170,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(icon, color: AppPalette.brandSecondary),
              const SizedBox(height: 10),
              Text(title, style: const TextStyle(fontSize: 12, color: Color(0xFF5B6472))),
              const SizedBox(height: 4),
              Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
            ],
          ),
        ),
      ),
    );
  }
}

class _AccessHistoryPage extends StatelessWidget {
  const _AccessHistoryPage();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          const Row(
            children: <Widget>[
              Icon(Icons.arrow_back_rounded),
              SizedBox(width: 8),
              Text('Histórico de acessos', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
              Spacer(),
              Icon(Icons.filter_list_rounded),
            ],
          ),
          const SizedBox(height: 16),
          SegmentedButton<int>(
            segments: <ButtonSegment<int>>[
              ButtonSegment<int>(value: 0, label: Text('Todos')),
              ButtonSegment<int>(value: 1, label: Text('Entradas')),
              ButtonSegment<int>(value: 2, label: Text('Saídas')),
            ],
            selected: <int>{0},
          ),
          const SizedBox(height: 16),
          const Text('Hoje', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          const _HistoryItem(name: 'Veículo - ABC1D23', time: '08:45', ok: true),
          const _HistoryItem(name: 'João da Silva', time: '08:30', ok: true),
          const _HistoryItem(name: 'Maria Santos', time: '07:50', ok: true),
          const _HistoryItem(name: 'Visitante - Paulo', time: '07:25', ok: true),
          const SizedBox(height: 16),
          const Text('Ontem', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          const _HistoryItem(name: 'Veículo - XYZ9A88', time: '18:45', ok: true),
          const _HistoryItem(name: 'João da Silva', time: '18:30', ok: false),
        ],
      ),
    );
  }
}

class _HistoryItem extends StatelessWidget {
  const _HistoryItem({required this.name, required this.time, required this.ok});

  final String name;
  final String time;
  final bool ok;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color(0x112D7BFF),
          child: Icon(ok ? Icons.directions_car_rounded : Icons.person_rounded, color: AppPalette.brandSecondary),
        ),
        title: Text(name),
        subtitle: Text(ok ? 'Entrada permitida' : 'Saída pelo aplicativo', style: TextStyle(color: ok ? Colors.green : Colors.red)),
        trailing: Text(time),
      ),
    );
  }
}

class _DevicePage extends StatelessWidget {
  const _DevicePage();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: const <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.arrow_back_rounded),
              SizedBox(width: 8),
              Text('Portão Principal', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
              Spacer(),
              Icon(Icons.settings_rounded),
            ],
          ),
          SizedBox(height: 16),
          Card(
            child: Padding(
              padding: EdgeInsets.all(14),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(Icons.circle, size: 12, color: Colors.green),
                      SizedBox(width: 6),
                      Text('Online', style: TextStyle(color: Colors.green)),
                    ],
                  ),
                  SizedBox(height: 10),
                  Icon(Icons.sensor_door_rounded, size: 92, color: AppPalette.brandPrimary),
                  SizedBox(height: 8),
                  Text('Última atualização: 08:45:32', style: TextStyle(color: Color(0xFF666F7D))),
                ],
              ),
            ),
          ),
          SizedBox(height: 14),
          _SettingTile(icon: Icons.lock_open_rounded, title: 'Abrir portão', subtitle: 'Acionar abertura do portão'),
          _SettingTile(icon: Icons.lock_rounded, title: 'Modo de acesso', subtitle: 'Apenas usuários autorizados'),
          _SettingTile(icon: Icons.calendar_month_rounded, title: 'Agendamentos', subtitle: 'Nenhum agendamento ativo'),
          _SettingTile(icon: Icons.settings_rounded, title: 'Configurações', subtitle: 'Configurar dispositivo'),
        ],
      ),
    );
  }
}

class _SettingTile extends StatelessWidget {
  const _SettingTile({required this.icon, required this.title, required this.subtitle});

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color(0x112D7BFF),
          child: Icon(icon, color: AppPalette.brandSecondary),
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right_rounded),
      ),
    );
  }
}

class _AccountPage extends StatelessWidget {
  const _AccountPage({required this.session});

  final AuthSession? session;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          const Row(
            children: <Widget>[
              Icon(Icons.person_rounded),
              SizedBox(width: 8),
              Text('Minha conta', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
            ],
          ),
          const SizedBox(height: 16),
          Card(
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Color(0x112D7BFF),
                child: Icon(Icons.person_rounded, color: AppPalette.brandSecondary),
              ),
              title: Text(session?.userName ?? 'Usuário'),
              subtitle: Text(session?.userRole.isNotEmpty == true ? session!.userRole : 'Sem perfil definido'),
            ),
          ),
          const SizedBox(height: 14),
          const _SettingTile(icon: Icons.badge_rounded, title: 'Dados pessoais', subtitle: 'Atualizar nome, e-mail e telefone'),
          const _SettingTile(icon: Icons.verified_user_rounded, title: 'Permissões', subtitle: 'Visualizar acessos liberados'),
          const _SettingTile(icon: Icons.security_rounded, title: 'Segurança', subtitle: 'Senha e biometria'),
          Card(
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Color(0x112D7BFF),
                child: Icon(Icons.logout_rounded, color: AppPalette.brandSecondary),
              ),
              title: const Text('Sair'),
              subtitle: const Text('Encerrar sessão neste dispositivo'),
              onTap: () async {
                await SessionStore.instance.clearSession();
                if (context.mounted) {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute<void>(builder: (_) => const WelcomeScreen()),
                    (route) => false,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
