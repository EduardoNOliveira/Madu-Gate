import 'package:flutter/material.dart';

import '../models/access_event.dart';
import '../models/auth_session.dart';
import '../services/access_service.dart';
import '../services/api_client.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.session});

  final AuthSession session;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final AccessService _accessService;

  bool _openingGate = false;
  bool _loadingHistory = true;
  String? _message;
  List<AccessEvent> _events = <AccessEvent>[];

  @override
  void initState() {
    super.initState();
    _accessService = AccessService(ApiClient(baseUrl: 'http://10.0.2.2:3000'));
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    setState(() {
      _loadingHistory = true;
      _message = null;
    });

    try {
      final events = await _accessService.history(
        accessToken: widget.session.accessToken,
      );
      setState(() {
        _events = events;
      });
    } catch (error) {
      setState(() {
        _message = error.toString().replaceFirst('Exception: ', '');
      });
    } finally {
      if (mounted) {
        setState(() {
          _loadingHistory = false;
        });
      }
    }
  }

  Future<void> _openGate() async {
    setState(() {
      _openingGate = true;
      _message = null;
    });

    try {
      await _accessService.openGate(
        gateId: 1,
        accessToken: widget.session.accessToken,
      );

      setState(() {
        _message = 'Portao acionado com sucesso.';
      });

      await _loadHistory();
    } catch (error) {
      setState(() {
        _message = error.toString().replaceFirst('Exception: ', '');
      });
    } finally {
      if (mounted) {
        setState(() {
          _openingGate = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F172A),
        foregroundColor: Colors.white,
        title: const Text('Madu Gate'),
      ),
      body: RefreshIndicator(
        onRefresh: _loadHistory,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: <Widget>[
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Bem-vindo, ${widget.session.userName}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(widget.session.userEmail),
                    const SizedBox(height: 12),
                    FilledButton.icon(
                      onPressed: _openingGate ? null : _openGate,
                      icon: _openingGate
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.lock_open),
                      label: const Text('Abrir portao principal'),
                    ),
                  ],
                ),
              ),
            ),
            if (_message != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(_message!),
              ),
            const SizedBox(height: 16),
            const Text(
              'Historico de acessos',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            if (_loadingHistory)
              const Center(child: CircularProgressIndicator())
            else if (_events.isEmpty)
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('Nenhum evento encontrado.'),
                ),
              )
            else
              ..._events.map(
                (event) => Card(
                  child: ListTile(
                    leading: const Icon(Icons.history),
                    title: Text('${event.gateName} - ${event.status}'),
                    subtitle: Text(
                      '${event.userName} | ${event.source} | ${event.createdAt.toLocal()}',
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
