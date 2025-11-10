import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/characters_viewmodel.dart';
import '../viewmodels/theme_viewmodel.dart';
import '../widgets/character_card.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/error_view.dart';
import '../widgets/empty_state_view.dart';
import '../widgets/portal_transition.dart';

/// Главный экран со списком персонажей
class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  final _scrollController = ScrollController();
  final _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();

    // Загрузка персонажей при открытии экрана
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CharactersViewModel>().loadCharacters();
    });

    // Слушатель для пагинации
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  /// Обработчик скролла для пагинации
  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      final viewModel = context.read<CharactersViewModel>();
      if (!viewModel.isLoadingMore && viewModel.hasNextPage) {
        viewModel.loadMoreCharacters();
      }
    }
  }

  /// Обработчик поиска
  void _onSearchChanged(String query) {
    // Дебаунс поиска
    Future.delayed(const Duration(milliseconds: 500), () {
      if (query == _searchController.text && mounted) {
        context.read<CharactersViewModel>().searchCharacters(query);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isSearching ? _buildSearchField() : const Text('Персонажи'),
        actions: [
          // Кнопка переключения темы
          Consumer<ThemeViewModel>(
            builder: (context, themeViewModel, child) {
              return IconButton(
                icon: Icon(
                  themeViewModel.isDarkMode
                      ? Icons.light_mode
                      : Icons.dark_mode,
                ),
                onPressed: () => themeViewModel.toggleTheme(),
                tooltip: themeViewModel.isDarkMode
                    ? 'Светлая тема'
                    : 'Темная тема',
              );
            },
          ),
          // Кнопка поиска
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  _searchController.clear();
                  context.read<CharactersViewModel>().loadCharacters();
                }
              });
            },
          ),
        ],
      ),
      body: Consumer<CharactersViewModel>(
        builder: (context, viewModel, child) {
          // Состояние загрузки
          if (viewModel.isLoading && viewModel.characters.isEmpty) {
            return const LoadingIndicator(message: 'Загрузка персонажей...');
          }

          // Состояние ошибки
          if (viewModel.error != null && viewModel.characters.isEmpty) {
            return ErrorView(
              message: viewModel.error!,
              onRetry: () => viewModel.loadCharacters(),
            );
          }

          // Пустое состояние
          if (viewModel.characters.isEmpty) {
            return EmptyStateView(
              icon: Icons.search_off,
              title: 'Ничего не найдено',
              message: 'Попробуйте изменить параметры поиска',
              action: ElevatedButton.icon(
                onPressed: () {
                  _searchController.clear();
                  viewModel.loadCharacters();
                },
                icon: const Icon(Icons.refresh),
                label: const Text('Сбросить поиск'),
              ),
            );
          }

          // Список персонажей
          return RefreshIndicator(
            onRefresh: () => viewModel.refresh(),
            child: GridView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.55,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount:
                  viewModel.characters.length +
                  (viewModel.isLoadingMore ? 2 : 0),
              itemBuilder: (context, index) {
                // Индикатор загрузки следующей страницы
                if (index >= viewModel.characters.length) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                final character = viewModel.characters[index];

                // Анимация появления карточек
                return PortalEntrance(
                  index: index,
                  child: CharacterCard(
                    character: character,
                    isFavorite: viewModel.isFavorite(character.id),
                    onTap: () {
                      // TODO: Переход к детальной информации
                    },
                    onFavoriteToggle: () {
                      viewModel.toggleFavorite(character.id);
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  /// Поле поиска
  Widget _buildSearchField() {
    return TextField(
      controller: _searchController,
      autofocus: true,
      decoration: const InputDecoration(
        hintText: 'Поиск персонажей...',
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.white70),
      ),
      style: const TextStyle(color: Colors.white),
      onChanged: _onSearchChanged,
    );
  }
}
