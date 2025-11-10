import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:rick_morty/data/datasources/character_remote_datasource.dart';
import 'package:rick_morty/data/datasources/character_local_datasource.dart';
import 'package:rick_morty/data/models/characters_response.dart';
import 'package:rick_morty/data/models/character_model.dart';
import 'package:rick_morty/data/repositories/character_repository_impl.dart';

import '../../helpers/mock_data.dart';
import 'character_repository_impl_test.mocks.dart';

@GenerateMocks([CharacterRemoteDataSource, CharacterLocalDataSource])
void main() {
  late CharacterRepositoryImpl repository;
  late MockCharacterRemoteDataSource mockRemoteDataSource;
  late MockCharacterLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockCharacterRemoteDataSource();
    mockLocalDataSource = MockCharacterLocalDataSource();
    repository = CharacterRepositoryImpl(
      mockRemoteDataSource,
      mockLocalDataSource,
    );
  });

  group('CharacterRepositoryImpl - getCharacters', () {
    test('should fetch from remote and cache on success', () async {
      // Arrange
      final mockResponse = CharactersResponse(
        info: CharactersInfo(
          count: 2,
          pages: 1,
          next: null,
          prev: null,
        ),
        results: [
          CharacterModel.fromDomain(MockData.mockCharacter1),
          CharacterModel.fromDomain(MockData.mockCharacter2),
        ],
      );

      when(mockRemoteDataSource.getCharacters(page: 1))
          .thenAnswer((_) async => mockResponse);
      when(mockLocalDataSource.cacheCharacters(any))
          .thenAnswer((_) async => {});

      // Act
      final result = await repository.getCharacters(page: 1);

      // Assert
      expect(result.characters, hasLength(2));
      expect(result.totalCount, 2);
      expect(result.currentPage, 1);
      expect(result.hasNextPage, isFalse);

      // Проверяем, что данные были закешированы
      verify(mockLocalDataSource.cacheCharacters(any)).called(1);
    });

    test('should return cached data when remote fails on page 1', () async {
      // Arrange
      when(mockRemoteDataSource.getCharacters(page: 1))
          .thenThrow(Exception('Network error'));
      when(mockLocalDataSource.getAllCachedCharacters())
          .thenAnswer((_) async => [
                MockData.mockCharacter1,
                MockData.mockCharacter2,
              ]);

      // Act
      final result = await repository.getCharacters(page: 1);

      // Assert
      expect(result.characters, hasLength(2));
      expect(result.currentPage, 1);
      verify(mockLocalDataSource.getAllCachedCharacters()).called(1);
      verifyNever(mockLocalDataSource.cacheCharacters(any));
    });

    test('should throw error when remote fails and no cache available', () async {
      // Arrange
      when(mockRemoteDataSource.getCharacters(page: 1))
          .thenThrow(Exception('Network error'));
      when(mockLocalDataSource.getAllCachedCharacters())
          .thenAnswer((_) async => []);

      // Act & Assert
      expect(
        () => repository.getCharacters(page: 1),
        throwsException,
      );
    });

    test('should not fallback to cache on page > 1', () async {
      // Arrange
      when(mockRemoteDataSource.getCharacters(page: 2))
          .thenThrow(Exception('Network error'));

      // Act & Assert
      expect(
        () => repository.getCharacters(page: 2),
        throwsException,
      );

      // Не должны пытаться получить из кеша
      verifyNever(mockLocalDataSource.getAllCachedCharacters());
    });
  });

  group('CharacterRepositoryImpl - getCharacterById', () {
    test('should return from cache first if available', () async {
      // Arrange
      when(mockLocalDataSource.getCachedCharacter(1))
          .thenAnswer((_) async => MockData.mockCharacter1);

      // Act
      final result = await repository.getCharacterById(1);

      // Assert
      expect(result, isNotNull);
      expect(result!.id, 1);
      expect(result.name, 'Rick Sanchez');

      // Должны проверить кеш сначала
      verify(mockLocalDataSource.getCachedCharacter(1)).called(1);
      verifyNever(mockRemoteDataSource.getCharacterById(any));
    });

    test('should fetch from remote when not in cache', () async {
      // Arrange
      when(mockLocalDataSource.getCachedCharacter(1))
          .thenAnswer((_) async => null);
      when(mockRemoteDataSource.getCharacterById(1))
          .thenAnswer((_) async => CharacterModel.fromDomain(MockData.mockCharacter1));
      when(mockLocalDataSource.cacheCharacter(any))
          .thenAnswer((_) async => {});

      // Act
      final result = await repository.getCharacterById(1);

      // Assert
      expect(result, isNotNull);
      expect(result!.id, 1);

      verify(mockLocalDataSource.getCachedCharacter(1)).called(1);
      verify(mockRemoteDataSource.getCharacterById(1)).called(1);
      verify(mockLocalDataSource.cacheCharacter(any)).called(1);
    });

    test('should fallback to cache when remote fails', () async {
      // Arrange
      when(mockLocalDataSource.getCachedCharacter(1))
          .thenAnswer((_) async => null); // Первый раз пусто
      when(mockRemoteDataSource.getCharacterById(1))
          .thenThrow(Exception('Network error'));
      // При повторном вызове (в catch) возвращаем данные
      when(mockLocalDataSource.getCachedCharacter(1))
          .thenAnswer((_) async => MockData.mockCharacter1);

      // Act
      final result = await repository.getCharacterById(1);

      // Assert
      expect(result, isNotNull);
      expect(result!.id, 1);
    });

    test('should return null when not in cache and remote fails', () async {
      // Arrange
      when(mockLocalDataSource.getCachedCharacter(1))
          .thenAnswer((_) async => null);
      when(mockRemoteDataSource.getCharacterById(1))
          .thenThrow(Exception('Network error'));

      // Act
      final result = await repository.getCharacterById(1);

      // Assert
      expect(result, isNull);
    });
  });

  group('CharacterRepositoryImpl - getCharactersByIds', () {
    test('should fetch from remote and cache on success', () async {
      // Arrange
      final ids = [1, 2];
      when(mockRemoteDataSource.getCharactersByIds(ids))
          .thenAnswer((_) async => [
                CharacterModel.fromDomain(MockData.mockCharacter1),
                CharacterModel.fromDomain(MockData.mockCharacter2),
              ]);
      when(mockLocalDataSource.cacheCharacters(any))
          .thenAnswer((_) async => {});

      // Act
      final result = await repository.getCharactersByIds(ids);

      // Assert
      expect(result, hasLength(2));
      expect(result[0].id, 1);
      expect(result[1].id, 2);

      verify(mockLocalDataSource.cacheCharacters(any)).called(1);
    });

    test('should return empty list for empty ids', () async {
      // Act
      final result = await repository.getCharactersByIds([]);

      // Assert
      expect(result, isEmpty);
      verifyNever(mockRemoteDataSource.getCharactersByIds(any));
      verifyNever(mockLocalDataSource.getCachedCharactersByIds(any));
    });

    test('should fallback to cache when remote fails', () async {
      // Arrange
      final ids = [1, 2];
      when(mockRemoteDataSource.getCharactersByIds(ids))
          .thenThrow(Exception('Network error'));
      when(mockLocalDataSource.getCachedCharactersByIds(ids))
          .thenAnswer((_) async => [
                MockData.mockCharacter1,
                MockData.mockCharacter2,
              ]);

      // Act
      final result = await repository.getCharactersByIds(ids);

      // Assert
      expect(result, hasLength(2));
      verify(mockLocalDataSource.getCachedCharactersByIds(ids)).called(1);
    });
  });

  group('CharacterRepositoryImpl - searchCharacters', () {
    test('should fetch from remote and cache results on success', () async {
      // Arrange
      final mockResponse = CharactersResponse(
        info: CharactersInfo(
          count: 1,
          pages: 1,
          next: null,
          prev: null,
        ),
        results: [
          CharacterModel.fromDomain(MockData.mockCharacter1),
        ],
      );

      when(mockRemoteDataSource.searchCharacters(name: 'Rick', page: 1))
          .thenAnswer((_) async => mockResponse);
      when(mockLocalDataSource.cacheCharacters(any))
          .thenAnswer((_) async => {});

      // Act
      final result = await repository.searchCharacters(name: 'Rick', page: 1);

      // Assert
      expect(result.characters, hasLength(1));
      expect(result.characters[0].name, 'Rick Sanchez');

      verify(mockLocalDataSource.cacheCharacters(any)).called(1);
    });

    test('should fallback to cached search when remote fails', () async {
      // Arrange
      when(mockRemoteDataSource.searchCharacters(name: 'Rick', page: 1))
          .thenThrow(Exception('Network error'));
      when(mockLocalDataSource.searchCachedCharacters('Rick'))
          .thenAnswer((_) async => [MockData.mockCharacter1]);

      // Act
      final result = await repository.searchCharacters(name: 'Rick', page: 1);

      // Assert
      expect(result.characters, hasLength(1));
      expect(result.characters[0].name, 'Rick Sanchez');

      verify(mockLocalDataSource.searchCachedCharacters('Rick')).called(1);
      verifyNever(mockLocalDataSource.cacheCharacters(any));
    });

    test('should throw error when remote fails and no cached results', () async {
      // Arrange
      when(mockRemoteDataSource.searchCharacters(name: 'Unknown', page: 1))
          .thenThrow(Exception('Network error'));
      when(mockLocalDataSource.searchCachedCharacters('Unknown'))
          .thenAnswer((_) async => []);

      // Act & Assert
      expect(
        () => repository.searchCharacters(name: 'Unknown', page: 1),
        throwsException,
      );
    });
  });

  group('CharacterRepositoryImpl - Caching Strategy', () {
    test('should always try remote first before cache', () async {
      // Arrange
      final mockResponse = CharactersResponse(
        info: CharactersInfo(count: 1, pages: 1, next: null, prev: null),
        results: [CharacterModel.fromDomain(MockData.mockCharacter1)],
      );

      when(mockRemoteDataSource.getCharacters(page: 1))
          .thenAnswer((_) async => mockResponse);
      when(mockLocalDataSource.cacheCharacters(any))
          .thenAnswer((_) async => {});

      // Act
      await repository.getCharacters(page: 1);

      // Assert
      verify(mockRemoteDataSource.getCharacters(page: 1)).called(1);
      verify(mockLocalDataSource.cacheCharacters(any)).called(1);
    });

    test('should cache data even if already cached', () async {
      // Arrange
      final mockResponse = CharactersResponse(
        info: CharactersInfo(count: 1, pages: 1, next: null, prev: null),
        results: [CharacterModel.fromDomain(MockData.mockCharacter1)],
      );

      when(mockRemoteDataSource.getCharacters(page: 1))
          .thenAnswer((_) async => mockResponse);
      when(mockLocalDataSource.cacheCharacters(any))
          .thenAnswer((_) async => {});

      // Act - вызываем дважды
      await repository.getCharacters(page: 1);
      await repository.getCharacters(page: 1);

      // Assert - оба раза должны кешировать
      verify(mockLocalDataSource.cacheCharacters(any)).called(2);
    });
  });
}

