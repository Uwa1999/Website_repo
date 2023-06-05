import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:FDS_ASYA_PHILIPPINES/values/values.dart';

class AppTheme {
  static const _lightFillColor = Colors.black;

  static final Color _lightFocusColor = Colors.black.withOpacity(0.12);

  static ThemeData lightThemeData =
      themeData(lightColorScheme, _lightFocusColor);

  static ThemeData themeData(ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
      textTheme: _textTheme,
      iconTheme: IconThemeData(color: AppColors.white),
      canvasColor: colorScheme.background,
      scaffoldBackgroundColor: colorScheme.background,
      highlightColor: Colors.transparent,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      focusColor: AppColors.maroon450,
      colorScheme: colorScheme.copyWith(secondary: colorScheme.primary),
    );
  }

  static const ColorScheme lightColorScheme = ColorScheme(
    primary: AppColors.maroon450,
    secondary: AppColors.maroon450,
    background: Colors.white,
    surface: Color(0xFFFAFBFB),
    onBackground: AppColors.maroon450,
    error: _lightFillColor,
    onError: _lightFillColor,
    onPrimary: _lightFillColor,
    onSecondary: Color(0xFF322942),
    onSurface: Color(0xFF241E30),
    brightness: Brightness.light,
  );

  // static const _superBold = FontWeight.w900;
  static const _bold = FontWeight.w700;
  // static const _semiBold = FontWeight.w600;
  // static const _medium = FontWeight.w500;
  static const _regular = FontWeight.w400;
  static const _light = FontWeight.w300;

  static final TextTheme _textTheme = TextTheme(
    headline1: GoogleFonts.poppins(
      fontSize: Sizes.TEXT_SIZE_96,
      color: AppColors.black,
      fontWeight: _bold,
      fontStyle: FontStyle.normal,
    ),
    headline2: GoogleFonts.poppins(
      fontSize: Sizes.TEXT_SIZE_60,
      color: AppColors.black,
      fontWeight: _bold,
      fontStyle: FontStyle.normal,
    ),
    headline3: GoogleFonts.poppins(
      fontSize: Sizes.TEXT_SIZE_48,
      color: AppColors.black,
      fontWeight: _bold,
      fontStyle: FontStyle.normal,
    ),
    headline4: GoogleFonts.poppins(
      fontSize: Sizes.TEXT_SIZE_34,
      color: AppColors.black,
      fontWeight: _bold,
      fontStyle: FontStyle.normal,
    ),
    headline5: GoogleFonts.poppins(
      fontSize: Sizes.TEXT_SIZE_24,
      color: AppColors.black,
      fontWeight: _bold,
      fontStyle: FontStyle.normal,
    ),
    headline6: GoogleFonts.poppins(
      fontSize: Sizes.TEXT_SIZE_20,
      color: AppColors.black,
      fontWeight: _bold,
      fontStyle: FontStyle.normal,
    ),
    subtitle1: GoogleFonts.poppins(
      fontSize: Sizes.TEXT_SIZE_18,
      color: AppColors.black,
      fontWeight: _bold,
      fontStyle: FontStyle.normal,
    ),
    subtitle2: GoogleFonts.poppins(
      fontSize: Sizes.TEXT_SIZE_14,
      color: AppColors.black,
      fontWeight: _bold,
      fontStyle: FontStyle.normal,
    ),
    bodyText1: GoogleFonts.poppins(
      fontSize: Sizes.TEXT_SIZE_16,
      color: AppColors.primaryText2,
      fontWeight: _regular,
      fontStyle: FontStyle.normal,
    ),
    bodyText2: GoogleFonts.poppins(
      fontSize: Sizes.TEXT_SIZE_14,
      color: AppColors.black,
      fontWeight: _light,
      fontStyle: FontStyle.normal,
    ),
    button: GoogleFonts.poppins(
      fontSize: Sizes.TEXT_SIZE_16,
      color: AppColors.black,
      fontStyle: FontStyle.normal,
      fontWeight: _regular,
    ),
    caption: GoogleFonts.poppins(
      fontSize: Sizes.TEXT_SIZE_12,
      color: AppColors.primaryText1,
      fontWeight: _regular,
      fontStyle: FontStyle.normal,
    ),
  );
}
