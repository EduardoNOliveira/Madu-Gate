class AccessEvent {
  const AccessEvent({
    required this.id,
    required this.userName,
    required this.gateName,
    required this.status,
    required this.source,
    required this.createdAt,
  });

  final int id;
  final String userName;
  final String gateName;
  final String status;
  final String source;
  final DateTime createdAt;

  factory AccessEvent.fromJson(Map<String, dynamic> json) {
    return AccessEvent(
      id: (json['id'] as num?)?.toInt() ?? 0,
      userName: json['user_name'] as String? ?? '-',
      gateName: json['gate_name'] as String? ?? '-',
      status: json['status'] as String? ?? '-',
      source: json['source'] as String? ?? '-',
      createdAt: DateTime.tryParse(json['created_at'] as String? ?? '') ?? DateTime.now(),
    );
  }
}
