
import 'package:flutter/material.dart';
import 'package:aerium/values/values.dart';

class AppTheme {
  static const _lightFillColor = Colors.black;

  static final Color _lightFocusColor = Colors.black.withOpacity(0.12);

  static ThemeData lightThemeData =
      themeData(lightColorScheme, _lightFocusColor);

  static ThemeData themeData(ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
      textTheme: _textTheme,
      iconTheme: IconThemeData(color: AppColors.white),
      canvasColor: colorScheme.surface,
      appBarTheme: AppBarTheme(
        color: AppColors.deepBlue700,
      ),
      scaffoldBackgroundColor: colorScheme.surface,
      highlightColor: Colors.transparent,
      focusColor: AppColors.primaryColor,
      visualDensity: VisualDensity.adaptivePlatformDensity, colorScheme: colorScheme.copyWith(secondary: colorScheme.primary),
    );
  }

  static const ColorScheme lightColorScheme = ColorScheme(
    primary: Color(0xFF2C3541),
    secondary:  Color.fromARGB(255, 255, 237, 237),
    surface: Color(0xFFFAFBFB),
    error: _lightFillColor,
    onError: _lightFillColor,
    onPrimary: _lightFillColor,
    onSecondary: Color(0xFF322942),
    onSurface: Color(0xFF241E30),
    brightness: Brightness.light,
  );

//  static const _superBold = FontWeight.w900;
  static const _bold = FontWeight.w700;
  static const _semiBold = FontWeight.w600;
  static const _medium = FontWeight.w500;
  static const _regular = FontWeight.w400;
  static const _light = FontWeight.w300;

