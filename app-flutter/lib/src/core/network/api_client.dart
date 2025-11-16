import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../config/env.dart';

class ApiClient {
  String? _token;

  void setToken(String token) {
    _token = token;
  }

  Future<Map<String, dynamic>> post(String path, Map<String, dynamic> body) async {
    final url = Uri.parse("${AppEnv.apiBaseUrl}$path");

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        if (_token != null) 'Authorization': 'Bearer $_token',
      },
      body: jsonEncode(body),
    );

    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> get(String path) async {
    final url = Uri.parse("${AppEnv.apiBaseUrl}$path");

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        if (_token != null) 'Authorization': 'Bearer $_token',
      },
    );

    return _handleResponse(response);
  }

  Map<String, dynamic> _handleResponse(http.Response response) {
    final data =
        response.body.isEmpty ? <String, dynamic>{} : jsonDecode(response.body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return data;
    }

    throw Exception(data['message'] ?? 'Error inesperado');
  }
}

final apiClient = ApiClient();
