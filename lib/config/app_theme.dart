import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // 🎨 HALLEY BRAND COLORS (Yeni Palet)
  static const primaryYellow = Color(0xFFFFD054); // Ana sarı
  static const primaryGray = Color(0xFF6C6C6D); // Gri
  static const primaryOrange = Color(0xFFF07724); // Turuncu
  
  // UI Colors
  static const primaryColor = primaryYellow;
  static const secondaryColor = primaryGray;
  static const accentColor = primaryOrange;
  
  static const backgroundDark = Color(0xFF1A1A1A);
  static const backgroundLight = Color(0xFF2D2D2D);
  static const cardColor = Color(0xFF2D2D2D);
  
  static const textPrimary = Color(0xFFFFFFFF);
  static const textSecondary = Color(0xFFB8B8B8);
  static const textTertiary = Color(0xFF808080);
  
  // Status Colors (Brand renklerinde)
  static const successColor = primaryYellow;
  static const errorColor = primaryGray;
  static const warningColor = primaryOrange;
  
  // Legacy (eski kodlar için)
  static const halleyYellow = primaryYellow;
  static const halleyGray = primaryGray;
  static const halleyOrange = primaryOrange;
  static const halleyWhite = Color(0xFFF5F5F5);
  static const halleyBlack = Color(0xFF212121);
  
  // Category Colors (Brand palette)
  static const okNotOkColor = primaryYellow;
  static const jealousColor = primaryOrange;
  static const cheatingColor = primaryOrange;
  static const canDoColor = primaryYellow;
  static const angerColor = primaryOrange;
  
  // Gradients
  static const primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryYellow, Color(0xFFFFC042)],
  );
  
  static const secondaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryOrange, Color(0xFFE06519)],
  );
  
  static const darkGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [backgroundDark, backgroundLight],
  );
  
  static const cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF2D2D2D), Color(0xFF252525)],
  );
  
  // Typography (Daha modern)
  static TextTheme textTheme = TextTheme(
    displayLarge: GoogleFonts.poppins(
      fontSize: 42,
      fontWeight: FontWeight.w800,
      color: textPrimary,
      height: 1.1,
      letterSpacing: -1.5,
    ),
    displayMedium: GoogleFonts.poppins(
      fontSize: 34,
      fontWeight: FontWeight.w700,
      color: textPrimary,
      height: 1.2,
      letterSpacing: -0.5,
    ),
    displaySmall: GoogleFonts.poppins(
      fontSize: 28,
      fontWeight: FontWeight.w600,
      color: textPrimary,
      height: 1.2,
    ),
    headlineMedium: GoogleFonts.poppins(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: textPrimary,
      height: 1.3,
    ),
    headlineSmall: GoogleFonts.poppins(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: textPrimary,
      height: 1.3,
    ),
    titleLarge: GoogleFonts.inter(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: textPrimary,
      height: 1.4,
    ),
    bodyLarge: GoogleFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: textSecondary,
      height: 1.5,
    ),
    bodyMedium: GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: textSecondary,
      height: 1.5,
    ),
    bodySmall: GoogleFonts.inter(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: textTertiary,
      height: 1.5,
    ),
    labelLarge: GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      color: textPrimary,
      letterSpacing: 1,
    ),
  );
  
  // Theme Data
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: backgroundDark,
      
      colorScheme: const ColorScheme.dark(
        primary: primaryColor,
        secondary: secondaryColor,
        tertiary: accentColor,
        surface: cardColor,
        error: errorColor,
      ),
      
      textTheme: textTheme,
      
      cardTheme: CardTheme(
        color: cardColor,
        elevation: 8,
        shadowColor: Colors.black26,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
      
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: backgroundDark,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
      ),
      
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: cardColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: textTertiary.withOpacity(0.2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: primaryColor, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        hintStyle: GoogleFonts.inter(
          color: textTertiary,
          fontSize: 14,
        ),
      ),
      
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        iconTheme: const IconThemeData(color: textPrimary),
      ),
    );
  }
  
  // Helper Methods
  static Color getCategoryColor(String category) {
    switch (category) {
      case 'ok_not_ok':
        return okNotOkColor;
      case 'kiskanc':
        return jealousColor;
      case 'aldatma':
        return cheatingColor;
      case 'sevgilim_yapabilir':
        return canDoColor;
      case 'kac_kizarsin':
        return angerColor;
      default:
        return primaryColor;
    }
  }
  
  static LinearGradient getCategoryGradient(String category) {
    final color = getCategoryColor(category);
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        color,
        HSLColor.fromColor(color).withLightness(0.6).toColor(),
      ],
    );
  }
  
  // Shadows
  static List<BoxShadow> get softShadow => [
    BoxShadow(
      color: Colors.black.withOpacity(0.15),
      blurRadius: 20,
      offset: const Offset(0, 4),
    ),
  ];
  
  static List<BoxShadow> get hardShadow => [
    BoxShadow(
      color: Colors.black.withOpacity(0.3),
      blurRadius: 30,
      offset: const Offset(0, 10),
    ),
  ];
  
  static List<BoxShadow> yellowGlow(double opacity) => [
    BoxShadow(
      color: primaryYellow.withOpacity(opacity),
      blurRadius: 30,
      spreadRadius: 5,
    ),
  ];
  
  static List<BoxShadow> orangeGlow(double opacity) => [
    BoxShadow(
      color: primaryOrange.withOpacity(opacity),
      blurRadius: 30,
      spreadRadius: 5,
    ),
  ];
  
  // Animation Durations
  static const Duration fastAnimation = Duration(milliseconds: 200);
  static const Duration normalAnimation = Duration(milliseconds: 300);
  static const Duration slowAnimation = Duration(milliseconds: 500);
  
  // Border Radius
  static const BorderRadius smallRadius = BorderRadius.all(Radius.circular(12));
  static const BorderRadius mediumRadius = BorderRadius.all(Radius.circular(16));
  static const BorderRadius largeRadius = BorderRadius.all(Radius.circular(24));
  static const BorderRadius xlargeRadius = BorderRadius.all(Radius.circular(32));
  
  // Spacing
  static const double spacingXS = 4;
  static const double spacingS = 8;
  static const double spacingM = 16;
  static const double spacingL = 24;
  static const double spacingXL = 32;
  static const double spacingXXL = 48;
}