//  bebasNeue
// sedgwickAve
//  static final TextTheme _textTheme = TextTheme(
//    headline1: GoogleFonts.raleway(
//      fontSize: Sizes.TEXT_SIZE_96,
//      color: AppColors.primaryColor,
//      fontWeight: _bold,
//      fontStyle: FontStyle.normal,
//    ),
//    headline2: GoogleFonts.raleway(
//      fontSize: Sizes.TEXT_SIZE_60,
//      color: AppColors.primaryColor,
//      fontWeight: _bold,
//      fontStyle: FontStyle.normal,
//    ),
//    headline3: GoogleFonts.raleway(
//      fontSize: Sizes.TEXT_SIZE_48,
//      color: AppColors.primaryColor,
//      fontWeight: _bold,
//      fontStyle: FontStyle.normal,
//    ),
//    headline4: GoogleFonts.raleway(
//      fontSize: Sizes.TEXT_SIZE_34,
//      color: AppColors.primaryColor,
//      fontWeight: _bold,
//      fontStyle: FontStyle.normal,
//    ),
//    headline5: GoogleFonts.raleway(
//      fontSize: Sizes.TEXT_SIZE_24,
//      color: AppColors.primaryColor,
//      fontWeight: _bold,
//      fontStyle: FontStyle.normal,
//    ),
//    headline6: GoogleFonts.raleway(
//      fontSize: Sizes.TEXT_SIZE_20,
//      color: AppColors.primaryColor,
//      fontWeight: _bold,
//      fontStyle: FontStyle.normal,
//    ),
//    subtitle1: GoogleFonts.raleway(
//      fontSize: Sizes.TEXT_SIZE_16,
//      color: AppColors.secondaryColor,
//      fontWeight: _semiBold,
//      fontStyle: FontStyle.normal,
//    ),
//    subtitle2: GoogleFonts.raleway(
//      fontSize: Sizes.TEXT_SIZE_14,
//      color: AppColors.secondaryColor,
//      fontWeight: _semiBold,
//      fontStyle: FontStyle.normal,
//    ),
//    bodyText1: GoogleFonts.raleway(
//      fontSize: Sizes.TEXT_SIZE_16,
//      color: AppColors.secondaryColor,
//      fontWeight: _light,
//      fontStyle: FontStyle.normal,
//      letterSpacing: 3,
//    ),
//    bodyText2: GoogleFonts.raleway(
//      fontSize: Sizes.TEXT_SIZE_14,
//      color: AppColors.secondaryColor,
//      fontWeight: _light,
//      fontStyle: FontStyle.normal,
//      letterSpacing: 3,
//    ),
//    button: GoogleFonts.raleway(
//      fontSize: Sizes.TEXT_SIZE_14,
//      color: AppColors.secondaryColor,
//      fontStyle: FontStyle.normal,
//      fontWeight: _medium,
//    ),
//    caption: GoogleFonts.raleway(
//      fontSize: Sizes.TEXT_SIZE_12,
//      color: AppColors.white,
//      fontWeight: _regular,
//      fontStyle: FontStyle.normal,
//    ),
//  );
  static final TextTheme _textTheme = TextTheme(
    displayLarge: TextStyle(
      fontFamily: StringConst.CIRCE,
      fontSize: Sizes.TEXT_SIZE_96,
      color: AppColors.primaryColor,
      fontWeight: _bold,
      fontStyle: FontStyle.normal,
    ),
    displayMedium: TextStyle(
      fontFamily: StringConst.CIRCE,
      fontSize: Sizes.TEXT_SIZE_60,
      color: AppColors.primaryColor,
      fontWeight: _bold,
      fontStyle: FontStyle.normal,
    ),
    displaySmall: TextStyle(
      fontFamily: StringConst.PROXIMA_NOVA,
      fontSize: Sizes.TEXT_SIZE_48,
      color: AppColors.primaryColor,
      fontWeight: _bold,
      fontStyle: FontStyle.normal,
    ),
    headlineMedium: TextStyle(
      fontFamily: StringConst.CIRCE,
      fontSize: Sizes.TEXT_SIZE_34,
      color: AppColors.primaryColor,
      fontWeight: _bold,
      fontStyle: FontStyle.normal,
    ),
    headlineSmall: TextStyle(
      fontFamily: StringConst.PROXIMA_NOVA,
      fontSize: Sizes.TEXT_SIZE_24,
      color: AppColors.primaryColor,
      fontWeight: _bold,
      fontStyle: FontStyle.normal,
    ),
    titleLarge: TextStyle(
      fontFamily: StringConst.CIRCE,
      fontSize: Sizes.TEXT_SIZE_20,
      color: AppColors.primaryColor,
      fontWeight: _bold,
      fontStyle: FontStyle.normal,
    ),
    titleMedium: TextStyle(
      fontFamily: StringConst.CIRCE,
      fontSize: Sizes.TEXT_SIZE_16,
      color: AppColors.secondaryColor,
      fontWeight: _semiBold,
      fontStyle: FontStyle.normal,
    ),
    titleSmall: TextStyle(
      fontFamily: StringConst.PROXIMA_NOVA,
      fontSize: Sizes.TEXT_SIZE_14,
      color: AppColors.secondaryColor,
      fontWeight: _semiBold,
      fontStyle: FontStyle.normal,
    ),
    bodyLarge: TextStyle(
      fontFamily: StringConst.CIRCE,
      fontSize: Sizes.TEXT_SIZE_16,
      color: AppColors.secondaryColor,
      fontWeight: _regular,
      fontStyle: FontStyle.normal,
    ),
    bodyMedium: TextStyle(
      fontFamily: StringConst.PROXIMA_NOVA,
      fontSize: Sizes.TEXT_SIZE_14,
      color: AppColors.secondaryColor,
      fontWeight: _light,
      fontStyle: FontStyle.normal,
    ),
    labelLarge: TextStyle(
      fontFamily: StringConst.PROXIMA_NOVA,
      fontSize: Sizes.TEXT_SIZE_14,
      color: AppColors.secondaryColor,
      fontStyle: FontStyle.normal,
      fontWeight: _medium,
    ),
    bodySmall: TextStyle(
      fontFamily: StringConst.CIRCE,
      fontSize: Sizes.TEXT_SIZE_12,
      color: AppColors.white,
      fontWeight: _regular,
      fontStyle: FontStyle.normal,
    ),
  );
}
