import 'package:rick_morty/domain/entities/character.dart';

/// Моковые данные для тестов
class MockData {
  MockData._();

  static const mockLocation = CharacterLocation(
    name: 'Earth (C-137)',
    url: 'https://rickandmortyapi.com/api/location/1',
  );

  static final mockCharacter1 = Character(
    id: 1,
    name: 'Rick Sanchez',
    status: 'Alive',
    species: 'Human',
    type: '',
    gender: 'Male',
    origin: mockLocation,
    location: mockLocation,
    image: 'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
    episode: ['https://rickandmortyapi.com/api/episode/1'],
    created: DateTime(2017, 11, 4, 18, 48, 46),
  );

  static final mockCharacter2 = Character(
    id: 2,
    name: 'Morty Smith',
    status: 'Alive',
    species: 'Human',
    type: '',
    gender: 'Male',
    origin: mockLocation,
    location: mockLocation,
    image: 'https://rickandmortyapi.com/api/character/avatar/2.jpeg',
    episode: ['https://rickandmortyapi.com/api/episode/1'],
    created: DateTime(2017, 11, 4, 18, 50, 21),
  );

  static final mockCharacter3 = Character(
    id: 3,
    name: 'Summer Smith',
    status: 'Alive',
    species: 'Human',
    type: '',
    gender: 'Female',
    origin: mockLocation,
    location: mockLocation,
    image: 'https://rickandmortyapi.com/api/character/avatar/3.jpeg',
    episode: ['https://rickandmortyapi.com/api/episode/6'],
    created: DateTime(2017, 11, 4, 19, 9, 56),
  );

  static final mockDeadCharacter = Character(
    id: 4,
    name: 'Birdperson',
    status: 'Dead',
    species: 'Alien',
    type: 'Bird-Person',
    gender: 'Male',
    origin: mockLocation,
    location: mockLocation,
    image: 'https://rickandmortyapi.com/api/character/avatar/4.jpeg',
    episode: ['https://rickandmortyapi.com/api/episode/11'],
    created: DateTime(2017, 11, 4, 19, 10, 56),
  );

  static List<Character> get mockCharacters => [
        mockCharacter1,
        mockCharacter2,
        mockCharacter3,
      ];

  static List<Character> get allMockCharacters => [
        mockCharacter1,
        mockCharacter2,
        mockCharacter3,
        mockDeadCharacter,
      ];
}

