import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_theme.dart';
import '../viewmodels/favorites_viewmodel.dart';
import '../viewmodels/theme_viewmodel.dart';
import '../widgets/character_card.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/error_view.dart';
import '../widgets/empty_state_view.dart';
import '../widgets/portal_transition.dart';

/// Экран избранных персонажей
class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    // Загрузка избранных персонажей при открытии экрана
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FavoritesViewModel>().loadFavorites();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for AutomaticKeepAliveClientMixin
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Избранное'),
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
          // Кнопка сортировки
          PopupMenuButton<FavoritesSortType>(
            icon: const Icon(Icons.sort),
            onSelected: (sortType) {
              context.read<FavoritesViewModel>().changeSortType(sortType);
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: FavoritesSortType.byName,
                child: Row(
                  children: [
                    Icon(Icons.sort_by_alpha, color: AppTheme.portalGreen),
                    SizedBox(width: 8),
                    Text('По имени'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: FavoritesSortType.byStatus,
                child: Row(
                  children: [
                    Icon(Icons.favorite, color: AppTheme.portalGreen),
                    SizedBox(width: 8),
                    Text('По статусу'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: FavoritesSortType.bySpecies,
                child: Row(
                  children: [
                    Icon(Icons.category, color: AppTheme.portalGreen),
                    SizedBox(width: 8),
                    Text('По виду'),
                  ],
                ),
              ),
            ],
          ),
          // Кнопка очистки всех избранных
          Consumer<FavoritesViewModel>(
            builder: (context, viewModel, child) {
              if (viewModel.favoritesCount == 0) {
                return const SizedBox.shrink();
              }
              return IconButton(
                icon: const Icon(Icons.delete_outline),
                onPressed: () => _showClearConfirmationDialog(context),
              );
            },
          ),
        ],
      ),
      body: Consumer<FavoritesViewModel>(
        builder: (context, viewModel, child) {
          // Состояние загрузки
          if (viewModel.isLoading) {
            return const LoadingIndicator(message: 'Загрузка избранных...');
          }

          // Состояние ошибки
          if (viewModel.error != null && viewModel.favoriteCharacters.isEmpty) {
            return ErrorView(
              message: viewModel.error!,
              onRetry: () => viewModel.loadFavorites(),
            );
          }

          // Пустое состояние
          if (viewModel.favoriteCharacters.isEmpty) {
            return const EmptyStateView(
              icon: Icons.star_border,
              title: 'Нет избранных',
              message:
                  'Добавьте персонажей в избранное, чтобы они отображались здесь',
            );
          }

          // Список избранных персонажей
          return Column(
            children: [
              // Заголовок с количеством
              Container(
                padding: const EdgeInsets.all(16),

                child: Row(
                  children: [
                    Text(
                      'Всего: ${viewModel.favoritesCount}',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      _getSortTypeLabel(viewModel.sortType),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.portalGreen,
                      ),
                    ),
                  ],
                ),
              ),

              // Сетка персонажей
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () => viewModel.refresh(),
                  child: GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.55,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                    itemCount: viewModel.favoriteCharacters.length,
                    itemBuilder: (context, index) {
                      final character = viewModel.favoriteCharacters[index];

                      // Анимация появления и портальный эффект при удалении
                      return PortalEntrance(
                        index: index,
                        child: CharacterCard(
                          character: character,
                          isFavorite: true,
                          onTap: () {
                            // TODO: Переход к детальной информации
                          },
                          onFavoriteToggle: () {
                            _showRemoveConfirmationDialog(
                              context,
                              character.id,
                              character.name,
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  /// Получить название типа сортировки
  String _getSortTypeLabel(FavoritesSortType sortType) {
    switch (sortType) {
      case FavoritesSortType.byName:
        return 'Сортировка: По имени';
      case FavoritesSortType.byStatus:
        return 'Сортировка: По статусу';
      case FavoritesSortType.bySpecies:
        return 'Сортировка: По виду';
    }
  }

  /// Диалог подтверждения удаления персонажа
  void _showRemoveConfirmationDialog(
    BuildContext context,
    int characterId,
    String characterName,
  ) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Удалить из избранного?'),
        content: Text(
          'Вы уверены, что хотите удалить "$characterName" из избранного?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () {
              context.read<FavoritesViewModel>().removeFromFavorites(
                characterId,
              );
              Navigator.of(dialogContext).pop();
            },
            child: const Text(
              'Удалить',
              style: TextStyle(color: AppTheme.statusDead),
            ),
          ),
        ],
      ),
    );
  }

  /// Диалог подтверждения очистки всех избранных
  void _showClearConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Очистить избранное?'),
        content: const Text(
          'Вы уверены, что хотите удалить всех персонажей из избранного?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () {
              context.read<FavoritesViewModel>().clearAllFavorites();
              Navigator.of(dialogContext).pop();
            },
            child: const Text(
              'Очистить',
              style: TextStyle(color: AppTheme.statusDead),
            ),
          ),
        ],
      ),
    );
  }
}
