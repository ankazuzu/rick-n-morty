// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CharacterModel _$CharacterModelFromJson(Map<String, dynamic> json) =>
    CharacterModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      status: json['status'] as String,
      species: json['species'] as String,
      type: json['type'] as String,
      gender: json['gender'] as String,
      origin: CharacterLocationModel.fromJson(
          json['origin'] as Map<String, dynamic>),
      location: CharacterLocationModel.fromJson(
          json['location'] as Map<String, dynamic>),
      image: json['image'] as String,
      episode:
          (json['episode'] as List<dynamic>).map((e) => e as String).toList(),
      created: json['created'] as String,
    );

Map<String, dynamic> _$CharacterModelToJson(CharacterModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'status': instance.status,
      'species': instance.species,
      'type': instance.type,
      'gender': instance.gender,
      'origin': instance.origin.toJson(),
      'location': instance.location.toJson(),
      'image': instance.image,
      'episode': instance.episode,
      'created': instance.created,
    };

CharacterLocationModel _$CharacterLocationModelFromJson(
        Map<String, dynamic> json) =>
    CharacterLocationModel(
      name: json['name'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$CharacterLocationModelToJson(
        CharacterLocationModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
    };
