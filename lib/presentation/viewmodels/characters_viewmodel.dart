import 'package:flutter/foundation.dart';
import '../../domain/entities/character.dart';
import '../../domain/repositories/character_repository.dart';
import '../../domain/repositories/favorites_repository.dart';

/// ViewModel для списка персонажей
class CharactersViewModel extends ChangeNotifier {
  final CharacterRepository _characterRepository;
  final FavoritesRepository _favoritesRepository;

  CharactersViewModel(
    this._characterRepository,
    this._favoritesRepository,
  );

  // Состояние
  List<Character> _characters = [];
  bool _isLoading = false;
  bool _isLoadingMore = false;
  String? _error;
  int _currentPage = 1;
  bool _hasNextPage = true;
  Set<int> _favoriteIds = {};

  // Геттеры
  List<Character> get characters => _characters;
  bool get isLoading => _isLoading;
  bool get isLoadingMore => _isLoadingMore;
  String? get error => _error;
  bool get hasNextPage => _hasNextPage;
  Set<int> get favoriteIds => _favoriteIds;

  /// Проверить, является ли персонаж избранным
  bool isFavorite(int characterId) => _favoriteIds.contains(characterId);

  /// Загрузить персонажей (первая страница)
  Future<void> loadCharacters() async {
    if (_isLoading) return;

    _isLoading = true;
    _error = null;
    _currentPage = 1;
    notifyListeners();

    try {
      final page = await _characterRepository.getCharacters(page: 1);
      _characters = page.characters;
      _hasNextPage = page.hasNextPage;
      _currentPage = page.currentPage;

      // Загружаем избранное
      await _loadFavorites();
    } catch (e) {
      _error = e.toString();
      _characters = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Загрузить следующую страницу персонажей
  Future<void> loadMoreCharacters() async {
    if (_isLoadingMore || !_hasNextPage) return;

    _isLoadingMore = true;
    notifyListeners();

    try {
      final nextPage = _currentPage + 1;
      final page = await _characterRepository.getCharacters(page: nextPage);
      
      _characters.addAll(page.characters);
      _hasNextPage = page.hasNextPage;
      _currentPage = page.currentPage;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoadingMore = false;
      notifyListeners();
    }
  }

  /// Поиск персонажей по имени
  Future<void> searchCharacters(String query) async {
    if (_isLoading) return;

    if (query.isEmpty) {
      await loadCharacters();
      return;
    }

    _isLoading = true;
    _error = null;
    _currentPage = 1;
    notifyListeners();

    try {
      final page = await _characterRepository.searchCharacters(
        name: query,
        page: 1,
      );
      _characters = page.characters;
      _hasNextPage = page.hasNextPage;
      _currentPage = page.currentPage;
    } catch (e) {
      _error = 'Персонажи не найдены';
      _characters = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Загрузить список избранных ID
  Future<void> _loadFavorites() async {
    try {
      final ids = await _favoritesRepository.getFavoriteIds();
      _favoriteIds = ids.toSet();
    } catch (e) {
      _favoriteIds = {};
    }
  }

  /// Переключить избранное для персонажа
  Future<void> toggleFavorite(int characterId) async {
    try {
      if (_favoriteIds.contains(characterId)) {
        await _favoritesRepository.removeFromFavorites(characterId);
        _favoriteIds.remove(characterId);
      } else {
        await _favoritesRepository.addToFavorites(characterId);
        _favoriteIds.add(characterId);
      }
      notifyListeners();
    } catch (e) {
      _error = 'Не удалось обновить избранное';
      notifyListeners();
    }
  }

  /// Обновить список (pull-to-refresh)
  Future<void> refresh() async {
    await loadCharacters();
  }
}

