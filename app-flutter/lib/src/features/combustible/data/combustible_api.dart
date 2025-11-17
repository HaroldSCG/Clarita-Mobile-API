import '../../../core/network/api_client.dart';

class CombustibleAPI {
  Future<List<dynamic>> getAll() async {
    final resp = await apiClient.get("/combustible");
    return resp["data"] ?? [];
  }

  Future<Map<String, dynamic>> create(Map<String, dynamic> data) async {
    final resp = await apiClient.post("/combustible", data);
    return resp;
  }
}

final combustibleAPI = CombustibleAPI();