import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';

/// Returns ThemeData based on {isDark} parameter
ThemeData getThemeData({bool isDark = true}) {
  return ThemeData(
    brightness: isDark ? Brightness.dark : Brightness.light,
    scaffoldBackgroundColor:
        isDark ? const Color(0xFF121212) : const Color(0xFFFEFEFE),
    fontFamily: GoogleFonts.lato().fontFamily,
    primaryColor: const Color(0xFF8687E7),
    colorScheme: ColorScheme(
      brightness: isDark ? Brightness.dark : Brightness.light,
      primary: const Color(0xFF8687E7),
      onPrimary: const Color(0xFF2B2B4A),
      secondary: const Color(0xFF8687E7),
      onSecondary: const Color(0xFF2B2B4A),
      error: const Color(0xFFFF4949),
      // onError: const Color(0xFF3A0E0E),
      onError: const Color(0xFFFEFEFE),
      background: isDark ? const Color(0xFF121212) : const Color(0xFFFEFEFE),
      onBackground: isDark ? const Color(0xFFFEFEFE) : const Color(0xFF121212),
      surface: isDark ? const Color(0xFF363636) : const Color(0xFFC8C8C8),
      onSurface: isDark
          ? const Color(0xFFFEFEFE).withOpacity(0.87)
          : const Color(0xFF121212),
    ),
    expansionTileTheme: ExpansionTileThemeData(
      tilePadding: const EdgeInsets.symmetric(horizontal: 10),
      collapsedShape: Border.all(color: Colors.transparent),
      shape: Border.all(color: Colors.transparent),
      childrenPadding: EdgeInsets.zero,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        side: const BorderSide(color: Color(0xFF8687E7)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
      hintStyle: TextStyle(
        color: isDark
            ? const Color(0xFFFEFEFE).withOpacity(0.4)
            : const Color(0xFF121212).withOpacity(0.4),
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor:
          isDark ? const Color(0xFF121212) : const Color(0xFFFEFEFE),
    ),
  );
}

/// onSurface -> Default Color of Text, Icons
/// surface -> Default Color of showModalBottomSheet
