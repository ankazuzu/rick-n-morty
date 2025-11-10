import '../../domain/entities/character.dart';
import '../../domain/entities/characters_page.dart';
import '../../domain/repositories/character_repository.dart';
import '../datasources/character_remote_datasource.dart';
import '../datasources/character_local_datasource.dart';

/// Реализация репозитория персонажей с кешированием
class CharacterRepositoryImpl implements CharacterRepository {
  final CharacterRemoteDataSource _remoteDataSource;
  final CharacterLocalDataSource _localDataSource;

  CharacterRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
  );

  @override
  Future<CharactersPage> getCharacters({int page = 1}) async {
    try {
      // Пытаемся загрузить из сети
      final response = await _remoteDataSource.getCharacters(page: page);
      final characters = response.results.map((model) => model.toDomain()).toList();
      
      // Кешируем загруженные данные
      await _localDataSource.cacheCharacters(characters);
      
      return CharactersPage(
        characters: characters,
        totalCount: response.info.count,
        currentPage: page,
        totalPages: response.info.pages,
        hasNextPage: response.info.next != null,
      );
    } catch (e) {
      // Если нет сети, пытаемся загрузить из кеша
      if (page == 1) {
        final cachedCharacters = await _localDataSource.getAllCachedCharacters();
        if (cachedCharacters.isNotEmpty) {
          // Возвращаем кешированные данные
          return CharactersPage(
            characters: cachedCharacters,
            totalCount: cachedCharacters.length,
            currentPage: 1,
            totalPages: 1,
            hasNextPage: false,
          );
        }
      }
      rethrow;
    }
  }

  @override
  Future<Character?> getCharacterById(int id) async {
    try {
      // Сначала проверяем кеш
      final cached = await _localDataSource.getCachedCharacter(id);
      if (cached != null) {
        return cached;
      }
      
      // Если нет в кеше, загружаем из сети
      final model = await _remoteDataSource.getCharacterById(id);
      final character = model.toDomain();
      
      // Кешируем
      await _localDataSource.cacheCharacter(character);
      
      return character;
    } catch (e) {
      // Последняя попытка - проверяем кеш еще раз
      return await _localDataSource.getCachedCharacter(id);
    }
  }

  @override
  Future<List<Character>> getCharactersByIds(List<int> ids) async {
    try {
      if (ids.isEmpty) return [];
      
      // Пытаемся загрузить из сети
      final models = await _remoteDataSource.getCharactersByIds(ids);
      final characters = models.map((model) => model.toDomain()).toList();
      
      // Кешируем
      await _localDataSource.cacheCharacters(characters);
      
      return characters;
    } catch (e) {
      // Fallback на кеш
      return await _localDataSource.getCachedCharactersByIds(ids);
    }
  }

  @override
  Future<CharactersPage> searchCharacters({
    required String name,
    int page = 1,
  }) async {
    try {
      // Пытаемся загрузить из сети
      final response = await _remoteDataSource.searchCharacters(
        name: name,
        page: page,
      );
      final characters = response.results.map((model) => model.toDomain()).toList();
      
      // Кешируем результаты поиска
      await _localDataSource.cacheCharacters(characters);
      
      return CharactersPage(
        characters: characters,
        totalCount: response.info.count,
        currentPage: page,
        totalPages: response.info.pages,
        hasNextPage: response.info.next != null,
      );
    } catch (e) {
      // Fallback - поиск в кеше
      final cachedResults = await _localDataSource.searchCachedCharacters(name);
      if (cachedResults.isNotEmpty) {
        return CharactersPage(
          characters: cachedResults,
          totalCount: cachedResults.length,
          currentPage: 1,
          totalPages: 1,
          hasNextPage: false,
        );
      }
      rethrow;
    }
  }
}

