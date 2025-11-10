import 'package:flutter_test/flutter_test.dart';
import 'package:rick_morty/data/database/app_database.dart';
import 'package:rick_morty/data/datasources/character_local_datasource.dart';
import 'package:rick_morty/domain/entities/character.dart' as domain;

import '../../helpers/mock_data.dart';

void main() {
  late AppDatabase database;
  late CharacterLocalDataSource dataSource;

  setUp(() {
    // Создаем in-memory базу данных для тестов
    database = AppDatabase.memory();
    dataSource = CharacterLocalDataSource(database);
  });

  tearDown(() async {
    await database.close();
  });

  group('CharacterLocalDataSource', () {
    test('should cache single character', () async {
      // Arrange
      final character = MockData.mockCharacter1;

      // Act
      await dataSource.cacheCharacter(character);
      final cached = await dataSource.getCachedCharacter(character.id);

      // Assert
      expect(cached, isNotNull);
      expect(cached!.id, character.id);
      expect(cached.name, character.name);
      expect(cached.status, character.status);
      expect(cached.species, character.species);
    });

    test('should cache multiple characters', () async {
      // Arrange
      final characters = [
        MockData.mockCharacter1,
        MockData.mockCharacter2,
        MockData.mockDeadCharacter,
      ];

      // Act
      await dataSource.cacheCharacters(characters);
      final cached = await dataSource.getAllCachedCharacters();

      // Assert
      expect(cached, hasLength(3));
      expect(cached.map((c) => c.id).toList(), [1, 2, 4]);
    });

    test('should update existing character on cache', () async {
      // Arrange
      final character = MockData.mockCharacter1;
      await dataSource.cacheCharacter(character);

      final updatedCharacter = domain.Character(
        id: character.id,
        name: 'Updated Name',
        status: character.status,
        species: character.species,
        type: character.type,
        gender: character.gender,
        origin: character.origin,
        location: character.location,
        image: character.image,
        episode: character.episode,
        created: character.created,
      );

      // Act
      await dataSource.cacheCharacter(updatedCharacter);
      final cached = await dataSource.getCachedCharacter(character.id);

      // Assert
      expect(cached!.name, 'Updated Name');
      final allCached = await dataSource.getAllCachedCharacters();
      expect(allCached, hasLength(1)); // Не должно быть дубликатов
    });

    test('should get cached character by id', () async {
      // Arrange
      await dataSource.cacheCharacter(MockData.mockCharacter1);
      await dataSource.cacheCharacter(MockData.mockCharacter2);

      // Act
      final cached = await dataSource.getCachedCharacter(1);

      // Assert
      expect(cached, isNotNull);
      expect(cached!.id, 1);
      expect(cached.name, 'Rick Sanchez');
    });

    test('should return null for non-existent character', () async {
      // Act
      final cached = await dataSource.getCachedCharacter(999);

      // Assert
      expect(cached, isNull);
    });

    test('should get all cached characters', () async {
      // Arrange
      await dataSource.cacheCharacters([
        MockData.mockCharacter1,
        MockData.mockCharacter2,
        MockData.mockDeadCharacter,
      ]);

      // Act
      final cached = await dataSource.getAllCachedCharacters();

      // Assert
      expect(cached, hasLength(3));
      expect(cached[0].name, 'Rick Sanchez');
      expect(cached[1].name, 'Morty Smith');
      expect(cached[2].name, 'Birdperson');
    });

    test('should get cached characters by ids', () async {
      // Arrange
      await dataSource.cacheCharacters([
        MockData.mockCharacter1,
        MockData.mockCharacter2,
        MockData.mockDeadCharacter,
      ]);

      // Act
      final cached = await dataSource.getCachedCharactersByIds([1, 4]);

      // Assert
      expect(cached, hasLength(2));
      expect(cached.map((c) => c.id).toList(), [1, 4]);
      expect(cached[0].name, 'Rick Sanchez');
      expect(cached[1].name, 'Birdperson');
    });

    test('should search cached characters by name', () async {
      // Arrange
      await dataSource.cacheCharacters([
        MockData.mockCharacter1,
        MockData.mockCharacter2,
        MockData.mockDeadCharacter,
      ]);

      // Act
      final results = await dataSource.searchCachedCharacters('Rick');

      // Assert
      expect(results, hasLength(1));
      expect(results[0].name, 'Rick Sanchez');
    });

    test('should search cached characters case-insensitive', () async {
      // Arrange
      await dataSource.cacheCharacters([
        MockData.mockCharacter1,
        MockData.mockCharacter2,
      ]);

      // Act
      final results = await dataSource.searchCachedCharacters('morty');

      // Assert
      expect(results, hasLength(1));
      expect(results[0].name, 'Morty Smith');
    });

    test('should return empty list for non-matching search', () async {
      // Arrange
      await dataSource.cacheCharacters([MockData.mockCharacter1]);

      // Act
      final results = await dataSource.searchCachedCharacters('NonExistent');

      // Assert
      expect(results, isEmpty);
    });

    test('should check if has cached data', () async {
      // Act - no data
      final hasDataBefore = await dataSource.hasCachedData();

      // Arrange
      await dataSource.cacheCharacter(MockData.mockCharacter1);

      // Act - with data
      final hasDataAfter = await dataSource.hasCachedData();

      // Assert
      expect(hasDataBefore, isFalse);
      expect(hasDataAfter, isTrue);
    });

    test('should clear all cache', () async {
      // Arrange
      await dataSource.cacheCharacters([
        MockData.mockCharacter1,
        MockData.mockCharacter2,
      ]);

      // Act
      await dataSource.clearCache();
      final cached = await dataSource.getAllCachedCharacters();

      // Assert
      expect(cached, isEmpty);
    });

    test('should preserve character data integrity', () async {
      // Arrange
      final character = MockData.mockCharacter1;

      // Act
      await dataSource.cacheCharacter(character);
      final cached = await dataSource.getCachedCharacter(character.id);

      // Assert - проверяем все поля
      expect(cached, isNotNull);
      expect(cached!.id, character.id);
      expect(cached.name, character.name);
      expect(cached.status, character.status);
      expect(cached.species, character.species);
      expect(cached.type, character.type);
      expect(cached.gender, character.gender);
      expect(cached.origin.name, character.origin.name);
      expect(cached.origin.url, character.origin.url);
      expect(cached.location.name, character.location.name);
      expect(cached.location.url, character.location.url);
      expect(cached.image, character.image);
      expect(cached.episode, character.episode);
      expect(cached.created, character.created);
    });

    test('should handle empty character list', () async {
      // Act
      await dataSource.cacheCharacters([]);
      final cached = await dataSource.getAllCachedCharacters();

      // Assert
      expect(cached, isEmpty);
    });

    test('should handle character with empty type', () async {
      // Arrange
      final character = domain.Character(
        id: 100,
        name: 'Test Character',
        status: 'Alive',
        species: 'Human',
        type: '', // Empty type
        gender: 'Male',
        origin: domain.CharacterLocation(name: 'Earth', url: 'url'),
        location: domain.CharacterLocation(name: 'Earth', url: 'url'),
        image: 'image.png',
        episode: ['E01'],
        created: DateTime.now(),
      );

      // Act
      await dataSource.cacheCharacter(character);
      final cached = await dataSource.getCachedCharacter(100);

      // Assert
      expect(cached, isNotNull);
      expect(cached!.type, '');
    });

    test('should handle character with empty episode list', () async {
      // Arrange
      final character = domain.Character(
        id: 101,
        name: 'Test Character',
        status: 'Alive',
        species: 'Human',
        type: '',
        gender: 'Male',
        origin: domain.CharacterLocation(name: 'Earth', url: 'url'),
        location: domain.CharacterLocation(name: 'Earth', url: 'url'),
        image: 'image.png',
        episode: [], // Empty episode list
        created: DateTime.now(),
      );

      // Act
      await dataSource.cacheCharacter(character);
      final cached = await dataSource.getCachedCharacter(101);

      // Assert
      expect(cached, isNotNull);
      expect(cached!.episode, isEmpty);
    });
  });
}

