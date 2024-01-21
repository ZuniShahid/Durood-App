import 'package:flutter/material.dart';

import 'app_colors.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      splashColor: Colors.grey.withOpacity(0.3),
      splashFactory: InkSparkle.constantTurbulenceSeedSplashFactory,

      primaryColor: isDarkTheme ? Colors.white : AppColors.accentColor,
      iconTheme: IconThemeData(
        color: isDarkTheme ? Colors.white : AppColors.background,
      ),
      scaffoldBackgroundColor: Colors.white,
      indicatorColor:
          isDarkTheme ? const Color(0xff0E1D36) : const Color(0xffCBDCF8),
      hintColor:
          isDarkTheme ? const Color(0xFFA1A8B5) : const Color(0xFFA1A8B5),
      // fontFamily: 'Mont-R',
      hoverColor: isDarkTheme ? AppColors.accentColor : const Color(0xff4285F4),
      focusColor: isDarkTheme ? AppColors.accentColor : const Color(0xffA8DAB5),
      disabledColor: Colors.grey,
      cardColor: isDarkTheme ? const Color(0xFF151515) : Colors.white,
      canvasColor: isDarkTheme ? AppColors.background : Colors.grey[50],
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      progressIndicatorTheme:
          const ProgressIndicatorThemeData(color: AppColors.accentColor),
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
          colorScheme: isDarkTheme
              ? const ColorScheme.dark()
              : const ColorScheme.light()),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 15,
          color: isDarkTheme ? Colors.white : const Color(0xFF272F4B),
        ),
        backgroundColor: isDarkTheme ? Colors.transparent : Colors.transparent,
        foregroundColor: isDarkTheme ? Colors.white : const Color(0xFF272F4B),
        elevation: 0.0,
      ),
      textSelectionTheme: TextSelectionThemeData(
          selectionColor:
              isDarkTheme ? Colors.grey.shade500 : AppColors.background),
      fontFamily: 'Lato',
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.accentColor),
    );
  }
}
