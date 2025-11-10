import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/character.dart';

part 'character_model.g.dart';

/// Модель данных для персонажа (для JSON сериализации)
@JsonSerializable(explicitToJson: true)
class CharacterModel {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final CharacterLocationModel origin;
  final CharacterLocationModel location;
  final String image;
  final List<String> episode;
  final String created;

  const CharacterModel({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.episode,
    required this.created,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) =>
      _$CharacterModelFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterModelToJson(this);

  /// Преобразование в доменную модель
  Character toDomain() {
    return Character(
      id: id,
      name: name,
      status: status,
      species: species,
      type: type,
      gender: gender,
      origin: origin.toDomain(),
      location: location.toDomain(),
      image: image,
      episode: episode,
      created: DateTime.parse(created),
    );
  }

  /// Создание модели из доменной сущности
  factory CharacterModel.fromDomain(Character character) {
    return CharacterModel(
      id: character.id,
      name: character.name,
      status: character.status,
      species: character.species,
      type: character.type,
      gender: character.gender,
      origin: CharacterLocationModel.fromDomain(character.origin),
      location: CharacterLocationModel.fromDomain(character.location),
      image: character.image,
      episode: character.episode,
      created: character.created.toIso8601String(),
    );
  }
}

/// Модель данных для локации персонажа
@JsonSerializable()
class CharacterLocationModel {
  final String name;
  final String url;

  const CharacterLocationModel({
    required this.name,
    required this.url,
  });

  factory CharacterLocationModel.fromJson(Map<String, dynamic> json) =>
      _$CharacterLocationModelFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterLocationModelToJson(this);

  /// Преобразование в доменную модель
  CharacterLocation toDomain() {
    return CharacterLocation(
      name: name,
      url: url,
    );
  }

  /// Создание модели из доменной сущности
  factory CharacterLocationModel.fromDomain(CharacterLocation location) {
    return CharacterLocationModel(
      name: location.name,
      url: location.url,
    );
  }
}

