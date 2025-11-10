import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rick_morty/core/theme/app_theme.dart';
import 'package:rick_morty/presentation/widgets/character_card.dart';

import '../../helpers/mock_data.dart';

void main() {
  group('CharacterCard Widget', () {
    testWidgets('should display character information', (tester) async {
      // Arrange
      // ignore: unused_local_variable
      bool tapped = false;
      // ignore: unused_local_variable
      bool favoriteTapped = false;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: SizedBox(
              width: 200,
              height: 320,
              child: CharacterCard(
                character: MockData.mockCharacter1,
                isFavorite: false,
                onTap: () => tapped = true,
                onFavoriteToggle: () => favoriteTapped = true,
              ),
            ),
          ),
        ),
      );

      await tester.pump();

      // Assert - проверка текста
      expect(find.text('Rick Sanchez'), findsOneWidget);
      expect(find.text('Alive - Human'), findsOneWidget);
      expect(find.text('Earth (C-137)'), findsOneWidget);

      // Assert - проверка иконок
      expect(find.byIcon(Icons.star_border), findsOneWidget);
      expect(find.byIcon(Icons.location_on), findsOneWidget);
    });

    testWidgets('should show filled star when favorite', (tester) async {
      // Act
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: SizedBox(
              width: 200,
              height: 320,
              child: CharacterCard(
                character: MockData.mockCharacter1,
                isFavorite: true,
                onTap: () {},
                onFavoriteToggle: () {},
              ),
            ),
          ),
        ),
      );

      await tester.pump();

      // Assert - проверяем наличие иконки звезды (может быть в анимации)
      expect(find.byIcon(Icons.star), findsWidgets);
    });

    testWidgets('should call onTap when card is tapped', (tester) async {
      // Arrange
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: SizedBox(
              width: 200,
              height: 320,
              child: CharacterCard(
                character: MockData.mockCharacter1,
                isFavorite: false,
                onTap: () => tapped = true,
                onFavoriteToggle: () {},
              ),
            ),
          ),
        ),
      );

      await tester.pump();

      // Act
      await tester.tap(find.byType(CharacterCard));
      await tester.pump();

      // Assert
      expect(tapped, true);
    });

    testWidgets('should display correct status badge', (tester) async {
      // Act
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: SizedBox(
              width: 200,
              height: 320,
              child: CharacterCard(
                character: MockData.mockDeadCharacter,
                isFavorite: false,
                onTap: () {},
                onFavoriteToggle: () {},
              ),
            ),
          ),
        ),
      );

      await tester.pump();

      // Assert
      expect(find.text('Dead'), findsOneWidget);
    });

    testWidgets('should display image placeholder when loading', (
      tester,
    ) async {
      // Act
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: SizedBox(
              width: 200,
              height: 320,
              child: CharacterCard(
                character: MockData.mockCharacter1,
                isFavorite: false,
                onTap: () {},
                onFavoriteToggle: () {},
              ),
            ),
          ),
        ),
      );

      await tester.pump();

      // Assert - есть CircularProgressIndicator при загрузке
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
