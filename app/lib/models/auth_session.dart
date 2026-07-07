class AuthSession {
  const AuthSession({
    required this.accessToken,
    required this.refreshToken,
    required this.userName,
    required this.userEmail,
  });

  final String accessToken;
  final String refreshToken;
  final String userName;
  final String userEmail;

  factory AuthSession.fromJson(Map<String, dynamic> json) {
    final user = json['user'] as Map<String, dynamic>? ?? <String, dynamic>{};

    return AuthSession(
      accessToken: json['accessToken'] as String? ?? '',
      refreshToken: json['refreshToken'] as String? ?? '',
      userName: user['name'] as String? ?? 'Usuario',
      userEmail: user['email'] as String? ?? '',
    );
  }
}
