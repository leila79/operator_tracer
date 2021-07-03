class ConnectionException implements Exception {}

class NotFoundException implements Exception {}

class TokenException implements Exception {}

class PublicException implements Exception {
  final String message;

  PublicException({required this.message});
}
