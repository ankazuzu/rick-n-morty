import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/api_constants.dart';
import '../../data/datasources/character_remote_datasource.dart';
import '../../data/datasources/favorites_local_datasource.dart';
import '../../data/repositories/character_repository_impl.dart';
import '../../data/repositories/favorites_repository_impl.dart';
import '../../domain/repositories/character_repository.dart';
import '../../domain/repositories/favorites_repository.dart';
import '../../presentation/viewmodels/characters_viewmodel.dart';
import '../../presentation/viewmodels/favorites_viewmodel.dart';
import '../../presentation/viewmodels/theme_viewmodel.dart';

/// Service Locator для Dependency Injection
class ServiceLocator {
  static final ServiceLocator _instance = ServiceLocator._internal();
  factory ServiceLocator() => _instance;
  ServiceLocator._internal();

  // Сервисы
  late final Dio _dio;
  late final SharedPreferences _prefs;

  // Data sources
  late final CharacterRemoteDataSource _characterRemoteDataSource;
  late final FavoritesLocalDataSource _favoritesLocalDataSource;

  // Repositories
  late final CharacterRepository _characterRepository;
  late final FavoritesRepository _favoritesRepository;

  // ViewModels
  late final CharactersViewModel _charactersViewModel;
  late final FavoritesViewModel _favoritesViewModel;
  late final ThemeViewModel _themeViewModel;

  /// Инициализация зависимостей
  Future<void> init() async {
    // Инициализация SharedPreferences
    _prefs = await SharedPreferences.getInstance();

    // Инициализация Dio
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: ApiConstants.connectionTimeout,
        receiveTimeout: ApiConstants.receiveTimeout,
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );

    // Data sources
    _characterRemoteDataSource = CharacterRemoteDataSource(_dio);
    _favoritesLocalDataSource = FavoritesLocalDataSource(_prefs);

    // Repositories
    _characterRepository = CharacterRepositoryImpl(_characterRemoteDataSource);
    _favoritesRepository = FavoritesRepositoryImpl(_favoritesLocalDataSource);

    // ViewModels
    _charactersViewModel = CharactersViewModel(
      _characterRepository,
      _favoritesRepository,
    );
    _favoritesViewModel = FavoritesViewModel(
      _characterRepository,
      _favoritesRepository,
    );
    _themeViewModel = ThemeViewModel(_prefs);
  }

  // Геттеры для зависимостей
  CharactersViewModel get charactersViewModel => _charactersViewModel;
  FavoritesViewModel get favoritesViewModel => _favoritesViewModel;
  ThemeViewModel get themeViewModel => _themeViewModel;
  CharacterRepository get characterRepository => _characterRepository;
  FavoritesRepository get favoritesRepository => _favoritesRepository;
}

