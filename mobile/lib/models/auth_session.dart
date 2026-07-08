class AuthSession {
  const AuthSession({
    required this.accessToken,
    required this.refreshToken,
    required this.userName,
    required this.userEmail,
    required this.userRole,
  });

  final String accessToken;
  final String refreshToken;
  final String userName;
  final String userEmail;
  final String userRole;

  bool get canOpenGate {
    const deniedRoles = <String>{'visitor', 'visitante', 'aluno', 'pending', 'pendente'};
    final normalizedRole = userRole.trim().toLowerCase();
    return accessToken.isNotEmpty && normalizedRole.isNotEmpty && !deniedRoles.contains(normalizedRole);
  }

  factory AuthSession.fromJson(Map<String, dynamic> json) {
    final user = json['user'] as Map<String, dynamic>? ?? <String, dynamic>{};

    return AuthSession(
      accessToken: json['accessToken'] as String? ?? '',
      refreshToken: json['refreshToken'] as String? ?? '',
      userName: user['name'] as String? ?? 'Usuário',
      userEmail: user['email'] as String? ?? '',
      userRole: user['role'] as String? ?? '',
    );
  }

  factory AuthSession.fromStorage(Map<String, dynamic> json) {
    return AuthSession(
      accessToken: json['accessToken'] as String? ?? '',
      refreshToken: json['refreshToken'] as String? ?? '',
      userName: json['userName'] as String? ?? 'Usuário',
      userEmail: json['userEmail'] as String? ?? '',
      userRole: json['userRole'] as String? ?? '',
    );
  }

  Map<String, dynamic> toStorage() {
    return <String, dynamic>{
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'userName': userName,
      'userEmail': userEmail,
      'userRole': userRole,
    };
  }
}
