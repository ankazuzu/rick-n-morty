import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:rick_morty/domain/repositories/character_repository.dart';
import 'package:rick_morty/domain/repositories/favorites_repository.dart';
import 'package:rick_morty/presentation/viewmodels/favorites_viewmodel.dart';

import '../../helpers/mock_data.dart';
import 'favorites_viewmodel_test.mocks.dart';

@GenerateMocks([CharacterRepository, FavoritesRepository])
void main() {
  late FavoritesViewModel viewModel;
  late MockCharacterRepository mockCharacterRepository;
  late MockFavoritesRepository mockFavoritesRepository;

  setUp(() {
    mockCharacterRepository = MockCharacterRepository();
    mockFavoritesRepository = MockFavoritesRepository();
    viewModel = FavoritesViewModel(
      mockCharacterRepository,
      mockFavoritesRepository,
    );
  });

  group('FavoritesViewModel', () {
    test('initial state should be correct', () {
      // Assert
      expect(viewModel.favoriteCharacters, isEmpty);
      expect(viewModel.isLoading, false);
      expect(viewModel.error, isNull);
      expect(viewModel.sortType, FavoritesSortType.byName);
      expect(viewModel.favoritesCount, 0);
    });

    test('loadFavorites should load favorite characters', () async {
      // Arrange
      when(mockFavoritesRepository.getFavoriteIds())
          .thenAnswer((_) async => [1, 2, 3]);
      when(mockCharacterRepository.getCharactersByIds([1, 2, 3]))
          .thenAnswer((_) async => MockData.mockCharacters);

      // Act
      await viewModel.loadFavorites();

      // Assert
      expect(viewModel.favoriteCharacters.length, 3);
      expect(viewModel.isLoading, false);
      expect(viewModel.error, isNull);
      expect(viewModel.favoritesCount, 3);
      verify(mockFavoritesRepository.getFavoriteIds()).called(1);
      verify(mockCharacterRepository.getCharactersByIds([1, 2, 3])).called(1);
    });

    test('loadFavorites with empty ids should return empty list', () async {
      // Arrange
      when(mockFavoritesRepository.getFavoriteIds())
          .thenAnswer((_) async => []);

      // Act
      await viewModel.loadFavorites();

      // Assert
      expect(viewModel.favoriteCharacters, isEmpty);
      expect(viewModel.favoritesCount, 0);
      verifyNever(mockCharacterRepository.getCharactersByIds(any));
    });

    test('removeFromFavorites should remove character', () async {
      // Arrange
      when(mockFavoritesRepository.getFavoriteIds())
          .thenAnswer((_) async => [1, 2, 3]);
      when(mockCharacterRepository.getCharactersByIds([1, 2, 3]))
          .thenAnswer((_) async => MockData.mockCharacters);
      when(mockFavoritesRepository.removeFromFavorites(1))
          .thenAnswer((_) async => {});

      await viewModel.loadFavorites();

      // Act
      await viewModel.removeFromFavorites(1);

      // Assert
      expect(viewModel.favoriteCharacters.length, 2);
      expect(viewModel.favoritesCount, 2);
      verify(mockFavoritesRepository.removeFromFavorites(1)).called(1);
    });

    test('changeSortType should sort by name', () async {
      // Arrange
      when(mockFavoritesRepository.getFavoriteIds())
          .thenAnswer((_) async => [1, 2, 3]);
      when(mockCharacterRepository.getCharactersByIds([1, 2, 3]))
          .thenAnswer((_) async => MockData.mockCharacters);

      await viewModel.loadFavorites();

      // Act
      viewModel.changeSortType(FavoritesSortType.byName);

      // Assert
      expect(viewModel.sortType, FavoritesSortType.byName);
      final sorted = viewModel.favoriteCharacters;
      expect(sorted[0].name, 'Morty Smith');
      expect(sorted[1].name, 'Rick Sanchez');
      expect(sorted[2].name, 'Summer Smith');
    });

    test('changeSortType should sort by status', () async {
      // Arrange
      when(mockFavoritesRepository.getFavoriteIds())
          .thenAnswer((_) async => [1, 2, 4]);
      when(mockCharacterRepository.getCharactersByIds([1, 2, 4]))
          .thenAnswer((_) async => [
                MockData.mockCharacter1,
                MockData.mockCharacter2,
                MockData.mockDeadCharacter,
              ]);

      await viewModel.loadFavorites();

      // Act
      viewModel.changeSortType(FavoritesSortType.byStatus);

      // Assert
      final sorted = viewModel.favoriteCharacters;
      expect(sorted[0].status, 'Alive');
      expect(sorted[2].status, 'Dead');
    });

    test('changeSortType should sort by species', () async {
      // Arrange
      when(mockFavoritesRepository.getFavoriteIds())
          .thenAnswer((_) async => [1, 4]);
      when(mockCharacterRepository.getCharactersByIds([1, 4]))
          .thenAnswer((_) async => [
                MockData.mockCharacter1,
                MockData.mockDeadCharacter,
              ]);

      await viewModel.loadFavorites();

      // Act
      viewModel.changeSortType(FavoritesSortType.bySpecies);

      // Assert
      final sorted = viewModel.favoriteCharacters;
      expect(sorted[0].species, 'Alien');
      expect(sorted[1].species, 'Human');
    });

    test('clearAllFavorites should clear all favorites', () async {
      // Arrange
      when(mockFavoritesRepository.getFavoriteIds())
          .thenAnswer((_) async => [1, 2, 3]);
      when(mockCharacterRepository.getCharactersByIds([1, 2, 3]))
          .thenAnswer((_) async => MockData.mockCharacters);
      when(mockFavoritesRepository.clearFavorites())
          .thenAnswer((_) async => {});

      await viewModel.loadFavorites();

      // Act
      await viewModel.clearAllFavorites();

      // Assert
      expect(viewModel.favoriteCharacters, isEmpty);
      expect(viewModel.favoritesCount, 0);
      verify(mockFavoritesRepository.clearFavorites()).called(1);
    });

    test('isFavorite should return correct value', () async {
      // Arrange
      when(mockFavoritesRepository.getFavoriteIds())
          .thenAnswer((_) async => [1, 2]);
      when(mockCharacterRepository.getCharactersByIds([1, 2]))
          .thenAnswer((_) async => [
                MockData.mockCharacter1,
                MockData.mockCharacter2,
              ]);

      await viewModel.loadFavorites();

      // Assert
      expect(viewModel.isFavorite(1), true);
      expect(viewModel.isFavorite(3), false);
    });
  });
}

