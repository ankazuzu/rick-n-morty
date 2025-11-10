import 'package:flutter/foundation.dart';
import '../../domain/entities/character.dart';
import '../../domain/repositories/character_repository.dart';
import '../../domain/repositories/favorites_repository.dart';

/// Тип сортировки избранных персонажей
enum FavoritesSortType {
  byName,
  byStatus,
  bySpecies,
}

/// ViewModel для списка избранных персонажей
class FavoritesViewModel extends ChangeNotifier {
  final CharacterRepository _characterRepository;
  final FavoritesRepository _favoritesRepository;

  FavoritesViewModel(
    this._characterRepository,
    this._favoritesRepository,
  );

  // Состояние
  List<Character> _favoriteCharacters = [];
  bool _isLoading = false;
  String? _error;
  FavoritesSortType _sortType = FavoritesSortType.byName;

  // Геттеры
  List<Character> get favoriteCharacters => _getSortedCharacters();
  bool get isLoading => _isLoading;
  String? get error => _error;
  FavoritesSortType get sortType => _sortType;
  int get favoritesCount => _favoriteCharacters.length;

  /// Получить отсортированный список персонажей
  List<Character> _getSortedCharacters() {
    final characters = List<Character>.from(_favoriteCharacters);
    
    switch (_sortType) {
      case FavoritesSortType.byName:
        characters.sort((a, b) => a.name.compareTo(b.name));
        break;
      case FavoritesSortType.byStatus:
        characters.sort((a, b) => a.status.compareTo(b.status));
        break;
      case FavoritesSortType.bySpecies:
        characters.sort((a, b) => a.species.compareTo(b.species));
        break;
    }
    
    return characters;
  }

  /// Загрузить избранных персонажей
  Future<void> loadFavorites() async {
    if (_isLoading) return;

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final favoriteIds = await _favoritesRepository.getFavoriteIds();
      
      if (favoriteIds.isEmpty) {
        _favoriteCharacters = [];
      } else {
        _favoriteCharacters = await _characterRepository.getCharactersByIds(favoriteIds);
      }
    } catch (e) {
      _error = e.toString();
      _favoriteCharacters = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Удалить персонажа из избранного
  Future<void> removeFromFavorites(int characterId) async {
    try {
      await _favoritesRepository.removeFromFavorites(characterId);
      _favoriteCharacters.removeWhere((char) => char.id == characterId);
      notifyListeners();
    } catch (e) {
      _error = 'Не удалось удалить из избранного';
      notifyListeners();
    }
  }

  /// Проверить, является ли персонаж избранным
  bool isFavorite(int characterId) {
    return _favoriteCharacters.any((char) => char.id == characterId);
  }

  /// Изменить тип сортировки
  void changeSortType(FavoritesSortType newSortType) {
    if (_sortType != newSortType) {
      _sortType = newSortType;
      notifyListeners();
    }
  }

  /// Очистить все избранное
  Future<void> clearAllFavorites() async {
    try {
      await _favoritesRepository.clearFavorites();
      _favoriteCharacters = [];
      notifyListeners();
    } catch (e) {
      _error = 'Не удалось очистить избранное';
      notifyListeners();
    }
  }

  /// Обновить список (pull-to-refresh)
  Future<void> refresh() async {
    await loadFavorites();
  }
}

