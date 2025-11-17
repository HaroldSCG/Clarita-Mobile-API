import 'package:flutter/material.dart';

class AppColors {
  static const Color background = Color(0xFF050814);
  static const Color surface = Color(0xFF0B1020);
  static const Color surfaceAlt = Color(0xFF11182A);

  static const Color pink = Color(0xFFE91E63);
  static const Color purple = Color(0xFF9C27B0);
  static const Color orange = Color(0xFFFF7043);
  static const Color green = Color(0xFF00C853);

  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFFB0B8D0);
}

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,

      colorScheme: const ColorScheme.dark(
        primary: AppColors.pink,
        secondary: AppColors.purple,
        surface: AppColors.surface,
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        centerTitle: false,
      ),

      textTheme: const TextTheme(
        titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
        titleMedium: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        bodyMedium: TextStyle(
          color: AppColors.textSecondary,
        ),
      ),

      cardTheme: CardThemeData(
        color: AppColors.surfaceAlt,
        elevation: 3,
        margin: const EdgeInsets.only(bottom: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceAlt,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        hintStyle: const TextStyle(color: AppColors.textSecondary),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.pink,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
