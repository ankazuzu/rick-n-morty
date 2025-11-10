import 'package:drift/drift.dart';
import '../../domain/entities/character.dart' as domain;
import '../database/app_database.dart';
import 'dart:convert';

/// Локальный источник данных для персонажей (Drift)
class CharacterLocalDataSource {
  final AppDatabase _database;

  CharacterLocalDataSource(this._database);

  /// Сохранить список персонажей в кеш
  Future<void> cacheCharacters(List<domain.Character> characters) async {
    final companions = characters.map(_toCompanion).toList();
    await _database.charactersDao.insertOrUpdateCharacters(companions);
  }

  /// Сохранить одного персонажа в кеш
  Future<void> cacheCharacter(domain.Character character) async {
    await _database.charactersDao.insertOrUpdateCharacter(_toCompanion(character));
  }

  /// Получить персонажа из кеша по ID
  Future<domain.Character?> getCachedCharacter(int id) async {
    final result = await _database.charactersDao.getCharacterById(id);
    return result != null ? _toDomain(result) : null;
  }

  /// Получить всех кешированных персонажей
  Future<List<domain.Character>> getAllCachedCharacters() async {
    final results = await _database.charactersDao.getAllCharacters();
    return results.map(_toDomain).toList();
  }

  /// Получить персонажей по списку ID
  Future<List<domain.Character>> getCachedCharactersByIds(List<int> ids) async {
    final results = await _database.charactersDao.getCharactersByIds(ids);
    return results.map(_toDomain).toList();
  }

  /// Поиск персонажей по имени в кеше
  Future<List<domain.Character>> searchCachedCharacters(String query) async {
    final results = await _database.charactersDao.searchCharactersByName(query);
    return results.map(_toDomain).toList();
  }

  /// Проверить, есть ли кешированные данные
  Future<bool> hasCachedData() async {
    final count = await _database.charactersDao.getCharactersCount();
    return count > 0;
  }

  /// Очистить весь кеш
  Future<void> clearCache() async {
    await _database.charactersDao.clearAllCharacters();
  }

  /// Удалить устаревшие записи (старше 24 часов)
  Future<void> cleanupStaleCache() async {
    await _database.charactersDao.deleteStaleCharacters();
  }

  /// Преобразовать доменную модель в Drift Companion
  CharactersCompanion _toCompanion(domain.Character character) {
    return CharactersCompanion(
      id: Value(character.id),
      name: Value(character.name),
      status: Value(character.status),
      species: Value(character.species),
      type: Value(character.type),
      gender: Value(character.gender),
      originName: Value(character.origin.name),
      originUrl: Value(character.origin.url),
      locationName: Value(character.location.name),
      locationUrl: Value(character.location.url),
      image: Value(character.image),
      episode: Value(jsonEncode(character.episode)),
      created: Value(character.created),
      cachedAt: Value(DateTime.now()),
    );
  }

  /// Преобразовать Drift модель в доменную
  domain.Character _toDomain(Character dbCharacter) {
    final episodes = (jsonDecode(dbCharacter.episode) as List<dynamic>)
        .map((e) => e.toString())
        .toList();

    return domain.Character(
      id: dbCharacter.id,
      name: dbCharacter.name,
      status: dbCharacter.status,
      species: dbCharacter.species,
      type: dbCharacter.type,
      gender: dbCharacter.gender,
      origin: domain.CharacterLocation(
        name: dbCharacter.originName,
        url: dbCharacter.originUrl,
      ),
      location: domain.CharacterLocation(
        name: dbCharacter.locationName,
        url: dbCharacter.locationUrl,
      ),
      image: dbCharacter.image,
      episode: episodes,
      created: dbCharacter.created,
    );
  }
}

