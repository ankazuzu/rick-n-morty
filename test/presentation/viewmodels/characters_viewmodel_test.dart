import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:rick_morty/domain/entities/characters_page.dart';
import 'package:rick_morty/domain/repositories/character_repository.dart';
import 'package:rick_morty/domain/repositories/favorites_repository.dart';
import 'package:rick_morty/presentation/viewmodels/characters_viewmodel.dart';

import '../../helpers/mock_data.dart';
import 'characters_viewmodel_test.mocks.dart';

@GenerateMocks([CharacterRepository, FavoritesRepository])
void main() {
  late CharactersViewModel viewModel;
  late MockCharacterRepository mockCharacterRepository;
  late MockFavoritesRepository mockFavoritesRepository;

  setUp(() {
    mockCharacterRepository = MockCharacterRepository();
    mockFavoritesRepository = MockFavoritesRepository();
    viewModel = CharactersViewModel(
      mockCharacterRepository,
      mockFavoritesRepository,
    );
  });

  group('CharactersViewModel', () {
    test('initial state should be correct', () {
      // Assert
      expect(viewModel.characters, isEmpty);
      expect(viewModel.isLoading, false);
      expect(viewModel.isLoadingMore, false);
      expect(viewModel.error, isNull);
      expect(viewModel.hasNextPage, true);
      expect(viewModel.favoriteIds, isEmpty);
    });

    test('loadCharacters should load characters successfully', () async {
      // Arrange
      final mockPage = CharactersPage(
        characters: MockData.mockCharacters,
        totalCount: 826,
        currentPage: 1,
        totalPages: 42,
        hasNextPage: true,
      );

      when(mockCharacterRepository.getCharacters(page: 1))
          .thenAnswer((_) async => mockPage);
      when(mockFavoritesRepository.getFavoriteIds())
          .thenAnswer((_) async => [1, 2]);

      // Act
      await viewModel.loadCharacters();

      // Assert
      expect(viewModel.characters.length, 3);
      expect(viewModel.isLoading, false);
      expect(viewModel.error, isNull);
      expect(viewModel.hasNextPage, true);
      expect(viewModel.favoriteIds, {1, 2});
      verify(mockCharacterRepository.getCharacters(page: 1)).called(1);
    });

    test('loadCharacters should handle error', () async {
      // Arrange
      when(mockCharacterRepository.getCharacters(page: 1))
          .thenThrow(Exception('Network error'));

      // Act
      await viewModel.loadCharacters();

      // Assert
      expect(viewModel.characters, isEmpty);
      expect(viewModel.isLoading, false);
      expect(viewModel.error, isNotNull);
    });

    test('loadMoreCharacters should append new characters', () async {
      // Arrange
      final page1 = CharactersPage(
        characters: [MockData.mockCharacter1],
        totalCount: 826,
        currentPage: 1,
        totalPages: 42,
        hasNextPage: true,
      );

      final page2 = CharactersPage(
        characters: [MockData.mockCharacter2],
        totalCount: 826,
        currentPage: 2,
        totalPages: 42,
        hasNextPage: true,
      );

      when(mockCharacterRepository.getCharacters(page: 1))
          .thenAnswer((_) async => page1);
      when(mockCharacterRepository.getCharacters(page: 2))
          .thenAnswer((_) async => page2);
      when(mockFavoritesRepository.getFavoriteIds())
          .thenAnswer((_) async => []);

      // Act
      await viewModel.loadCharacters();
      await viewModel.loadMoreCharacters();

      // Assert
      expect(viewModel.characters.length, 2);
      expect(viewModel.isLoadingMore, false);
      verify(mockCharacterRepository.getCharacters(page: 2)).called(1);
    });

    test('toggleFavorite should add to favorites', () async {
      // Arrange
      when(mockFavoritesRepository.addToFavorites(1))
          .thenAnswer((_) async => {});

      // Act
      await viewModel.toggleFavorite(1);

      // Assert
      expect(viewModel.favoriteIds.contains(1), true);
      verify(mockFavoritesRepository.addToFavorites(1)).called(1);
    });

    test('toggleFavorite should remove from favorites', () async {
      // Arrange
      viewModel.favoriteIds.add(1);
      when(mockFavoritesRepository.removeFromFavorites(1))
          .thenAnswer((_) async => {});

      // Act
      await viewModel.toggleFavorite(1);

      // Assert
      expect(viewModel.favoriteIds.contains(1), false);
      verify(mockFavoritesRepository.removeFromFavorites(1)).called(1);
    });

    test('isFavorite should return correct value', () {
      // Arrange
      viewModel.favoriteIds.add(1);

      // Assert
      expect(viewModel.isFavorite(1), true);
      expect(viewModel.isFavorite(2), false);
    });

    test('searchCharacters should search by name', () async {
      // Arrange
      final searchPage = CharactersPage(
        characters: [MockData.mockCharacter1],
        totalCount: 1,
        currentPage: 1,
        totalPages: 1,
        hasNextPage: false,
      );

      when(mockCharacterRepository.searchCharacters(name: 'Rick', page: 1))
          .thenAnswer((_) async => searchPage);
      when(mockFavoritesRepository.getFavoriteIds())
          .thenAnswer((_) async => []);

      // Act
      await viewModel.searchCharacters('Rick');

      // Assert
      expect(viewModel.characters.length, 1);
      expect(viewModel.characters.first.name, 'Rick Sanchez');
      verify(mockCharacterRepository.searchCharacters(name: 'Rick', page: 1))
          .called(1);
    });

    test('searchCharacters with empty query should load all characters',
        () async {
      // Arrange
      final mockPage = CharactersPage(
        characters: MockData.mockCharacters,
        totalCount: 826,
        currentPage: 1,
        totalPages: 42,
        hasNextPage: true,
      );

      when(mockCharacterRepository.getCharacters(page: 1))
          .thenAnswer((_) async => mockPage);
      when(mockFavoritesRepository.getFavoriteIds())
          .thenAnswer((_) async => []);

      // Act
      await viewModel.searchCharacters('');

      // Assert
      verify(mockCharacterRepository.getCharacters(page: 1)).called(1);
      verifyNever(mockCharacterRepository.searchCharacters(
        name: anyNamed('name'),
        page: anyNamed('page'),
      ));
    });
  });
}

