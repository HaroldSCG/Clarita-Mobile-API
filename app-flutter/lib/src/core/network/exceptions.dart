class ApiException implements Exception {
  final String message;
  ApiException(this.message);

  @override
  String toString() => "ApiException: $message";
}

class BadRequestException extends ApiException {
  BadRequestException(String? msg) : super(msg ?? "Solicitud incorrecta");
}

class UnauthorizedException extends ApiException {
  UnauthorizedException(String? msg) : super(msg ?? "No autorizado");
}

class NotFoundException extends ApiException {
  NotFoundException(String? msg) : super(msg ?? "Recurso no encontrado");
}

class ServerException extends ApiException {
  ServerException(String? msg) : super(msg ?? "Error del servidor");
}