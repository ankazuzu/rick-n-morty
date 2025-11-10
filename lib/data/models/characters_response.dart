import 'package:json_annotation/json_annotation.dart';
import 'character_model.dart';

part 'characters_response.g.dart';

/// Модель ответа API со списком персонажей
@JsonSerializable(explicitToJson: true)
class CharactersResponse {
  final CharactersInfo info;
  final List<CharacterModel> results;

  const CharactersResponse({
    required this.info,
    required this.results,
  });

  factory CharactersResponse.fromJson(Map<String, dynamic> json) =>
      _$CharactersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CharactersResponseToJson(this);
}

/// Информация о пагинации
@JsonSerializable()
class CharactersInfo {
  final int count;
  final int pages;
  final String? next;
  final String? prev;

  const CharactersInfo({
    required this.count,
    required this.pages,
    this.next,
    this.prev,
  });

  factory CharactersInfo.fromJson(Map<String, dynamic> json) =>
      _$CharactersInfoFromJson(json);

  Map<String, dynamic> toJson() => _$CharactersInfoToJson(this);
}

