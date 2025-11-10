import '../../domain/repositories/favorites_repository.dart';
import '../datasources/favorites_local_datasource.dart';

/// Реализация репозитория избранных персонажей
class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesLocalDataSource _localDataSource;

  FavoritesRepositoryImpl(this._localDataSource);

  @override
  Future<List<int>> getFavoriteIds() async {
    try {
      return await _localDataSource.getFavoriteIds();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<void> addToFavorites(int characterId) async {
    try {
      await _localDataSource.addToFavorites(characterId);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> removeFromFavorites(int characterId) async {
    try {
      await _localDataSource.removeFromFavorites(characterId);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> isFavorite(int characterId) async {
    try {
      return await _localDataSource.isFavorite(characterId);
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> clearFavorites() async {
    try {
      await _localDataSource.clearFavorites();
    } catch (e) {
      rethrow;
    }
  }
}

