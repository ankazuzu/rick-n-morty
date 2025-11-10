import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/storage_keys.dart';

/// Локальный источник данных для избранных персонажей
class FavoritesLocalDataSource {
  final SharedPreferences _prefs;

  FavoritesLocalDataSource(this._prefs);

  /// Получить список ID избранных персонажей
  Future<List<int>> getFavoriteIds() async {
    final List<String>? ids = _prefs.getStringList(StorageKeys.favoriteCharacterIds);
    if (ids == null) return [];
    return ids.map((id) => int.parse(id)).toList();
  }

  /// Добавить персонажа в избранное
  Future<void> addToFavorites(int characterId) async {
    final ids = await getFavoriteIds();
    if (!ids.contains(characterId)) {
      ids.add(characterId);
      await _prefs.setStringList(
        StorageKeys.favoriteCharacterIds,
        ids.map((id) => id.toString()).toList(),
      );
    }
  }

  /// Удалить персонажа из избранного
  Future<void> removeFromFavorites(int characterId) async {
    final ids = await getFavoriteIds();
    ids.remove(characterId);
    await _prefs.setStringList(
      StorageKeys.favoriteCharacterIds,
      ids.map((id) => id.toString()).toList(),
    );
  }

  /// Проверить, находится ли персонаж в избранном
  Future<bool> isFavorite(int characterId) async {
    final ids = await getFavoriteIds();
    return ids.contains(characterId);
  }

  /// Очистить все избранное
  Future<void> clearFavorites() async {
    await _prefs.remove(StorageKeys.favoriteCharacterIds);
  }
}

