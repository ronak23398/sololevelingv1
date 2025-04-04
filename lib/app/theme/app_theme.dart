// lib/app/theme/app_theme.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final Color primaryColor = Color(0xFF1E88E5);
  static final Color accentColor = Color(0xFF512DA8);
  static final Color backgroundColor = Color(0xFF121212);
  static final Color cardColor = Color(0xFF1E1E1E);
  static final Color textColor = Color(0xFFFFFFFF);
  static final Color subtitleColor = Color(0xFFB3B3B3);

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: backgroundColor,
    primaryColor: primaryColor,
    colorScheme: ColorScheme.dark(
      primary: primaryColor,
      secondary: accentColor,
      background: backgroundColor,
    ),
    cardTheme: CardTheme(
      color: cardColor,
    ),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.poppins(
          color: textColor, fontSize: 26, fontWeight: FontWeight.bold),
      displayMedium: GoogleFonts.poppins(
          color: textColor, fontSize: 22, fontWeight: FontWeight.bold),
      displaySmall: GoogleFonts.poppins(
          color: textColor, fontSize: 18, fontWeight: FontWeight.w600),
      bodyLarge: GoogleFonts.poppins(color: textColor, fontSize: 16),
      bodyMedium: GoogleFonts.poppins(color: textColor, fontSize: 14),
      bodySmall: GoogleFonts.poppins(color: subtitleColor, fontSize: 12),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: primaryColor,
      textTheme: ButtonTextTheme.primary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey[800],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: primaryColor),
      ),
    ),
  );
}
