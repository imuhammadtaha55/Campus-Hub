import 'package:flutter/material.dart';

/// Campus Hub theme (Lab 08: custom purple + amber palette).
/// Change these constants to restyle the whole app, including the
/// splash screen, drawer, welcome card and UI Showcase.
class AppTheme {
  AppTheme._();

  static const Color primary = Color(0xFF5E35B1); // deep purple
  static const Color primaryLight = Color(0xFF9575CD); // gradient end
  static const Color accent = Color(0xFFFFB300); // amber
  static const Color soft = Color(0xFFEDE7F6); // light lavender
  static const Color mid = Color(0xFFD1C4E9); // medium lavender
  static const Color background = Color(0xFFF8F6FC);

  static ThemeData get light => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primary,
          secondary: accent,
        ),
        scaffoldBackgroundColor: background,
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          backgroundColor: background,
        ),
        cardTheme: CardThemeData(
          elevation: 1,
          margin: const EdgeInsets.symmetric(vertical: 6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      );
}
