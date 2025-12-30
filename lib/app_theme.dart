import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: const Color(0xFF09090B), // Deep Void
    textTheme: GoogleFonts.jetbrainsMonoTextTheme(
      ThemeData.dark().textTheme,
    ),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFFF59E0B), // Amber
      secondary: Color(0xFF10B981), // Emerald
      error: Color(0xFFEF4444), // Red
      surface: Color(0xFF18181B),
    ),
  );
}
