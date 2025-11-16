import '../../../core/network/api_client.dart';

class CombustibleAPI {
  Future<List<dynamic>> getRegistros() async {
    final resp = await apiClient.get('/combustible');
    return resp['registros'] ?? [];
  }
}

final combustibleAPI = CombustibleAPI();
