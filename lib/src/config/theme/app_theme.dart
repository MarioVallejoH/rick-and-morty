import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rick_and_morty_app/src/config/config.dart';
import 'package:rick_and_morty_app/src/utils/constants/sizes.dart';

/// App theme.
///
/// Class used to manage theme data on app.
ThemeData globalTheme() {
  TextTheme globalTextTheme(TextTheme textTheme) {
    /// TODO: Set text color with detail
    return textTheme.copyWith(
      headlineLarge: textTheme.headlineLarge?.copyWith(
        fontWeight: FontWeight.w700,
        fontSize: 40,
        color: Colors.white,
      ),
      headlineMedium: textTheme.headlineMedium?.copyWith(
        fontWeight: FontWeight.w700,
        fontSize: 32,
        color: Colors.white,
      ),
      headlineSmall: textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.w700,
        fontSize: 24.0,
        color: Colors.white,
      ),
      displayLarge: textTheme.displayLarge?.copyWith(
        fontWeight: FontWeight.w700,
        fontSize: 55.0,
        color: Colors.white,
      ),
      displayMedium: textTheme.displayMedium?.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 16,
        color: Colors.white,
      ),
      displaySmall: textTheme.displaySmall?.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 10.0,
        color: Colors.white,
      ),
      titleLarge: textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w700,
        fontSize: 55.0,
        color: Colors.white,
      ),
      titleMedium: textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 16,
        color: Colors.white,
      ),
      titleSmall: textTheme.titleSmall?.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 14.0,
        color: Colors.white,
      ),
      labelLarge: textTheme.labelLarge?.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 16.0,
        color: Colors.white,
      ),
      labelMedium: textTheme.labelMedium?.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 16.0,
        color: Colors.white,
      ),
      labelSmall: textTheme.labelSmall?.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 16.0,
        color: Colors.white,
      ),
      bodyLarge: textTheme.bodyLarge?.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 16.0,
        color: Colors.white,
      ),
      bodyMedium: textTheme.bodyMedium?.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 14.0,
        color: Colors.white,
      ),
      bodySmall: textTheme.bodySmall?.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 10.0,
        color: Colors.white,
      ),
    );
  }

  /// Take defined colors from design.
  ColorScheme colorSchemeTheme(ColorScheme themeColor) {
    return themeColor.copyWith(
      primary: AppColors.primary_300,
      inversePrimary: AppColors.primary_300,
      primaryContainer: AppColors.primary_200,
      outline: AppColors.primary_300,
      secondary: Colors.white,
      onSecondary: const Color(0xffFBFBFB),
      onPrimary: const Color(0xffEBF1FF),
      tertiary: Colors.white,
      onTertiaryContainer: const Color(0xffD9DBD8),
      onPrimaryContainer: AppColors.primary_50,
      background: Colors.white,
      error: AppColors.danger_700,
      onError: Colors.white,
    );
  }

  ButtonThemeData buttonThemeData(ButtonThemeData themeButtonTheme) {
    return themeButtonTheme.copyWith(
      buttonColor: AppColors.primary_300,
      disabledColor: AppColors.secondary_300,
    );
  }

  InputDecorationTheme inputDecorationTheme(InputDecorationTheme theme) {
    final border = UnderlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.genericBorderRadius),
      borderSide: const BorderSide(
        color: AppColors.primary_300,
        width: 0.3,
      ),
    );
    final focusedBorder = UnderlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.genericBorderRadius),
      borderSide: const BorderSide(
        color: AppColors.primary_300,
        width: 0.3,
      ),
    );
    final errorBorder = UnderlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.genericBorderRadius),
      borderSide: const BorderSide(
        color: Color(0xffaa3030),
        width: 1,
      ),
    );
    const outlineBorder = BorderSide.none;
    return theme.copyWith(
      border: border,
      filled: true,
      fillColor: AppColors.secondary_50,
      focusedBorder: focusedBorder,
      enabledBorder: border,
      errorBorder: errorBorder,
      outlineBorder: outlineBorder,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
      alignLabelWithHint: true,
      labelStyle: theme.labelStyle?.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 16.0,
        color: AppColors.secondary_500,
      ),
      floatingLabelStyle: theme.labelStyle?.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 16.0,
        color: AppColors.secondary_500,
      ),
      errorStyle: theme.labelStyle?.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 16.0,
        color: AppColors.danger_400,
      ),
      hintStyle: theme.hintStyle?.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 16.0,
        color: AppColors.secondary_500,
      ),
    );
  }

  BottomNavigationBarThemeData bottomBarThemeData(
    BottomNavigationBarThemeData bottomNavBarThemeData,
  ) {
    return bottomNavBarThemeData.copyWith(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.white,
      unselectedItemColor: const Color(0xffE0DFE0),
      selectedLabelStyle: bottomNavBarThemeData.selectedLabelStyle?.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 14.0,
        color: Colors.white,
      ),
      selectedIconTheme: bottomNavBarThemeData.selectedIconTheme?.copyWith(
        color: Colors.white,
      ),
      unselectedIconTheme: bottomNavBarThemeData.unselectedIconTheme?.copyWith(
        color: const Color(0xffE0DFE0),
      ),
    );
  }

  ListTileThemeData listTileThemeData(
    ListTileThemeData listTileThemeData,
  ) {
    return listTileThemeData.copyWith(iconColor: AppColors.primary_300);
  }

  final ThemeData theme = ThemeData.light();

  return theme.copyWith(
    primaryColor: AppColors.primary_400,
    shadowColor: Colors.grey,
    scaffoldBackgroundColor: AppColors.backgroundVariant,
    textTheme: globalTextTheme(
      GoogleFonts.latoTextTheme(
        theme.textTheme,
      ),
    ),
    buttonTheme: buttonThemeData(theme.buttonTheme),
    inputDecorationTheme: inputDecorationTheme(theme.inputDecorationTheme),
    appBarTheme: const AppBarTheme(
      centerTitle: false,
      color: Colors.transparent,
      iconTheme: IconThemeData(
        color: Color.fromRGBO(255, 255, 255, 1),
        size: 24.0,
      ),
    ),
    bottomNavigationBarTheme: bottomBarThemeData(
      theme.bottomNavigationBarTheme,
    ),
    listTileTheme: listTileThemeData(theme.listTileTheme),
    colorScheme: colorSchemeTheme(theme.colorScheme)
        .copyWith(background: AppColors.background),
  );
}
