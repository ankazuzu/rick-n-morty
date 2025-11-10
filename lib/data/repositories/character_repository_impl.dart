import '../../domain/entities/character.dart';
import '../../domain/entities/characters_page.dart';
import '../../domain/repositories/character_repository.dart';
import '../datasources/character_remote_datasource.dart';

/// Реализация репозитория персонажей
class CharacterRepositoryImpl implements CharacterRepository {
  final CharacterRemoteDataSource _remoteDataSource;

  CharacterRepositoryImpl(this._remoteDataSource);

  @override
  Future<CharactersPage> getCharacters({int page = 1}) async {
    try {
      final response = await _remoteDataSource.getCharacters(page: page);
      
      return CharactersPage(
        characters: response.results.map((model) => model.toDomain()).toList(),
        totalCount: response.info.count,
        currentPage: page,
        totalPages: response.info.pages,
        hasNextPage: response.info.next != null,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Character?> getCharacterById(int id) async {
    try {
      final model = await _remoteDataSource.getCharacterById(id);
      return model.toDomain();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<Character>> getCharactersByIds(List<int> ids) async {
    try {
      if (ids.isEmpty) return [];
      
      final models = await _remoteDataSource.getCharactersByIds(ids);
      return models.map((model) => model.toDomain()).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<CharactersPage> searchCharacters({
    required String name,
    int page = 1,
  }) async {
    try {
      final response = await _remoteDataSource.searchCharacters(
        name: name,
        page: page,
      );
      
      return CharactersPage(
        characters: response.results.map((model) => model.toDomain()).toList(),
        totalCount: response.info.count,
        currentPage: page,
        totalPages: response.info.pages,
        hasNextPage: response.info.next != null,
      );
    } catch (e) {
      rethrow;
    }
  }
}

