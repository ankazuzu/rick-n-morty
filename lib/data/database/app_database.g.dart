// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
mixin _$CharactersDaoMixin on DatabaseAccessor<AppDatabase> {
  $CharactersTable get characters => attachedDatabase.characters;
}

class $CharactersTable extends Characters
    with TableInfo<$CharactersTable, Character> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CharactersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _speciesMeta =
      const VerificationMeta('species');
  @override
  late final GeneratedColumn<String> species = GeneratedColumn<String>(
      'species', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  @override
  late final GeneratedColumn<String> gender = GeneratedColumn<String>(
      'gender', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _originNameMeta =
      const VerificationMeta('originName');
  @override
  late final GeneratedColumn<String> originName = GeneratedColumn<String>(
      'origin_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _originUrlMeta =
      const VerificationMeta('originUrl');
  @override
  late final GeneratedColumn<String> originUrl = GeneratedColumn<String>(
      'origin_url', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _locationNameMeta =
      const VerificationMeta('locationName');
  @override
  late final GeneratedColumn<String> locationName = GeneratedColumn<String>(
      'location_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _locationUrlMeta =
      const VerificationMeta('locationUrl');
  @override
  late final GeneratedColumn<String> locationUrl = GeneratedColumn<String>(
      'location_url', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _imageMeta = const VerificationMeta('image');
  @override
  late final GeneratedColumn<String> image = GeneratedColumn<String>(
      'image', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _episodeMeta =
      const VerificationMeta('episode');
  @override
  late final GeneratedColumn<String> episode = GeneratedColumn<String>(
      'episode', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdMeta =
      const VerificationMeta('created');
  @override
  late final GeneratedColumn<DateTime> created = GeneratedColumn<DateTime>(
      'created', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _cachedAtMeta =
      const VerificationMeta('cachedAt');
  @override
  late final GeneratedColumn<DateTime> cachedAt = GeneratedColumn<DateTime>(
      'cached_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        status,
        species,
        type,
        gender,
        originName,
        originUrl,
        locationName,
        locationUrl,
        image,
        episode,
        created,
        cachedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'characters';
  @override
  VerificationContext validateIntegrity(Insertable<Character> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('species')) {
      context.handle(_speciesMeta,
          species.isAcceptableOrUnknown(data['species']!, _speciesMeta));
    } else if (isInserting) {
      context.missing(_speciesMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('gender')) {
      context.handle(_genderMeta,
          gender.isAcceptableOrUnknown(data['gender']!, _genderMeta));
    } else if (isInserting) {
      context.missing(_genderMeta);
    }
    if (data.containsKey('origin_name')) {
      context.handle(
          _originNameMeta,
          originName.isAcceptableOrUnknown(
              data['origin_name']!, _originNameMeta));
    } else if (isInserting) {
      context.missing(_originNameMeta);
    }
    if (data.containsKey('origin_url')) {
      context.handle(_originUrlMeta,
          originUrl.isAcceptableOrUnknown(data['origin_url']!, _originUrlMeta));
    } else if (isInserting) {
      context.missing(_originUrlMeta);
    }
    if (data.containsKey('location_name')) {
      context.handle(
          _locationNameMeta,
          locationName.isAcceptableOrUnknown(
              data['location_name']!, _locationNameMeta));
    } else if (isInserting) {
      context.missing(_locationNameMeta);
    }
    if (data.containsKey('location_url')) {
      context.handle(
          _locationUrlMeta,
          locationUrl.isAcceptableOrUnknown(
              data['location_url']!, _locationUrlMeta));
    } else if (isInserting) {
      context.missing(_locationUrlMeta);
    }
    if (data.containsKey('image')) {
      context.handle(
          _imageMeta, image.isAcceptableOrUnknown(data['image']!, _imageMeta));
    } else if (isInserting) {
      context.missing(_imageMeta);
    }
    if (data.containsKey('episode')) {
      context.handle(_episodeMeta,
          episode.isAcceptableOrUnknown(data['episode']!, _episodeMeta));
    } else if (isInserting) {
      context.missing(_episodeMeta);
    }
    if (data.containsKey('created')) {
      context.handle(_createdMeta,
          created.isAcceptableOrUnknown(data['created']!, _createdMeta));
    } else if (isInserting) {
      context.missing(_createdMeta);
    }
    if (data.containsKey('cached_at')) {
      context.handle(_cachedAtMeta,
          cachedAt.isAcceptableOrUnknown(data['cached_at']!, _cachedAtMeta));
    } else if (isInserting) {
      context.missing(_cachedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Character map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Character(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      species: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}species'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      gender: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}gender'])!,
      originName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}origin_name'])!,
      originUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}origin_url'])!,
      locationName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}location_name'])!,
      locationUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}location_url'])!,
      image: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image'])!,
      episode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}episode'])!,
      created: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created'])!,
      cachedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}cached_at'])!,
    );
  }

  @override
  $CharactersTable createAlias(String alias) {
    return $CharactersTable(attachedDatabase, alias);
  }
}

class Character extends DataClass implements Insertable<Character> {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final String originName;
  final String originUrl;
  final String locationName;
  final String locationUrl;
  final String image;
  final String episode;
  final DateTime created;
  final DateTime cachedAt;
  const Character(
      {required this.id,
      required this.name,
      required this.status,
      required this.species,
      required this.type,
      required this.gender,
      required this.originName,
      required this.originUrl,
      required this.locationName,
      required this.locationUrl,
      required this.image,
      required this.episode,
      required this.created,
      required this.cachedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['status'] = Variable<String>(status);
    map['species'] = Variable<String>(species);
    map['type'] = Variable<String>(type);
    map['gender'] = Variable<String>(gender);
    map['origin_name'] = Variable<String>(originName);
    map['origin_url'] = Variable<String>(originUrl);
    map['location_name'] = Variable<String>(locationName);
    map['location_url'] = Variable<String>(locationUrl);
    map['image'] = Variable<String>(image);
    map['episode'] = Variable<String>(episode);
    map['created'] = Variable<DateTime>(created);
    map['cached_at'] = Variable<DateTime>(cachedAt);
    return map;
  }

  CharactersCompanion toCompanion(bool nullToAbsent) {
    return CharactersCompanion(
      id: Value(id),
      name: Value(name),
      status: Value(status),
      species: Value(species),
      type: Value(type),
      gender: Value(gender),
      originName: Value(originName),
      originUrl: Value(originUrl),
      locationName: Value(locationName),
      locationUrl: Value(locationUrl),
      image: Value(image),
      episode: Value(episode),
      created: Value(created),
      cachedAt: Value(cachedAt),
    );
  }

  factory Character.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Character(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      status: serializer.fromJson<String>(json['status']),
      species: serializer.fromJson<String>(json['species']),
      type: serializer.fromJson<String>(json['type']),
      gender: serializer.fromJson<String>(json['gender']),
      originName: serializer.fromJson<String>(json['originName']),
      originUrl: serializer.fromJson<String>(json['originUrl']),
      locationName: serializer.fromJson<String>(json['locationName']),
      locationUrl: serializer.fromJson<String>(json['locationUrl']),
      image: serializer.fromJson<String>(json['image']),
      episode: serializer.fromJson<String>(json['episode']),
      created: serializer.fromJson<DateTime>(json['created']),
      cachedAt: serializer.fromJson<DateTime>(json['cachedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'status': serializer.toJson<String>(status),
      'species': serializer.toJson<String>(species),
      'type': serializer.toJson<String>(type),
      'gender': serializer.toJson<String>(gender),
      'originName': serializer.toJson<String>(originName),
      'originUrl': serializer.toJson<String>(originUrl),
      'locationName': serializer.toJson<String>(locationName),
      'locationUrl': serializer.toJson<String>(locationUrl),
      'image': serializer.toJson<String>(image),
      'episode': serializer.toJson<String>(episode),
      'created': serializer.toJson<DateTime>(created),
      'cachedAt': serializer.toJson<DateTime>(cachedAt),
    };
  }

  Character copyWith(
          {int? id,
          String? name,
          String? status,
          String? species,
          String? type,
          String? gender,
          String? originName,
          String? originUrl,
          String? locationName,
          String? locationUrl,
          String? image,
          String? episode,
          DateTime? created,
          DateTime? cachedAt}) =>
      Character(
        id: id ?? this.id,
        name: name ?? this.name,
        status: status ?? this.status,
        species: species ?? this.species,
        type: type ?? this.type,
        gender: gender ?? this.gender,
        originName: originName ?? this.originName,
        originUrl: originUrl ?? this.originUrl,
        locationName: locationName ?? this.locationName,
        locationUrl: locationUrl ?? this.locationUrl,
        image: image ?? this.image,
        episode: episode ?? this.episode,
        created: created ?? this.created,
        cachedAt: cachedAt ?? this.cachedAt,
      );
  Character copyWithCompanion(CharactersCompanion data) {
    return Character(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      status: data.status.present ? data.status.value : this.status,
      species: data.species.present ? data.species.value : this.species,
      type: data.type.present ? data.type.value : this.type,
      gender: data.gender.present ? data.gender.value : this.gender,
      originName:
          data.originName.present ? data.originName.value : this.originName,
      originUrl: data.originUrl.present ? data.originUrl.value : this.originUrl,
      locationName: data.locationName.present
          ? data.locationName.value
          : this.locationName,
      locationUrl:
          data.locationUrl.present ? data.locationUrl.value : this.locationUrl,
      image: data.image.present ? data.image.value : this.image,
      episode: data.episode.present ? data.episode.value : this.episode,
      created: data.created.present ? data.created.value : this.created,
      cachedAt: data.cachedAt.present ? data.cachedAt.value : this.cachedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Character(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('status: $status, ')
          ..write('species: $species, ')
          ..write('type: $type, ')
          ..write('gender: $gender, ')
          ..write('originName: $originName, ')
          ..write('originUrl: $originUrl, ')
          ..write('locationName: $locationName, ')
          ..write('locationUrl: $locationUrl, ')
          ..write('image: $image, ')
          ..write('episode: $episode, ')
          ..write('created: $created, ')
          ..write('cachedAt: $cachedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      name,
      status,
      species,
      type,
      gender,
      originName,
      originUrl,
      locationName,
      locationUrl,
      image,
      episode,
      created,
      cachedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Character &&
          other.id == this.id &&
          other.name == this.name &&
          other.status == this.status &&
          other.species == this.species &&
          other.type == this.type &&
          other.gender == this.gender &&
          other.originName == this.originName &&
          other.originUrl == this.originUrl &&
          other.locationName == this.locationName &&
          other.locationUrl == this.locationUrl &&
          other.image == this.image &&
          other.episode == this.episode &&
          other.created == this.created &&
          other.cachedAt == this.cachedAt);
}

class CharactersCompanion extends UpdateCompanion<Character> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> status;
  final Value<String> species;
  final Value<String> type;
  final Value<String> gender;
  final Value<String> originName;
  final Value<String> originUrl;
  final Value<String> locationName;
  final Value<String> locationUrl;
  final Value<String> image;
  final Value<String> episode;
  final Value<DateTime> created;
  final Value<DateTime> cachedAt;
  const CharactersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.status = const Value.absent(),
    this.species = const Value.absent(),
    this.type = const Value.absent(),
    this.gender = const Value.absent(),
    this.originName = const Value.absent(),
    this.originUrl = const Value.absent(),
    this.locationName = const Value.absent(),
    this.locationUrl = const Value.absent(),
    this.image = const Value.absent(),
    this.episode = const Value.absent(),
    this.created = const Value.absent(),
    this.cachedAt = const Value.absent(),
  });
  CharactersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String status,
    required String species,
    required String type,
    required String gender,
    required String originName,
    required String originUrl,
    required String locationName,
    required String locationUrl,
    required String image,
    required String episode,
    required DateTime created,
    required DateTime cachedAt,
  })  : name = Value(name),
        status = Value(status),
        species = Value(species),
        type = Value(type),
        gender = Value(gender),
        originName = Value(originName),
        originUrl = Value(originUrl),
        locationName = Value(locationName),
        locationUrl = Value(locationUrl),
        image = Value(image),
        episode = Value(episode),
        created = Value(created),
        cachedAt = Value(cachedAt);
  static Insertable<Character> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? status,
    Expression<String>? species,
    Expression<String>? type,
    Expression<String>? gender,
    Expression<String>? originName,
    Expression<String>? originUrl,
    Expression<String>? locationName,
    Expression<String>? locationUrl,
    Expression<String>? image,
    Expression<String>? episode,
    Expression<DateTime>? created,
    Expression<DateTime>? cachedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (status != null) 'status': status,
      if (species != null) 'species': species,
      if (type != null) 'type': type,
      if (gender != null) 'gender': gender,
      if (originName != null) 'origin_name': originName,
      if (originUrl != null) 'origin_url': originUrl,
      if (locationName != null) 'location_name': locationName,
      if (locationUrl != null) 'location_url': locationUrl,
      if (image != null) 'image': image,
      if (episode != null) 'episode': episode,
      if (created != null) 'created': created,
      if (cachedAt != null) 'cached_at': cachedAt,
    });
  }

  CharactersCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? status,
      Value<String>? species,
      Value<String>? type,
      Value<String>? gender,
      Value<String>? originName,
      Value<String>? originUrl,
      Value<String>? locationName,
      Value<String>? locationUrl,
      Value<String>? image,
      Value<String>? episode,
      Value<DateTime>? created,
      Value<DateTime>? cachedAt}) {
    return CharactersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      species: species ?? this.species,
      type: type ?? this.type,
      gender: gender ?? this.gender,
      originName: originName ?? this.originName,
      originUrl: originUrl ?? this.originUrl,
      locationName: locationName ?? this.locationName,
      locationUrl: locationUrl ?? this.locationUrl,
      image: image ?? this.image,
      episode: episode ?? this.episode,
      created: created ?? this.created,
      cachedAt: cachedAt ?? this.cachedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (species.present) {
      map['species'] = Variable<String>(species.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (gender.present) {
      map['gender'] = Variable<String>(gender.value);
    }
    if (originName.present) {
      map['origin_name'] = Variable<String>(originName.value);
    }
    if (originUrl.present) {
      map['origin_url'] = Variable<String>(originUrl.value);
    }
    if (locationName.present) {
      map['location_name'] = Variable<String>(locationName.value);
    }
    if (locationUrl.present) {
      map['location_url'] = Variable<String>(locationUrl.value);
    }
    if (image.present) {
      map['image'] = Variable<String>(image.value);
    }
    if (episode.present) {
      map['episode'] = Variable<String>(episode.value);
    }
    if (created.present) {
      map['created'] = Variable<DateTime>(created.value);
    }
    if (cachedAt.present) {
      map['cached_at'] = Variable<DateTime>(cachedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CharactersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('status: $status, ')
          ..write('species: $species, ')
          ..write('type: $type, ')
          ..write('gender: $gender, ')
          ..write('originName: $originName, ')
          ..write('originUrl: $originUrl, ')
          ..write('locationName: $locationName, ')
          ..write('locationUrl: $locationUrl, ')
          ..write('image: $image, ')
          ..write('episode: $episode, ')
          ..write('created: $created, ')
          ..write('cachedAt: $cachedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CharactersTable characters = $CharactersTable(this);
  late final CharactersDao charactersDao = CharactersDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [characters];
}

typedef $$CharactersTableCreateCompanionBuilder = CharactersCompanion Function({
  Value<int> id,
  required String name,
  required String status,
  required String species,
  required String type,
  required String gender,
  required String originName,
  required String originUrl,
  required String locationName,
  required String locationUrl,
  required String image,
  required String episode,
  required DateTime created,
  required DateTime cachedAt,
});
typedef $$CharactersTableUpdateCompanionBuilder = CharactersCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> status,
  Value<String> species,
  Value<String> type,
  Value<String> gender,
  Value<String> originName,
  Value<String> originUrl,
  Value<String> locationName,
  Value<String> locationUrl,
  Value<String> image,
  Value<String> episode,
  Value<DateTime> created,
  Value<DateTime> cachedAt,
});

class $$CharactersTableFilterComposer
    extends Composer<_$AppDatabase, $CharactersTable> {
  $$CharactersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get species => $composableBuilder(
      column: $table.species, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get gender => $composableBuilder(
      column: $table.gender, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get originName => $composableBuilder(
      column: $table.originName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get originUrl => $composableBuilder(
      column: $table.originUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get locationName => $composableBuilder(
      column: $table.locationName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get locationUrl => $composableBuilder(
      column: $table.locationUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get image => $composableBuilder(
      column: $table.image, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get episode => $composableBuilder(
      column: $table.episode, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get created => $composableBuilder(
      column: $table.created, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get cachedAt => $composableBuilder(
      column: $table.cachedAt, builder: (column) => ColumnFilters(column));
}

class $$CharactersTableOrderingComposer
    extends Composer<_$AppDatabase, $CharactersTable> {
  $$CharactersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get species => $composableBuilder(
      column: $table.species, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get gender => $composableBuilder(
      column: $table.gender, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get originName => $composableBuilder(
      column: $table.originName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get originUrl => $composableBuilder(
      column: $table.originUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get locationName => $composableBuilder(
      column: $table.locationName,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get locationUrl => $composableBuilder(
      column: $table.locationUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get image => $composableBuilder(
      column: $table.image, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get episode => $composableBuilder(
      column: $table.episode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get created => $composableBuilder(
      column: $table.created, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get cachedAt => $composableBuilder(
      column: $table.cachedAt, builder: (column) => ColumnOrderings(column));
}

class $$CharactersTableAnnotationComposer
    extends Composer<_$AppDatabase, $CharactersTable> {
  $$CharactersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get species =>
      $composableBuilder(column: $table.species, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get gender =>
      $composableBuilder(column: $table.gender, builder: (column) => column);

  GeneratedColumn<String> get originName => $composableBuilder(
      column: $table.originName, builder: (column) => column);

  GeneratedColumn<String> get originUrl =>
      $composableBuilder(column: $table.originUrl, builder: (column) => column);

  GeneratedColumn<String> get locationName => $composableBuilder(
      column: $table.locationName, builder: (column) => column);

  GeneratedColumn<String> get locationUrl => $composableBuilder(
      column: $table.locationUrl, builder: (column) => column);

  GeneratedColumn<String> get image =>
      $composableBuilder(column: $table.image, builder: (column) => column);

  GeneratedColumn<String> get episode =>
      $composableBuilder(column: $table.episode, builder: (column) => column);

  GeneratedColumn<DateTime> get created =>
      $composableBuilder(column: $table.created, builder: (column) => column);

  GeneratedColumn<DateTime> get cachedAt =>
      $composableBuilder(column: $table.cachedAt, builder: (column) => column);
}

class $$CharactersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CharactersTable,
    Character,
    $$CharactersTableFilterComposer,
    $$CharactersTableOrderingComposer,
    $$CharactersTableAnnotationComposer,
    $$CharactersTableCreateCompanionBuilder,
    $$CharactersTableUpdateCompanionBuilder,
    (Character, BaseReferences<_$AppDatabase, $CharactersTable, Character>),
    Character,
    PrefetchHooks Function()> {
  $$CharactersTableTableManager(_$AppDatabase db, $CharactersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CharactersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CharactersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CharactersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String> species = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<String> gender = const Value.absent(),
            Value<String> originName = const Value.absent(),
            Value<String> originUrl = const Value.absent(),
            Value<String> locationName = const Value.absent(),
            Value<String> locationUrl = const Value.absent(),
            Value<String> image = const Value.absent(),
            Value<String> episode = const Value.absent(),
            Value<DateTime> created = const Value.absent(),
            Value<DateTime> cachedAt = const Value.absent(),
          }) =>
              CharactersCompanion(
            id: id,
            name: name,
            status: status,
            species: species,
            type: type,
            gender: gender,
            originName: originName,
            originUrl: originUrl,
            locationName: locationName,
            locationUrl: locationUrl,
            image: image,
            episode: episode,
            created: created,
            cachedAt: cachedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required String status,
            required String species,
            required String type,
            required String gender,
            required String originName,
            required String originUrl,
            required String locationName,
            required String locationUrl,
            required String image,
            required String episode,
            required DateTime created,
            required DateTime cachedAt,
          }) =>
              CharactersCompanion.insert(
            id: id,
            name: name,
            status: status,
            species: species,
            type: type,
            gender: gender,
            originName: originName,
            originUrl: originUrl,
            locationName: locationName,
            locationUrl: locationUrl,
            image: image,
            episode: episode,
            created: created,
            cachedAt: cachedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CharactersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CharactersTable,
    Character,
    $$CharactersTableFilterComposer,
    $$CharactersTableOrderingComposer,
    $$CharactersTableAnnotationComposer,
    $$CharactersTableCreateCompanionBuilder,
    $$CharactersTableUpdateCompanionBuilder,
    (Character, BaseReferences<_$AppDatabase, $CharactersTable, Character>),
    Character,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CharactersTableTableManager get characters =>
      $$CharactersTableTableManager(_db, _db.characters);
}
