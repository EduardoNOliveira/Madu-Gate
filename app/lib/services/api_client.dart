import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiClient {
  ApiClient({required this.baseUrl});

  final String baseUrl;

  Future<Map<String, dynamic>> post(
    String path, {
    Map<String, dynamic>? body,
    String? accessToken,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl$path'),
      headers: _headers(accessToken),
      body: jsonEncode(body ?? <String, dynamic>{}),
    );

    return _parseResponse(response);
  }

  Future<List<dynamic>> getList(
    String path, {
    String? accessToken,
  }) async {
    final response = await http.get(
      Uri.parse('$baseUrl$path'),
      headers: _headers(accessToken),
    );

    final parsed = _parseResponse(response);
    return parsed is List<dynamic> ? parsed : <dynamic>[];
  }

  Map<String, String> _headers(String? accessToken) {
    return <String, String>{
      'Content-Type': 'application/json',
      if (accessToken != null && accessToken.isNotEmpty)
        'Authorization': 'Bearer $accessToken',
    };
  }

  dynamic _parseResponse(http.Response response) {
    final parsed = response.body.isEmpty ? null : jsonDecode(response.body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return parsed;
    }

    final message = parsed is Map<String, dynamic>
        ? (parsed['error'] as String? ?? 'Erro na requisicao')
        : 'Erro na requisicao';

    throw Exception(message);
  }
}
