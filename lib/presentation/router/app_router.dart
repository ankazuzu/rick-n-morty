import 'package:go_router/go_router.dart';
import '../screens/characters_screen.dart';
import '../screens/favorites_screen.dart';
import '../widgets/main_scaffold.dart';

/// Конфигурация роутинга приложения
class AppRouter {
  AppRouter._();

  static const String characters = '/characters';
  static const String favorites = '/favorites';

  /// Создание конфигурации GoRouter
  static GoRouter createRouter() {
    return GoRouter(
      initialLocation: characters,
      routes: [
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return MainScaffold(navigationShell: navigationShell);
          },
          branches: [
            // Ветка списка персонажей
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: characters,
                  pageBuilder: (context, state) => const NoTransitionPage(
                    child: CharactersScreen(),
                  ),
                ),
              ],
            ),
            // Ветка избранного
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: favorites,
                  pageBuilder: (context, state) => const NoTransitionPage(
                    child: FavoritesScreen(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

