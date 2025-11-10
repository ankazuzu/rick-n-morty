/// Интерфейс репозитория для работы с избранными персонажами
abstract class FavoritesRepository {
  /// Получить список ID избранных персонажей
  Future<List<int>> getFavoriteIds();

  /// Добавить персонажа в избранное
  Future<void> addToFavorites(int characterId);

  /// Удалить персонажа из избранного
  Future<void> removeFromFavorites(int characterId);

  /// Проверить, находится ли персонаж в избранном
  Future<bool> isFavorite(int characterId);

  /// Очистить все избранное
  Future<void> clearFavorites();
}

