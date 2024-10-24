import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hive/hive.dart';

class Theming {
  static bool? isLight;

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Colors.white, // Основной цвет - белый
      onPrimary: Colors.black, // Черный текст на белом фоне
      secondary: Color.fromRGBO(212, 175, 55, 1), // Золотой для акцентов
      onSecondary: Colors.white, // Белый текст на золотом фоне
      background: Colors.white, // Фон приложения - белый
      onBackground: Colors.black, // Черный текст на белом фоне
      surface: Color.fromRGBO(128, 0, 32, 1), // Бордовый для кнопок и выделений
      onSurface: Colors.white, // Белый текст на бордовом фоне
      error: Colors.red, // Цвет ошибок
      onError: Colors.white, // Цвет текста на фоне ошибок
      tertiary: Color.fromRGBO(
          0, 51, 25, 1), // Темно-зеленый для дополнительных акцентов
      onTertiary: Color.fromRGBO(225, 217, 217, 1),
      inversePrimary: Colors.black,
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(
        fontFamily: 'ElMessiri',
        fontSize: 24,
        overflow: TextOverflow.fade,
        fontWeight: FontWeight.w300,
      ),
      labelMedium: TextStyle(
        fontSize: 16,
        fontFamily: 'ElMessiri',
        fontWeight: FontWeight.w700,
      ),
      titleMedium: TextStyle(),
      bodySmall: TextStyle(
        fontSize: 16,
        fontFamily: 'ElMessiri',
        fontWeight: FontWeight.w700,
      ),
      titleLarge: TextStyle(
        fontFamily: 'ElMessiri',
        fontSize: 36,
        overflow: TextOverflow.fade,
        fontWeight: FontWeight.w300,
      ),
    ),
  );
  static ThemeData blackTheme = ThemeData(
    colorScheme: const ColorScheme.dark(
      inversePrimary: Color.fromRGBO(204, 203, 203, 1),
      brightness: Brightness.dark, // Задаем тему как темную
      primary: Color.fromRGBO(34, 34, 34, 1), // Темно-серый
      onPrimary: Color.fromRGBO(0, 0, 0, 1), // Черный
      secondary: Color.fromRGBO(212, 175, 55, 1), // Золотой
      onSecondary: Color.fromRGBO(0, 0, 0, 1), // Черный текст на золотом фоне
      background: Color.fromRGBO(34, 34, 34, 1), // Основной фон - темно-серый
      onBackground:
          Color.fromRGBO(212, 175, 55, 1), // Золотой текст на сером фоне
      surface: Color.fromRGBO(128, 0, 32, 1), // Бордовый для акцентов
      onSurface: Color.fromRGBO(0, 0, 0, 1), // Черный текст на бордовом фоне
      error: Colors.red, // Цвет для ошибок, можно заменить, если требуется
      onError: Colors.white, // Цвет текста на фоне ошибок
      tertiary: Color(0xFF03763B), // Темно-зеленый для дополнительных акцентов
      onTertiary: Colors.white,
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(
        fontFamily: 'ElMessiri',
        fontSize: 24,
        overflow: TextOverflow.fade,
        fontWeight: FontWeight.w300,
      ),
      labelMedium: TextStyle(
        fontSize: 16,
        fontFamily: 'ElMessiri',
        fontWeight: FontWeight.w700,
      ),
      titleMedium: TextStyle(),
      bodySmall: TextStyle(
        fontSize: 16,
        fontFamily: 'ElMessiri',
        fontWeight: FontWeight.w700,
      ),
      titleLarge: TextStyle(
        fontFamily: 'ElMessiri',
        fontSize: 36,
        overflow: TextOverflow.fade,
        fontWeight: FontWeight.w300,
      ),
    ),
  );
  final NeumorphicThemeData lightNeumorphic = const NeumorphicThemeData(
    baseColor: Color(0xffDDDDDD),
    accentColor: Colors.cyan,
    lightSource: LightSource.topLeft,
    depth: 6,
    intensity: 0.5,
  );

  final NeumorphicThemeData darkNeumorphic = const NeumorphicThemeData(
    baseColor: Color(0xff333333),
    accentColor: Colors.green,
    lightSource: LightSource.topLeft,
    depth: 4,
    intensity: 0.3,
  );

  static get currentThemeData {
    return lightTheme;
  }

  static get currentNeumorphicThemeData {
    return;
  }
}
