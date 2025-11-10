/// Константы для работы с API
class ApiConstants {
  ApiConstants._();

  static const String baseUrl = 'https://rickandmortyapi.com/api';
  static const String charactersEndpoint = '/character';

  /// Таймаут для запросов
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
}

