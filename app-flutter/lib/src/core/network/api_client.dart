import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../config/env.dart';
import 'exceptions.dart';

class ApiClient {
  final String baseUrl = Env.apiBaseUrl;

  Future<dynamic> get(String path) async {
    final url = Uri.parse("$baseUrl$path");

    final response = await http
        .get(url)
        .timeout(Env.timeout);

    return _handleResponse(response);
  }

  Future<dynamic> post(String path, Map<String, dynamic> body) async {
    final url = Uri.parse("$baseUrl$path");

    final response = await http
        .post(
          url,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(body),
        )
        .timeout(Env.timeout);

    return _handleResponse(response);
  }

  Future<dynamic> put(String path, Map<String, dynamic> body) async {
    final url = Uri.parse("$baseUrl$path");

    final response = await http
        .put(
          url,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(body),
        )
        .timeout(Env.timeout);

    return _handleResponse(response);
  }

  Future<dynamic> delete(String path) async {
    final url = Uri.parse("$baseUrl$path");

    final response = await http
        .delete(url)
        .timeout(Env.timeout);

    return _handleResponse(response);
  }

  dynamic _handleResponse(http.Response response) {
    final status = response.statusCode;
    final body = response.body.isNotEmpty ? jsonDecode(response.body) : null;

    if (status >= 200 && status < 300) return body;

    if (status == 400) throw BadRequestException(body?["message"]);
    if (status == 401) throw UnauthorizedException(body?["message"]);
    if (status == 404) throw NotFoundException(body?["message"]);
    if (status >= 500) throw ServerException("Error del servidor");

    throw ApiException("Error desconocido");
  }
}

final apiClient = ApiClient();