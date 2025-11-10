# Поток данных в приложении

## Общая схема

```
┌─────────────────────────────────────────────────────────────┐
│                      PRESENTATION LAYER                      │
├─────────────────────────────────────────────────────────────┤
│  ┌──────────┐         ┌──────────┐                          │
│  │  Screen  │◄───────►│ ViewModel│◄────┐                    │
│  └──────────┘         └──────────┘     │                    │
│       │                     │           │                    │
│       │                     │           │                    │
│       ▼                     ▼           │                    │
│  ┌──────────┐         ┌──────────┐     │                    │
│  │ Widgets  │         │ Provider │     │                    │
│  └──────────┘         └──────────┘     │                    │
└─────────────────────────────────────────┼────────────────────┘
                                          │
                                          │
┌─────────────────────────────────────────┼────────────────────┐
│                      DOMAIN LAYER        │                    │
├──────────────────────────────────────────┼───────────────────┤
│                              ┌───────────▼─────────┐         │
│  ┌──────────┐                │   Repository       │         │
│  │ Entities │◄───────────────┤   (Interface)      │         │
│  └──────────┘                └───────────┬─────────┘         │
└─────────────────────────────────────────┼────────────────────┘
                                          │
                                          │
┌─────────────────────────────────────────┼────────────────────┐
│                      DATA LAYER          │                    │
├──────────────────────────────────────────┼───────────────────┤
│                          ┌───────────────▼───────────┐       │
│  ┌──────────┐            │  Repository Impl          │       │
│  │  Models  │◄───────────┤  (Implementation)         │       │
│  │  (DTO)   │            └───────┬───────────┬───────┘       │
│  └──────────┘                    │           │               │
│                                  │           │               │
│                        ┌─────────▼──┐   ┌────▼──────────┐   │
│                        │  Remote    │   │  Local        │   │
│                        │  DataSource│   │  DataSource   │   │
│                        └─────────┬──┘   └────┬──────────┘   │
└──────────────────────────────────┼───────────┼──────────────┘
                                   │           │
                                   │           │
┌──────────────────────────────────┼───────────┼──────────────┐
│                  EXTERNAL         │           │              │
├───────────────────────────────────┼───────────┼─────────────┤
│                        ┌──────────▼──┐   ┌────▼──────────┐  │
│                        │  Rick&Morty │   │  Shared       │  │
│                        │  API (Dio)  │   │  Preferences  │  │
│                        └─────────────┘   └───────────────┘  │
└─────────────────────────────────────────────────────────────┘
```

## Основные потоки

### 1. Загрузка списка персонажей

```
User Action (Screen)
    ↓
ViewModel.loadCharacters()
    ↓
CharacterRepository.getCharacters()
    ↓
CharacterRemoteDataSource.getCharacters()
    ↓
API Request (Dio)
    ↓
API Response (JSON)
    ↓
CharacterModel.fromJson() → Character (Domain)
    ↓
ViewModel (notifyListeners)
    ↓
UI Update (Consumer<ViewModel>)
```

### 2. Добавление в избранное

```
User Tap (Star Icon)
    ↓
ViewModel.toggleFavorite(id)
    ↓
FavoritesRepository.addToFavorites(id)
    ↓
FavoritesLocalDataSource.addToFavorites(id)
    ↓
SharedPreferences.setStringList()
    ↓
ViewModel._favoriteIds.add(id)
    ↓
ViewModel.notifyListeners()
    ↓
UI Update (Star Icon filled)
```

### 3. Загрузка избранных персонажей

```
User Navigate to Favorites
    ↓
FavoritesViewModel.loadFavorites()
    ↓
FavoritesRepository.getFavoriteIds()
    ↓
FavoritesLocalDataSource.getFavoriteIds()
    ↓
SharedPreferences.getStringList()
    ↓
CharacterRepository.getCharactersByIds(ids)
    ↓
CharacterRemoteDataSource.getCharactersByIds(ids)
    ↓
API Request (Multiple IDs)
    ↓
List<Character> (Domain)
    ↓
FavoritesViewModel._favoriteCharacters
    ↓
FavoritesViewModel._getSortedCharacters()
    ↓
UI Update (Grid with sorted characters)
```

### 4. Поиск персонажей

```
User Input (Search Field)
    ↓
_onSearchChanged(query) [Debounce 500ms]
    ↓
ViewModel.searchCharacters(query)
    ↓
CharacterRepository.searchCharacters(name: query)
    ↓
CharacterRemoteDataSource.searchCharacters(name: query)
    ↓
API Request with query params
    ↓
CharactersResponse
    ↓
List<Character> (Domain)
    ↓
ViewModel._characters = results
    ↓
UI Update (Filtered list)
```

### 5. Пагинация

```
User Scrolls to Bottom
    ↓
ScrollController.addListener()
    ↓
if (maxScrollExtent - 200) & !isLoadingMore & hasNextPage
    ↓
ViewModel.loadMoreCharacters()
    ↓
CharacterRepository.getCharacters(page: currentPage + 1)
    ↓
API Request (page=N)
    ↓
CharactersResponse
    ↓
ViewModel._characters.addAll(newCharacters)
    ↓
UI Update (More cards added to grid)
```

## Управление состоянием

### CharactersViewModel State

```dart
{
  List<Character> _characters,       // Список персонажей
  bool _isLoading,                    // Загрузка первой страницы
  bool _isLoadingMore,                // Загрузка следующей страницы
  String? _error,                     // Ошибка
  int _currentPage,                   // Текущая страница
  bool _hasNextPage,                  // Есть ли следующая страница
  Set<int> _favoriteIds              // ID избранных персонажей
}
```

### FavoritesViewModel State

```dart
{
  List<Character> _favoriteCharacters,  // Избранные персонажи
  bool _isLoading,                      // Загрузка
  String? _error,                       // Ошибка
  FavoritesSortType _sortType          // Тип сортировки
}
```

## Обработка ошибок

```
API/DataSource Error
    ↓
Repository catches & rethrows / returns null
    ↓
ViewModel catches
    ↓
ViewModel._error = errorMessage
    ↓
ViewModel.notifyListeners()
    ↓
UI shows ErrorView with retry button
```

## Dependency Injection Flow

```
main()
    ↓
ServiceLocator.init()
    ↓
Initialize SharedPreferences
    ↓
Initialize Dio
    ↓
Create DataSources (Remote, Local)
    ↓
Create Repositories (with DataSources)
    ↓
Create ViewModels (with Repositories)
    ↓
Provide ViewModels via MultiProvider
    ↓
App Ready
```

## Навигация Flow

```
User taps BottomNavigationBar Item
    ↓
MainScaffold._onTap(index)
    ↓
navigationShell.goBranch(index)
    ↓
go_router switches StatefulShellBranch
    ↓
Navigates to /characters or /favorites
    ↓
Renders appropriate Screen
    ↓
Screen uses Consumer<ViewModel>
    ↓
UI displays data
```

