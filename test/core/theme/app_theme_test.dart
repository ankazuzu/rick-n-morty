import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rick_morty/core/theme/app_theme.dart';

void main() {
  group('AppTheme', () {
    test('lightTheme should have correct properties', () {
      // Arrange & Act
      final theme = AppTheme.lightTheme;

      // Assert
      expect(theme.brightness, Brightness.light);
      expect(theme.primaryColor, AppTheme.portalGreen);
      expect(theme.colorScheme.primary, AppTheme.portalGreen);
      expect(theme.colorScheme.secondary, AppTheme.acidGreen);
    });

    test('darkTheme should have correct properties', () {
      // Arrange & Act
      final theme = AppTheme.darkTheme;

      // Assert
      expect(theme.brightness, Brightness.dark);
      expect(theme.primaryColor, AppTheme.portalGreen);
      expect(theme.scaffoldBackgroundColor, AppTheme.spaceBlack);
      expect(theme.colorScheme.primary, AppTheme.portalGreen);
    });

    test('getStatusColor should return correct color for alive', () {
      // Act
      final color = AppTheme.getStatusColor('alive');

      // Assert
      expect(color, AppTheme.statusAlive);
    });

    test('getStatusColor should return correct color for dead', () {
      // Act
      final color = AppTheme.getStatusColor('dead');

      // Assert
      expect(color, AppTheme.statusDead);
    });

    test('getStatusColor should return correct color for unknown', () {
      // Act
      final color = AppTheme.getStatusColor('unknown');

      // Assert
      expect(color, AppTheme.statusUnknown);
    });

    test('getStatusColor should be case insensitive', () {
      // Act & Assert
      expect(
        AppTheme.getStatusColor('ALIVE'),
        AppTheme.statusAlive,
      );
      expect(
        AppTheme.getStatusColor('DeAd'),
        AppTheme.statusDead,
      );
    });

    test('getStatusColor should return unknown for invalid status', () {
      // Act
      final color = AppTheme.getStatusColor('invalid');

      // Assert
      expect(color, AppTheme.statusUnknown);
    });

    test('theme colors should be Rick and Morty themed', () {
      // Assert
      expect(AppTheme.portalGreen, const Color(0xFF00D9FF));
      expect(AppTheme.acidGreen, const Color(0xFF97CE4C));
      expect(AppTheme.spaceBlack, const Color(0xFF0D1B2A));
      expect(AppTheme.statusAlive, const Color(0xFF55D392));
      expect(AppTheme.statusDead, const Color(0xFFFF5555));
    });
  });
}

