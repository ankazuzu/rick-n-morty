import 'package:flutter/material.dart';

/// Тема приложения в стиле Rick and Morty
class AppTheme {
  AppTheme._();

  // Rick and Morty цветовая палитра
  static const Color portalGreen = Color(0xFF00D9FF); // Ярко-бирюзовый портал
  static const Color acidGreen = Color(0xFF97CE4C); // Кислотно-зеленый
  static const Color rickBlue = Color(0xFF44B3C2); // Синий халат Рика
  static const Color spaceBlack = Color(0xFF0D1B2A); // Космический черный
  static const Color labYellow = Color(0xFFF6DC6F); // Желтый лаборатории
  static const Color portalPurple = Color(0xFF7D5BA6); // Фиолетовый портала
  static const Color neonPink = Color(0xFFFF6EC7); // Неоновый розовый

  // Статусы персонажей (в стиле сериала)
  static const Color statusAlive = Color(0xFF55D392); // Ярко-зеленый
  static const Color statusDead = Color(0xFFFF5555); // Красный
  static const Color statusUnknown = Color(0xFF9E9E9E); // Серый

  /// Светлая тема в стиле Rick and Morty
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: portalGreen,
      scaffoldBackgroundColor: const Color(0xFFF5F8FA),
      colorScheme: const ColorScheme.light(
        primary: portalGreen,
        secondary: acidGreen,
        surface: Colors.white,
        error: statusDead,
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 3,
        shadowColor: portalGreen.withValues(alpha: 0.2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: portalGreen.withValues(alpha: 0.1), width: 1),
        ),
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: portalGreen,
        foregroundColor: Colors.white,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: portalGreen,
        unselectedItemColor: Color(0xFF757575),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: spaceBlack,
        ),
        headlineMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: spaceBlack,
        ),
        bodyLarge: TextStyle(fontSize: 16, color: Color(0xFF212121)),
        bodyMedium: TextStyle(fontSize: 14, color: Color(0xFF424242)),
        bodySmall: TextStyle(fontSize: 12, color: Color(0xFF757575)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFFF0F0F0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: portalGreen, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
    );
  }

  /// Темная тема в стиле Rick and Morty (космос/портал)
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: portalGreen,
      scaffoldBackgroundColor: spaceBlack,
      colorScheme: const ColorScheme.dark(
        primary: portalGreen,
        secondary: acidGreen,
        surface: Color(0xFF1A2332),
        error: statusDead,
        onPrimary: Colors.black,
        onSecondary: Colors.black,
      ),
      cardTheme: CardThemeData(
        color: const Color(0xFF1A2332),
        elevation: 4,
        shadowColor: portalGreen.withValues(alpha: 0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: portalGreen.withValues(alpha: 0.3), width: 1),
        ),
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color(0xFF0F1821),
        foregroundColor: portalGreen,
        titleTextStyle: TextStyle(
          color: portalGreen,
          fontSize: 22,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFF0F1821),
        selectedItemColor: portalGreen,
        unselectedItemColor: Color(0xFF6B7B8C),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: portalGreen,
        ),
        headlineMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        bodyLarge: TextStyle(fontSize: 16, color: Colors.white),
        bodyMedium: TextStyle(fontSize: 14, color: Color(0xFFE0E0E0)),
        bodySmall: TextStyle(fontSize: 12, color: Color(0xFFB0B0B0)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF1A2332),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: portalGreen, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
    );
  }

  /// Получить цвет по статусу персонажа
  static Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'alive':
        return statusAlive;
      case 'dead':
        return statusDead;
      default:
        return statusUnknown;
    }
  }
}
