import '../entities/character.dart';
import '../entities/characters_page.dart';

/// Интерфейс репозитория для работы с персонажами
abstract class CharacterRepository {
  /// Получить список персонажей с пагинацией
  Future<CharactersPage> getCharacters({int page = 1});

  /// Получить персонажа по ID
  Future<Character?> getCharacterById(int id);

  /// Получить список персонажей по списку ID
  Future<List<Character>> getCharactersByIds(List<int> ids);

  /// Поиск персонажей по имени
  Future<CharactersPage> searchCharacters({
    required String name,
    int page = 1,
  });
}

