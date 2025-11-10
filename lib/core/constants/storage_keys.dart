/// Ключи для локального хранилища
class StorageKeys {
  StorageKeys._();

  /// Ключ для хранения списка ID избранных персонажей
  static const String favoriteCharacterIds = 'favorite_character_ids';

  /// Ключ для хранения кешированных персонажей
  static const String cachedCharacters = 'cached_characters';

  /// Ключ для времени последнего обновления кеша
  static const String cacheTimestamp = 'cache_timestamp';
}

