import 'package:dio/dio.dart';
import '../../core/constants/api_constants.dart';
import '../models/character_model.dart';
import '../models/characters_response.dart';

/// Удаленный источник данных для персонажей (API)
class CharacterRemoteDataSource {
  final Dio _dio;

  CharacterRemoteDataSource(this._dio);

  /// Получить список персонажей с пагинацией
  Future<CharactersResponse> getCharacters({int page = 1}) async {
    try {
      final response = await _dio.get(
        '${ApiConstants.baseUrl}${ApiConstants.charactersEndpoint}',
        queryParameters: {'page': page},
      );

      return CharactersResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Получить персонажа по ID
  Future<CharacterModel> getCharacterById(int id) async {
    try {
      final response = await _dio.get(
        '${ApiConstants.baseUrl}${ApiConstants.charactersEndpoint}/$id',
      );

      return CharacterModel.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Получить список персонажей по списку ID
  Future<List<CharacterModel>> getCharactersByIds(List<int> ids) async {
    if (ids.isEmpty) return [];

    try {
      final idsString = ids.join(',');
      final response = await _dio.get(
        '${ApiConstants.baseUrl}${ApiConstants.charactersEndpoint}/$idsString',
      );

      // API возвращает массив, если запрошено несколько ID
      if (response.data is List) {
        return (response.data as List)
            .map((json) => CharacterModel.fromJson(json))
            .toList();
      } else {
        // Если запрошен один ID, возвращается объект
        return [CharacterModel.fromJson(response.data)];
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Поиск персонажей по имени
  Future<CharactersResponse> searchCharacters({
    required String name,
    int page = 1,
  }) async {
    try {
      final response = await _dio.get(
        '${ApiConstants.baseUrl}${ApiConstants.charactersEndpoint}',
        queryParameters: {
          'name': name,
          'page': page,
        },
      );

      return CharactersResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Обработка ошибок Dio
  Exception _handleError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return Exception('Превышено время ожидания. Проверьте подключение к интернету.');
      case DioExceptionType.badResponse:
        if (e.response?.statusCode == 404) {
          return Exception('Данные не найдены');
        }
        return Exception('Ошибка сервера: ${e.response?.statusCode}');
      case DioExceptionType.cancel:
        return Exception('Запрос отменен');
      default:
        return Exception('Ошибка подключения. Проверьте интернет-соединение.');
    }
  }
}

