import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/di/service_locator.dart';
import 'core/theme/app_theme.dart';
import 'presentation/router/app_router.dart';
import 'presentation/viewmodels/characters_viewmodel.dart';
import 'presentation/viewmodels/favorites_viewmodel.dart';
import 'presentation/viewmodels/theme_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Инициализация зависимостей
  final serviceLocator = ServiceLocator();
  await serviceLocator.init();

  runApp(RickMortyApp(serviceLocator: serviceLocator));
}

/// Главный виджет приложения
class RickMortyApp extends StatelessWidget {
  final ServiceLocator serviceLocator;

  const RickMortyApp({super.key, required this.serviceLocator});

  @override
  Widget build(BuildContext context) {
    final router = AppRouter.createRouter();

    // Связываем ViewModels для двусторонней синхронизации избранного
    serviceLocator.charactersViewModel.onFavoritesChanged = () {
      serviceLocator.favoritesViewModel.loadFavorites(silent: true);
    };

    serviceLocator.favoritesViewModel.onFavoritesChanged = () {
      serviceLocator.charactersViewModel.refreshFavorites();
    };

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CharactersViewModel>(
          create: (_) => serviceLocator.charactersViewModel,
        ),
        ChangeNotifierProvider<FavoritesViewModel>(
          create: (_) => serviceLocator.favoritesViewModel,
        ),
        ChangeNotifierProvider<ThemeViewModel>(
          create: (_) => serviceLocator.themeViewModel,
        ),
      ],
      child: Consumer<ThemeViewModel>(
        builder: (context, themeViewModel, child) {
          return MaterialApp.router(
            title: 'Rick and Morty',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeViewModel.themeMode,
            routerConfig: router,
          );
        },
      ),
    );
  }
}
