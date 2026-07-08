import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/auth_session.dart';

class SessionStore {
  SessionStore._();

  static const String _sessionKey = 'auth_session';
  static final SessionStore instance = SessionStore._();

  AuthSession? _currentSession;

  AuthSession? get currentSession => _currentSession;

  Future<AuthSession?> loadSession() async {
    if (_currentSession != null) {
      return _currentSession;
    }

    final preferences = await SharedPreferences.getInstance();
    final rawSession = preferences.getString(_sessionKey);

    if (rawSession == null || rawSession.isEmpty) {
      return null;
    }

    final decoded = jsonDecode(rawSession) as Map<String, dynamic>;
    _currentSession = AuthSession.fromStorage(decoded);
    return _currentSession;
  }

  Future<void> saveSession(AuthSession session) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_sessionKey, jsonEncode(session.toStorage()));
    _currentSession = session;
  }

  Future<void> clearSession() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.remove(_sessionKey);
    _currentSession = null;
  }
}