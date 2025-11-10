import 'package:flutter_test/flutter_test.dart';
import 'package:rick_morty/domain/entities/character.dart';

void main() {
  group('Character Entity', () {
    test('should create character with all properties', () {
      // Arrange & Act
      const location = CharacterLocation(name: 'Earth', url: 'url');
      final character = Character(
        id: 1,
        name: 'Rick',
        status: 'Alive',
        species: 'Human',
        type: '',
        gender: 'Male',
        origin: location,
        location: location,
        image: 'image.jpg',
        episode: ['ep1'],
        created: DateTime(2020),
      );

      // Assert
      expect(character.id, 1);
      expect(character.name, 'Rick');
      expect(character.status, 'Alive');
      expect(character.species, 'Human');
    });

    test('should copy character with new values', () {
      // Arrange
      const location = CharacterLocation(name: 'Earth', url: 'url');
      final character = Character(
        id: 1,
        name: 'Rick',
        status: 'Alive',
        species: 'Human',
        type: '',
        gender: 'Male',
        origin: location,
        location: location,
        image: 'image.jpg',
        episode: ['ep1'],
        created: DateTime(2020),
      );

      // Act
      final copied = character.copyWith(name: 'Morty', status: 'Dead');

      // Assert
      expect(copied.id, 1);
      expect(copied.name, 'Morty');
      expect(copied.status, 'Dead');
      expect(copied.species, 'Human');
    });

    test('should compare characters by id', () {
      // Arrange
      const location = CharacterLocation(name: 'Earth', url: 'url');
      final character1 = Character(
        id: 1,
        name: 'Rick',
        status: 'Alive',
        species: 'Human',
        type: '',
        gender: 'Male',
        origin: location,
        location: location,
        image: 'image.jpg',
        episode: ['ep1'],
        created: DateTime(2020),
      );

      final character2 = Character(
        id: 1,
        name: 'Different Name',
        status: 'Dead',
        species: 'Alien',
        type: '',
        gender: 'Female',
        origin: location,
        location: location,
        image: 'other.jpg',
        episode: ['ep2'],
        created: DateTime(2021),
      );

      final character3 = Character(
        id: 2,
        name: 'Rick',
        status: 'Alive',
        species: 'Human',
        type: '',
        gender: 'Male',
        origin: location,
        location: location,
        image: 'image.jpg',
        episode: ['ep1'],
        created: DateTime(2020),
      );

      // Assert
      expect(character1 == character2, true);
      expect(character1 == character3, false);
    });
  });

  group('CharacterLocation', () {
    test('should create location with name and url', () {
      // Arrange & Act
      const location = CharacterLocation(name: 'Earth', url: 'url');

      // Assert
      expect(location.name, 'Earth');
      expect(location.url, 'url');
    });

    test('should copy location with new values', () {
      // Arrange
      const location = CharacterLocation(name: 'Earth', url: 'url');

      // Act
      final copied = location.copyWith(name: 'Mars');

      // Assert
      expect(copied.name, 'Mars');
      expect(copied.url, 'url');
    });

    test('should compare locations by name and url', () {
      // Arrange
      const location1 = CharacterLocation(name: 'Earth', url: 'url');
      const location2 = CharacterLocation(name: 'Earth', url: 'url');
      const location3 = CharacterLocation(name: 'Mars', url: 'url');

      // Assert
      expect(location1 == location2, true);
      expect(location1 == location3, false);
    });
  });
}

