# Архитектура приложения Rick and Morty

## Обзор

Приложение построено с использованием **Clean Architecture** и паттерна **MVVM** для обеспечения масштабируемости, тестируемости и разделения ответственности.

## Структура проекта

```
lib/
├── core/                          # Ядро приложения
│   ├── constants/                 # Константы (API, ключи хранилища)
│   ├── di/                        # Dependency Injection (Service Locator)
│   ├── theme/                     # Тема приложения
│   └── utils/                     # Утилиты
│
├── data/                          # Слой данных
│   ├── datasources/               # Источники данных
│   │   ├── character_remote_datasource.dart    # API
│   │   └── favorites_local_datasource.dart     # Локальное хранилище
│   ├── models/                    # Модели данных (DTO)
│   │   ├── character_model.dart
│   │   └── characters_response.dart
│   └── repositories/              # Реализации репозиториев
│       ├── character_repository_impl.dart
│       └── favorites_repository_impl.dart
│
├── domain/                        # Доменный слой (бизнес-логика)
│   ├── entities/                  # Доменные сущности
│   │   ├── character.dart
│   │   └── characters_page.dart
│   └── repositories/              # Интерфейсы репозиториев
│       ├── character_repository.dart
│       └── favorites_repository.dart
│
├── presentation/                  # Слой представления
│   ├── router/                    # Навигация (go_router)
│   │   └── app_router.dart
│   ├── screens/                   # Экраны
│   │   ├── characters_screen.dart
│   │   └── favorites_screen.dart
│   ├── viewmodels/                # ViewModels (Provider)
│   │   ├── characters_viewmodel.dart
│   │   └── favorites_viewmodel.dart
│   └── widgets/                   # Переиспользуемые виджеты
│       ├── character_card.dart
│       ├── loading_indicator.dart
│       ├── error_view.dart
│       ├── empty_state_view.dart
│       └── main_scaffold.dart
│
└── main.dart                      # Точка входа
```

## Слои архитектуры

### 1. Presentation Layer (Слой представления)

**Ответственность**: UI логика, взаимодействие с пользователем, отображение данных.

**Компоненты**:
- **Screens**: Экраны приложения
- **ViewModels**: Управление состоянием через Provider/ChangeNotifier
- **Widgets**: Переиспользуемые UI компоненты
- **Router**: Навигация через go_router

**Технологии**:
- Provider для state management
- go_router для навигации
- Material Design 3

### 2. Domain Layer (Доменный слой)

**Ответственность**: Бизнес-логика, доменные модели, интерфейсы репозиториев.

**Компоненты**:
- **Entities**: Чистые доменные модели (Character, CharacterLocation)
- **Repositories**: Интерфейсы для работы с данными

**Принципы**:
- Не зависит от внешних фреймворков
- Содержит только бизнес-логику
- Определяет контракты для data layer

### 3. Data Layer (Слой данных)

**Ответственность**: Получение и хранение данных из различных источников.

**Компоненты**:
- **DataSources**: 
  - `CharacterRemoteDataSource` - работа с API
  - `FavoritesLocalDataSource` - локальное хранилище
- **Models**: DTO модели с JSON сериализацией
- **Repositories**: Реализация интерфейсов из domain слоя

**Технологии**:
- Dio для HTTP запросов
- SharedPreferences для локального хранилища
- json_serializable для парсинга JSON

## Ключевые паттерны

### MVVM (Model-View-ViewModel)

```
View (Widget) ←→ ViewModel (ChangeNotifier) ←→ Repository ←→ DataSource
```

- **View**: Flutter виджеты, слушают изменения ViewModel
- **ViewModel**: Управляет состоянием, бизнес-логикой UI
- **Model**: Доменные сущности и data модели

### Repository Pattern

Абстрагирует источники данных:
```dart
abstract class CharacterRepository {
  Future<CharactersPage> getCharacters({int page = 1});
  Future<Character?> getCharacterById(int id);
  // ...
}
```

Реализация работает с конкретными data sources:
```dart
class CharacterRepositoryImpl implements CharacterRepository {
  final CharacterRemoteDataSource _remoteDataSource;
  // ...
}
```

### Dependency Injection

Используется Service Locator паттерн для управления зависимостями:
```dart
class ServiceLocator {
  Future<void> init() async {
    // Инициализация всех зависимостей
  }
  
  CharactersViewModel get charactersViewModel => _charactersViewModel;
  // ...
}
```

## Основные функции

### 1. Список персонажей
- Отображение в виде сетки карточек
- Пагинация (бесконечный скролл)
- Поиск по имени
- Pull-to-refresh
- Добавление/удаление из избранного

### 2. Избранное
- Список избранных персонажей
- Сортировка (по имени, статусу, виду)
- Удаление из избранного
- Очистка всех избранных
- Локальное хранилище

### 3. Кеширование
- Кеширование изображений (cached_network_image)
- Локальное хранение избранных ID

## Навигация

Использует `go_router` с `StatefulShellRoute` для навигации через BottomNavigationBar:

```
/characters → CharactersScreen
/favorites  → FavoritesScreen
```

## State Management

**Provider** с `ChangeNotifier`:
- `CharactersViewModel` - состояние списка персонажей
- `FavoritesViewModel` - состояние избранного

## API Integration

**Rick and Morty API**: https://rickandmortyapi.com/api

Endpoints:
- `GET /character` - список персонажей
- `GET /character/{id}` - персонаж по ID
- `GET /character/{ids}` - несколько персонажей по ID
- `GET /character/?name={name}` - поиск по имени

## Обработка ошибок

1. **Network errors**: Отображение ErrorView с кнопкой повтора
2. **Empty state**: Отображение EmptyStateView
3. **Loading state**: Отображение LoadingIndicator

## Тестирование

Архитектура позволяет легко тестировать:
- **Unit tests**: ViewModels, Repositories, DataSources
- **Widget tests**: UI компоненты
- **Integration tests**: Полные потоки приложения

## Масштабируемость

Архитектура легко расширяется:
1. Добавление новых экранов - создать Screen + ViewModel
2. Добавление новых источников данных - создать DataSource
3. Добавление новой бизнес-логики - расширить domain layer

## Зависимости

### Основные
- `flutter` - UI фреймворк
- `provider` - State management
- `go_router` - Навигация
- `dio` - HTTP клиент
- `shared_preferences` - Локальное хранилище
- `cached_network_image` - Кеширование изображений
- `json_annotation` / `json_serializable` - JSON парсинг

### Dev
- `build_runner` - Code generation
- `flutter_lints` - Linting

## Запуск приложения

```bash
# Установка зависимостей
flutter pub get

# Генерация кода для JSON
flutter pub run build_runner build --delete-conflicting-outputs

# Запуск приложения
flutter run

# Анализ кода
flutter analyze
```

