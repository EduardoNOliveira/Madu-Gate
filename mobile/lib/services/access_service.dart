import '../models/access_event.dart';
import 'api_client.dart';

class AccessService {
  AccessService(this._client);

  final ApiClient _client;

  Future<void> openGate({
    required int gateId,
    required String accessToken,
  }) async {
    await _client.post(
      '/access/open',
      accessToken: accessToken,
      body: <String, dynamic>{
        'gateId': gateId,
        'source': 'mobile',
      },
    );
  }

  Future<List<AccessEvent>> history({
    required String accessToken,
  }) async {
    final response = await _client.getList(
      '/access/history?limit=20&offset=0',
      accessToken: accessToken,
    );

    return response
        .whereType<Map<String, dynamic>>()
        .map(AccessEvent.fromJson)
        .toList();
  }
}
