# Шпаргалка по командам

## 🚀 Основные команды

### Установка и настройка

```bash
# Установить зависимости
flutter pub get

# Обновить зависимости
flutter pub upgrade

# Генерация кода (JSON сериализация)
flutter pub run build_runner build --delete-conflicting-outputs

# Очистка и пересборка (если возникают проблемы)
flutter clean && flutter pub get
```

### Разработка

```bash
# Запуск приложения
flutter run

# Запуск в режиме release
flutter run --release

# Запуск на конкретном устройстве
flutter run -d <device-id>

# Список доступных устройств
flutter devices

# Hot reload (в консоли после flutter run)
r

# Hot restart
R

# Quit
q
```

### Качество кода

```bash
# Анализ кода
flutter analyze

# Проверка форматирования
dart format --set-exit-if-changed .

# Автоформатирование
dart format .

# Запуск тестов
flutter test

# Запуск тестов с покрытием
flutter test --coverage
```

### Сборка

```bash
# Android APK (debug)
flutter build apk

# Android APK (release)
flutter build apk --release

# Android App Bundle (для Google Play)
flutter build appbundle --release

# iOS (требуется Mac)
flutter build ios --release

# Web
flutter build web --release
```

## 🛠️ Build Runner команды

```bash
# Одноразовая генерация кода
flutter pub run build_runner build

# Генерация с удалением конфликтующих файлов
flutter pub run build_runner build --delete-conflicting-outputs

# Watch режим (автоматическая перегенерация при изменениях)
flutter pub run build_runner watch

# Очистка сгенерированных файлов
flutter pub run build_runner clean
```

## 🐛 Отладка

```bash
# Запуск с дебаг логами
flutter run -v

# Очистка кеша
flutter clean

# Проверка установки Flutter
flutter doctor

# Детальная проверка
flutter doctor -v

# Обновление Flutter
flutter upgrade
```

## 📦 Зависимости

```bash
# Добавить зависимость
flutter pub add <package_name>

# Добавить dev зависимость
flutter pub add --dev <package_name>

# Удалить зависимость
flutter pub remove <package_name>

# Проверить устаревшие пакеты
flutter pub outdated
```

## 🎨 Специфичные для проекта

### Работа с ViewModels

```dart
// Доступ к ViewModel через Provider
context.read<CharactersViewModel>()   // Без rebuild
context.watch<CharactersViewModel>()  // С rebuild
```

### Навигация

```dart
// Переход на экран персонажей
context.go('/characters')

// Переход на экран избранного
context.go('/favorites')
```

## 📊 Полезные команды для мониторинга

```bash
# Производительность приложения
flutter run --profile

# Анализ размера приложения
flutter build apk --analyze-size
flutter build appbundle --analyze-size

# Проверка неиспользуемых зависимостей
dart pub deps
```

## 🔧 Решение проблем

### Проблемы с зависимостями

```bash
flutter clean
rm -rf .dart_tool/
rm pubspec.lock
flutter pub get
```

### Проблемы с build_runner

```bash
flutter pub run build_runner clean
flutter packages pub run build_runner build --delete-conflicting-outputs
```

### Проблемы с iOS (Mac only)

```bash
cd ios
pod install
cd ..
flutter clean
flutter run
```

### Проблемы с Android

```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter run
```

## 📱 Эмуляторы

```bash
# Список эмуляторов
flutter emulators

# Запуск эмулятора
flutter emulators --launch <emulator_id>

# Android эмулятор
emulator -avd <avd_name>

# iOS симулятор (Mac only)
open -a Simulator
```

## 🔍 Профилирование

```bash
# Запуск с профилированием
flutter run --profile

# Открыть DevTools
flutter pub global activate devtools
flutter pub global run devtools
```

## 📈 Логирование

```bash
# Просмотр логов Android
adb logcat

# Фильтрация логов Flutter
adb logcat | grep flutter

# Очистка логов
adb logcat -c
```

## 🎯 Быстрые команды для разработки

```bash
# Полная перезагрузка проекта
flutter clean && flutter pub get && flutter pub run build_runner build --delete-conflicting-outputs && flutter run

# Проверка качества кода
flutter analyze && dart format --set-exit-if-changed . && flutter test

# Сборка релиза для Android
flutter build apk --release && flutter build appbundle --release
```

## ⚡ Алиасы (добавить в ~/.zshrc или ~/.bashrc)

```bash
alias frun='flutter run'
alias ftest='flutter test'
alias fclean='flutter clean'
alias fpub='flutter pub get'
alias fanalyze='flutter analyze'
alias fbuild='flutter pub run build_runner build --delete-conflicting-outputs'
alias freload='flutter clean && flutter pub get && flutter pub run build_runner build --delete-conflicting-outputs'
```

