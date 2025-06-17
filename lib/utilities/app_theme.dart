import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData defaultThemeData = ThemeData(
    useMaterial3: true,
    //font family
    scaffoldBackgroundColor: AppColors.white,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
    iconTheme: const IconThemeData(opacity: 0.6),
    fontFamily: 'quicksand',
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: const TextStyle(color: AppColors.grey, fontSize: 14, fontWeight: FontWeight.w500),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide.none, // Invisible border
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide.none, // Invisible border
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide.none, // Invisible border
      ),
      hintStyle: TextStyle(
        color: AppColors.black.withValues(alpha: 0.7),
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 18, color: AppColors.black, fontWeight: FontWeight.w600),
      displayMedium: TextStyle(
        color: AppColors.primaryColor,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      displaySmall: TextStyle(color: AppColors.black, fontSize: 12, fontWeight: FontWeight.w500),
      headlineMedium: TextStyle(color: AppColors.black, fontSize: 16, fontWeight: FontWeight.w600),
      headlineSmall: TextStyle(color: AppColors.black, fontSize: 10, fontWeight: FontWeight.w500),
      labelMedium: TextStyle(color: AppColors.white, fontSize: 16),
      bodyMedium: TextStyle(fontFamily: 'quicksand', color: AppColors.black, fontSize: 15),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
    ),
  );
}
