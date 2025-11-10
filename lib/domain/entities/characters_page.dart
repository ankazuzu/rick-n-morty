import 'character.dart';

/// Доменная модель страницы с персонажами (для пагинации)
class CharactersPage {
  final List<Character> characters;
  final int totalCount;
  final int currentPage;
  final int totalPages;
  final bool hasNextPage;

  const CharactersPage({
    required this.characters,
    required this.totalCount,
    required this.currentPage,
    required this.totalPages,
    required this.hasNextPage,
  });

  CharactersPage copyWith({
    List<Character>? characters,
    int? totalCount,
    int? currentPage,
    int? totalPages,
    bool? hasNextPage,
  }) {
    return CharactersPage(
      characters: characters ?? this.characters,
      totalCount: totalCount ?? this.totalCount,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      hasNextPage: hasNextPage ?? this.hasNextPage,
    );
  }
}

