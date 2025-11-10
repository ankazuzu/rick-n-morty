import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'app_database.g.dart';

/// Таблица персонажей
class Characters extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text()();
  TextColumn get status => text()();
  TextColumn get species => text()();
  TextColumn get type => text()();
  TextColumn get gender => text()();

  // Origin
  TextColumn get originName => text()();
  TextColumn get originUrl => text()();

  // Location
  TextColumn get locationName => text()();
  TextColumn get locationUrl => text()();

  TextColumn get image => text()();
  TextColumn get episode => text()();
  DateTimeColumn get created => dateTime()();
  DateTimeColumn get cachedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<String> get customConstraints => ['UNIQUE(id)'];
}

/// Индексы для быстрого поиска
@DriftAccessor(tables: [Characters])
class CharactersDao extends DatabaseAccessor<AppDatabase>
    with _$CharactersDaoMixin {
  CharactersDao(super.db);

  /// Получить всех персонажей
  Future<List<Character>> getAllCharacters() {
    return select(characters).get();
  }

  /// Получить персонажа по ID
  Future<Character?> getCharacterById(int id) {
    return (select(
      characters,
    )..where((c) => c.id.equals(id))).getSingleOrNull();
  }

  /// Получить персонажей по списку ID
  Future<List<Character>> getCharactersByIds(List<int> ids) {
    return (select(characters)..where((c) => c.id.isIn(ids))).get();
  }

  /// Поиск персонажей по имени
  Future<List<Character>> searchCharactersByName(String query) {
    return (select(characters)
          ..where((c) => c.name.like('%$query%'))
          ..orderBy([(c) => OrderingTerm.asc(c.name)]))
        .get();
  }

  /// Вставить или обновить персонажа
  Future<void> insertOrUpdateCharacter(CharactersCompanion character) {
    return into(characters).insertOnConflictUpdate(character);
  }

  /// Вставить или обновить список персонажей
  Future<void> insertOrUpdateCharacters(
    List<CharactersCompanion> charactersList,
  ) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(characters, charactersList);
    });
  }

  /// Удалить устаревших персонажей (старше 24 часов)
  Future<int> deleteStaleCharacters() {
    final threshold = DateTime.now().subtract(const Duration(hours: 24));
    return (delete(
      characters,
    )..where((c) => c.cachedAt.isSmallerThanValue(threshold))).go();
  }

  /// Очистить всю таблицу
  Future<int> clearAllCharacters() {
    return delete(characters).go();
  }

  /// Получить количество закешированных персонажей
  Future<int> getCharactersCount() async {
    final countExp = characters.id.count();
    final query = selectOnly(characters)..addColumns([countExp]);
    final result = await query.getSingle();
    return result.read(countExp) ?? 0;
  }

  /// Проверить, есть ли персонаж в кеше
  Future<bool> hasCharacter(int id) async {
    final result = await getCharacterById(id);
    return result != null;
  }
}

/// Главная база данных приложения
@DriftDatabase(tables: [Characters], daos: [CharactersDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  /// Конструктор для тестов с in-memory БД
  AppDatabase.memory() : super(NativeDatabase.memory());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
    },
    onUpgrade: (Migrator m, int from, int to) async {
      // Миграции при обновлении схемы
      if (from < 2) {
        // Пример миграции для версии 2
        // await m.addColumn(characters, characters.someNewColumn);
      }
    },
    beforeOpen: (details) async {
      // Включаем поддержку foreign keys
      await customStatement('PRAGMA foreign_keys = ON');

      // Очищаем устаревший кеш при открытии
      if (details.wasCreated) {
        // База только создана, ничего не делаем
      } else {
        // Очищаем старые записи
        await charactersDao.deleteStaleCharacters();
      }
    },
  );
}

/// Открытие соединения с базой данных
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'rick_morty.db'));
    return NativeDatabase(file);
  });
}
