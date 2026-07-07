import '../models/auth_session.dart';
import 'api_client.dart';

class AuthService {
  AuthService(this._client);

  final ApiClient _client;

  Future<AuthSession> login({
    required String email,
    required String password,
  }) async {
    final response = await _client.post(
      '/auth/login',
      body: <String, dynamic>{
        'email': email,
        'password': password,
      },
    );

    return AuthSession.fromJson(response);
  }
}
